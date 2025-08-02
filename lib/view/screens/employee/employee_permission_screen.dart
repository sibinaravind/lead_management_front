import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/view/widgets/popup_text_form_filed.dart';
import 'package:overseas_front_end/view/widgets/custom_shimmer_widget.dart';
import '../../../controller/permission_controller/access_permission_controller.dart';
import '../../../core/services/navigation_service.dart';
import '../../../utils/style/colors/colors.dart';
import '../../../utils/style/colors/dimension.dart';
import '../../widgets/custom_toast.dart';

class AccessPermissionScreen extends StatefulWidget {
  const AccessPermissionScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _AccessPermissionScreenState createState() => _AccessPermissionScreenState();
}

class _AccessPermissionScreenState extends State<AccessPermissionScreen> {
  // GetX Controller
  final AccessPermissionController controller =
      Get.find<AccessPermissionController>();
  // Local state
  late Map<String, Map<String, bool>> permissions = {};
  late List<String> roles = [];
  late List<PermissionData> permissionsList = [];
  bool showOnlyEnabled = false;
  final TextEditingController searchController = TextEditingController();
  final TextEditingController permissionRole = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _initializeData();
    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text;
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    permissionRole.dispose();
    super.dispose();
  }

  void _initializeData() {
    ever(controller.permissions, (_) => _buildPermissionsFromController());
    if (controller.permissions.isNotEmpty) {
      _buildPermissionsFromController();
    }
  }

  void _buildPermissionsFromController() {
    final data = controller.permissions;

    permissions = {
      for (var item in data) item.category.toLowerCase(): item.value,
    };
    roles = permissions.keys.toList();

    final Set<String> allPermissionKeys =
        permissions.values.expand((permMap) => permMap.keys).toSet();

    permissionsList = allPermissionKeys.map((permissionKey) {
      return PermissionData(
        name: permissionKey,
        displayName: _formatPermissionDisplayName(permissionKey),
        icon: _getPermissionIcon(permissionKey),
        rolePermissions: {
          for (var role in roles)
            role: permissions[role]?[permissionKey] ?? false,
        },
      );
    }).toList();

    if (mounted) setState(() {});
  }

  // Helper methods (same as original)
  Color _getRoleColor(int index) =>
      AppColors.roleColors[index % AppColors.roleColors.length];

  IconData _getRoleIcon(String role) {
    switch (role.toLowerCase()) {
      case 'admin':
        return Icons.admin_panel_settings;
      case 'manager':
        return Icons.manage_accounts;
      case 'counselor':
        return Icons.psychology;
      case 'front_desk':
        return Icons.desk;
      case 'documentation':
        return Icons.folder_open;
      case 'visa':
        return Icons.flight_takeoff;
      default:
        return Icons.person;
    }
  }

  String _formatRoleName(String role) =>
      role.split('_').map((word) => word.toUpperCase()).join(' ');

  String _formatPermissionDisplayName(String key) =>
      key.split('_').map((e) => e.toUpperCase()).join(' ');

  IconData _getPermissionIcon(String key) {
    if (key.contains('view')) return Icons.visibility;
    if (key.contains('edit')) return Icons.edit;
    if (key.contains('delete')) return Icons.delete;
    if (key.contains('manage')) return Icons.settings;
    if (key.contains('assign')) return Icons.assignment;
    if (key.contains('update')) return Icons.system_update_alt;
    if (key.contains('handle')) return Icons.directions_walk;
    return Icons.shield;
  }

  void _togglePermission(String role, String permission) async {
    // Optimistic update
    setState(() {
      permissions[role]![permission] = !permissions[role]![permission]!;
      int index = permissionsList.indexWhere((p) => p.name == permission);
      if (index != -1) {
        permissionsList[index].rolePermissions[role] =
            permissions[role]![permission]!;
      }
    });
    final success = await controller.patchAccessPermissions(
      category: role.toUpperCase(),
      updatedFields: [
        {"field": permission, "value": permissions[role]![permission]}
      ],
    );
    if (!success) {
      // Revert the toggle on failure
      setState(() {
        permissions[role]![permission] = !permissions[role]![permission]!;
        int index = permissionsList.indexWhere((p) => p.name == permission);
        if (index != -1) {
          permissionsList[index].rolePermissions[role] =
              permissions[role]![permission]!;
        }
      });
    }
  }

  List<PermissionData> _getFilteredPermissions() {
    return permissionsList.where((permission) {
      bool matchesSearch = permission.displayName
          .toLowerCase()
          .contains(searchQuery.toLowerCase());
      bool matchesFilter = !showOnlyEnabled ||
          permission.rolePermissions.values.any((enabled) => enabled);
      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
          children: [
            Scaffold(
              body: Container(
                decoration:
                    const BoxDecoration(gradient: AppColors.backgroundGraident),
                child: SafeArea(
                  child: controller.isLoading
                      ? ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) =>
                              const CustomShimmerWidget(),
                        )
                      : Column(
                          children: [
                            _buildRoleSummaryCards(),
                            Expanded(child: _buildPermissionsTable()),
                          ],
                        ),
                ),
              ),
            ),
            if (controller.isPatching)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(child: CircularProgressIndicator()),
              )
          ],
        ));
  }

  Widget _buildRoleSummaryCards() {
    return Container(
      height: 120,
      margin: const EdgeInsets.all(20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: roles.length + 1,
        itemBuilder: (context, index) {
          if (index == roles.length) {
            return _buildAddRoleCard();
          }
          String role = roles[index];
          int enabledCount =
              permissions[role]!.values.where((enabled) => enabled).length;
          int totalCount = permissions[role]!.length;

          return _buildRoleCard(role, index, enabledCount, totalCount);
        },
      ),
    );
  }

  Widget _buildAddRoleCard() {
    return InkWell(
      onTap: _onAddNewRole,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_circle_outline,
                  color: AppColors.primaryColor, size: 32),
              SizedBox(height: 8),
              Text(
                'Add Role',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard(
      String role, int index, int enabledCount, int totalCount) {
    return Stack(
      children: [
        Container(
          width: 140,
          margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: InkWell(
            onDoubleTap: () => _onDeleteRole(role),
            borderRadius: BorderRadius.circular(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _getRoleColor(index).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getRoleIcon(role),
                    color: _getRoleColor(index),
                    size: 20,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _formatRoleName(role),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  '$enabledCount/$totalCount',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _getRoleColor(index),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (role.toLowerCase() != 'admin')
          Positioned(
            top: 4,
            right: 4,
            child: IconButton(
              icon: const Icon(Icons.delete, size: 18, color: Colors.red),
              onPressed: () => _onDeleteRole(role),
            ),
          ),
      ],
    );
  }

  void _onAddNewRole() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Insert Role"),
        content: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PopupTextField(
                controller: permissionRole,
                label: 'Role',
                icon: Icons.person_outline_outlined,
                hint: 'Role',
                requiredField: true,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => NavigationService.goBack(),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _handleAddRole(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 2,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add, size: 18),
                        SizedBox(width: 8),
                        Text(
                          'Insert Role',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleAddRole() async {
    if (permissionRole.text.trim().isEmpty) {
      CustomToast.showToast(context: context, message: 'Role cannot be empty');
      return;
    }
    NavigationService.goBack(); // Close dialog
    final defaultPermissions = {
      "view_all_leads": false,
      "edit_lead": false,
      "delete_lead": false,
      "manage_users": false,
      "manage_constants": false,
      "view_reports": false,
      "assign_leads": false,
      "update_visa_status": false,
      "manage_documents": false,
      "handle_walkins": false,
      "update_counseling_status": false
    };

    final success = await controller.addAccessPermission(
      category: permissionRole.text.toUpperCase(),
      value: defaultPermissions,
    );

    if (success) {
      _buildPermissionsFromController();
      permissionRole.clear();
    }
  }

  void _onDeleteRole(String role) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: Text('Do you want to delete "$role" Role?'),
        actions: [
          TextButton(
            onPressed: () => NavigationService.goBack(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              NavigationService.goBack();
              final success =
                  await controller.deleteAccessPermission(role.toUpperCase());
              if (success) {
                _buildPermissionsFromController();
              }
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionsTable() {
    List<PermissionData> filteredPermissions = _getFilteredPermissions();

    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildTableHeader(),
          Expanded(
            child: ListView.builder(
              itemCount: filteredPermissions.length,
              itemBuilder: (context, index) {
                return _buildPermissionRow(filteredPermissions[index], index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: AppColors.buttonGraidentColour,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Dimension().isMobile(context)
          ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(
                    width: 150,
                    child: Text(
                      'Permission',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ...roles.map((role) => SizedBox(
                        width: 100,
                        child: Text(
                          _formatRoleName(role),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )),
                ],
              ),
            )
          : Row(
              children: [
                const Expanded(
                  flex: 3,
                  child: Text(
                    'Permission',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                ...roles.map((role) => Expanded(
                      child: Text(
                        _formatRoleName(role),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )),
              ],
            ),
    );
  }

  Widget _buildPermissionRow(PermissionData permission, int index) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: index.isEven ? Colors.grey[50] : Colors.white,
        border: const Border(bottom: BorderSide(color: Colors.grey, width: 1)),
      ),
      child: MediaQuery.of(context).size.width < 500
          ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(
                    width: 150,
                    child: _buildPermissionInfo(permission),
                  ),
                  ...roles.map((role) => SizedBox(
                        width: 100,
                        child: Center(
                          child: _buildToggleSwitch(permission, role),
                        ),
                      )),
                ],
              ),
            )
          : Row(
              children: [
                Expanded(
                  flex: 3,
                  child: _buildPermissionInfo(permission),
                ),
                ...roles.map((role) => Expanded(
                      child: Center(
                        child: _buildToggleSwitch(permission, role),
                      ),
                    )),
              ],
            ),
    );
  }

  Widget _buildPermissionInfo(PermissionData permission) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.violetPrimaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            permission.icon,
            color: AppColors.violetPrimaryColor,
            size: 16,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            permission.displayName,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildToggleSwitch(PermissionData permission, String role) {
    return GestureDetector(
      onTap: () => _togglePermission(role, permission.name),
      child: Container(
        width: 50,
        height: 28,
        decoration: BoxDecoration(
          color: permission.rolePermissions[role]!
              ? AppColors.greenSecondaryColor
              : AppColors.redSecondaryColor,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              alignment: permission.rolePermissions[role]!
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              duration: const Duration(milliseconds: 200),
              child: Container(
                width: 24,
                height: 24,
                margin: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  permission.rolePermissions[role]! ? Icons.check : Icons.close,
                  size: 12,
                  color: permission.rolePermissions[role]!
                      ? AppColors.greenSecondaryColor
                      : AppColors.redSecondaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Extension and Data class remain the same
extension StringExtension on String {
  String capitalize() => this[0].toUpperCase() + substring(1);
}

class PermissionData {
  final String name;
  final String displayName;
  final IconData icon;
  final Map<String, bool> rolePermissions;

  PermissionData({
    required this.name,
    required this.displayName,
    required this.icon,
    required this.rolePermissions,
  });
}

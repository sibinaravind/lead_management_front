import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controller/permission_conteroller/access_permission_controller.dart';
import 'package:overseas_front_end/view/widgets/custom_shimmer_widget.dart';
import '../../../res/style/colors/colors.dart';

class AccessPermissionScreen extends StatefulWidget {
  const AccessPermissionScreen({super.key});

  @override
  _AccessPermissionScreenState createState() => _AccessPermissionScreenState();
}

class _AccessPermissionScreenState extends State<AccessPermissionScreen> {
  late Map<String, Map<String, bool>> permissions;
  late List<String> roles = [];
  late List<PermissionData> permissionsList = [];
  bool showOnlyEnabled = false;
  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final provider =
          Provider.of<AccessPermissionProvider>(context, listen: false);
      provider.fetchAccessPermissions().then((_) {
        if (provider.accessPermission != null) {
          _buildPermissionsFromAPI(provider);
        }
      });
    });
    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text;
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _buildPermissionsFromAPI(AccessPermissionProvider provider) {
    final data = provider.accessPermission;
    permissions = {
      'admin': data?.admin ?? {},
      'counselor': data?.counselor ?? {},
      'manager': data?.manager ?? {},
      'front_desk': data?.frontDesk ?? {},
      'documentation': data?.documentation ?? {},
      'visa': data?.visa ?? {},
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

    setState(() {});
  }

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
      role.split('_').map((word) => word.capitalize()).join(' ');

  String _formatPermissionDisplayName(String key) =>
      key.split('_').map((e) => e.capitalize()).join(' ');

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
    setState(() {
      permissions[role]![permission] = !permissions[role]![permission]!;
      int index = permissionsList.indexWhere((p) => p.name == permission);
      if (index != -1) {
        permissionsList[index].rolePermissions[role] =
            permissions[role]![permission]!;
      }
    });

    final provider =
        Provider.of<AccessPermissionProvider>(context, listen: false);
    final success = await provider.patchAccessPermissions(
      category: role,
      updatedFields: [
        {"field": permission, "value": permissions[role]![permission]}
      ],
    );

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(provider.error ?? "Update failed")));
      // Revert the toggle
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
    final permissionData = Provider.of<AccessPermissionProvider>(context);

    if (permissionData.isLoading) {
      return const Center(child: CustomShimmerWidget());
    }
    if (permissionData.error != null) {
      return Center(child: Text(permissionData.error!));
    }

    return Stack(
      children: [
        Scaffold(
          body: Container(
            decoration:
                const BoxDecoration(gradient: AppColors.backgroundGraident),
            child: SafeArea(
              child: Column(
                children: [
                  // BuildHeader(
                  //   searchController: searchController,
                  //   showOnlyEnabled: showOnlyEnabled,
                  //   onToggleFilter: () {
                  //     setState(() {
                  //       showOnlyEnabled = !showOnlyEnabled;
                  //     });
                  //   },
                  // ),
                  _buildRoleSummaryCards(),
                  Expanded(child: _buildPermissionsTable()),
                ],
              ),
            ),
          ),
        ),
        if (permissionData.isPatching)
          Container(
            color: Colors.black.withOpacity(0.3),
            child: const Center(child: CircularProgressIndicator()),
          )
      ],
    );
  }

  Widget _buildRoleSummaryCards() {
    return Container(
      height: 120,
      margin: const EdgeInsets.all(20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: roles.length,
        itemBuilder: (context, index) {
          String role = roles[index];
          int enabledCount =
              permissions[role]!.values.where((enabled) => enabled).length;
          int totalCount = permissions[role]!.length;

          return Container(
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
          );
        },
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
      child: Row(
        children: [
          const Expanded(
            flex: 3,
            child: Text(
              'Permission',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          ...roles.map((role) => Expanded(
                child: Text(
                  _formatRoleName(role),
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
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
        border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.violetPrimaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(permission.icon,
                      color: AppColors.violetPrimaryColor, size: 16),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    permission.displayName,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryColor),
                  ),
                ),
              ],
            ),
          ),
          ...roles.map((role) => Expanded(
                child: Center(
                  child: GestureDetector(
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
                                  color: Colors.white, shape: BoxShape.circle),
                              child: Icon(
                                permission.rolePermissions[role]!
                                    ? Icons.check
                                    : Icons.close,
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
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

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

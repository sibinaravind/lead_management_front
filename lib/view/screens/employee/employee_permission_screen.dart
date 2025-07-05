
import 'package:flutter/material.dart';
import 'package:overseas_front_end/view/screens/employee/widget/permission_header_widget.dart';

import '../../../res/style/colors/colors.dart';


class AccessPermissionScreen extends StatefulWidget {
  @override
  _AccessPermissionScreenState createState() => _AccessPermissionScreenState();
}

class _AccessPermissionScreenState extends State<AccessPermissionScreen> {
  late Map<String, Map<String, bool>> permissions;
  late List<String> roles;
  late List<PermissionData> permissionsList;
  String searchQuery = '';
  bool showOnlyEnabled = false;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    // Initialize roles
    roles = ['admin', 'counselor', 'manager', 'front_desk', 'documentation', 'visa'];

    // Initialize permissions data
    permissions = {
      'admin': {
        'view_all_leads': true,
        'edit_lead': true,
        'delete_lead': true,
        'manage_users': true,
        'manage_constants': true,
        'view_reports': true,
        'assign_leads': true,
        'update_visa_status': true,
        'manage_documents': true,
        'handle_walkins': true,
        'update_counseling_status': true,
      },
      'counselor': {
        'view_all_leads': false,
        'edit_lead': true,
        'delete_lead': false,
        'manage_users': false,
        'manage_constants': false,
        'view_reports': false,
        'assign_leads': false,
        'update_visa_status': false,
        'manage_documents': false,
        'handle_walkins': false,
        'update_counseling_status': true,
      },
      'manager': {
        'view_all_leads': true,
        'edit_lead': false,
        'delete_lead': false,
        'manage_users': false,
        'manage_constants': false,
        'view_reports': true,
        'assign_leads': true,
        'update_visa_status': false,
        'manage_documents': false,
        'handle_walkins': false,
        'update_counseling_status': false,
      },
      'front_desk': {
        'view_all_leads': false,
        'edit_lead': false,
        'delete_lead': false,
        'manage_users': false,
        'manage_constants': false,
        'view_reports': false,
        'assign_leads': true,
        'update_visa_status': false,
        'manage_documents': false,
        'handle_walkins': true,
        'update_counseling_status': false,
      },
      'documentation': {
        'view_all_leads': false,
        'edit_lead': false,
        'delete_lead': false,
        'manage_users': false,
        'manage_constants': false,
        'view_reports': false,
        'assign_leads': false,
        'update_visa_status': false,
        'manage_documents': true,
        'handle_walkins': false,
        'update_counseling_status': false,
      },
      'visa': {
        'view_all_leads': false,
        'edit_lead': false,
        'delete_lead': false,
        'manage_users': false,
        'manage_constants': false,
        'view_reports': false,
        'assign_leads': false,
        'update_visa_status': true,
        'manage_documents': false,
        'handle_walkins': false,
        'update_counseling_status': false,
      },
    };

    // Create permissions list
    permissionsList = [
      PermissionData(
        name: 'view_all_leads',
        displayName: 'View All Leads',
        icon: Icons.visibility,
        rolePermissions: {for (var role in roles) role: permissions[role]!['view_all_leads']!},
      ),
      PermissionData(
        name: 'edit_lead',
        displayName: 'Edit Lead',
        icon: Icons.edit,
        rolePermissions: {for (var role in roles) role: permissions[role]!['edit_lead']!},
      ),
      PermissionData(
        name: 'delete_lead',
        displayName: 'Delete Lead',
        icon: Icons.delete,
        rolePermissions: {for (var role in roles) role: permissions[role]!['delete_lead']!},
      ),
      PermissionData(
        name: 'manage_users',
        displayName: 'Manage Users',
        icon: Icons.people,
        rolePermissions: {for (var role in roles) role: permissions[role]!['manage_users']!},
      ),
      PermissionData(
        name: 'manage_constants',
        displayName: 'Manage Constants',
        icon: Icons.settings,
        rolePermissions: {for (var role in roles) role: permissions[role]!['manage_constants']!},
      ),
      PermissionData(
        name: 'view_reports',
        displayName: 'View Reports',
        icon: Icons.analytics,
        rolePermissions: {for (var role in roles) role: permissions[role]!['view_reports']!},
      ),
      PermissionData(
        name: 'assign_leads',
        displayName: 'Assign Leads',
        icon: Icons.assignment,
        rolePermissions: {for (var role in roles) role: permissions[role]!['assign_leads']!},
      ),
      PermissionData(
        name: 'update_visa_status',
        displayName: 'Update Visa Status',
        icon: Icons.flight_takeoff,
        rolePermissions: {for (var role in roles) role: permissions[role]!['update_visa_status']!},
      ),
      PermissionData(
        name: 'manage_documents',
        displayName: 'Manage Documents',
        icon: Icons.folder,
        rolePermissions: {for (var role in roles) role: permissions[role]!['manage_documents']!},
      ),
      PermissionData(
        name: 'handle_walkins',
        displayName: 'Handle Walk-ins',
        icon: Icons.directions_walk,
        rolePermissions: {for (var role in roles) role: permissions[role]!['handle_walkins']!},
      ),
      PermissionData(
        name: 'update_counseling_status',
        displayName: 'Update Counseling Status',
        icon: Icons.psychology,
        rolePermissions: {for (var role in roles) role: permissions[role]!['update_counseling_status']!},
      ),
    ];
  }

  void _togglePermission(String role, String permission) {
    setState(() {
      permissions[role]![permission] = !permissions[role]![permission]!;
      // Update the permissions list
      int index = permissionsList.indexWhere((p) => p.name == permission);
      if (index != -1) {
        permissionsList[index].rolePermissions[role] = permissions[role]![permission]!;
      }
    });
  }

  Color _getRoleColor(String role) {
    switch (role.toLowerCase()) {
      case 'admin':
        return AppColors.violetPrimaryColor;
      case 'manager':
        return AppColors.blueSecondaryColor;
      case 'counselor':
        return AppColors.greenSecondaryColor;
      case 'front_desk':
        return AppColors.orangeSecondaryColor;
      case 'documentation':
        return AppColors.pinkSecondaryColor;
      case 'visa':
        return AppColors.redSecondaryColor;
      default:
        return AppColors.primaryColor;
    }
  }

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

  String _formatRoleName(String role) {
    return role.split('_').map((word) => word.capitalize()).join(' ');
  }

  List<PermissionData> _getFilteredPermissions() {
    return permissionsList.where((permission) {
      bool matchesSearch = permission.displayName.toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesFilter = !showOnlyEnabled || permission.rolePermissions.values.any((enabled) => enabled);
      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGraident,
        ),
        child: SafeArea(
          child: Column(
            children: [
              BuildHeader(),
              _buildFilters(),
              _buildRoleSummaryCards(),
              Expanded(
                child: _buildPermissionsTable(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: TextField(
                onChanged: (value) => setState(() => searchQuery = value),
                decoration: InputDecoration(
                  hintText: 'Search permissions...',
                  prefixIcon: Icon(Icons.search, color: AppColors.textGrayColour),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                Checkbox(
                  value: showOnlyEnabled,
                  onChanged: (value) => setState(() => showOnlyEnabled = value ?? false),
                  activeColor: AppColors.greenSecondaryColor,
                ),
                Text(
                  'Show only enabled',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textColor,
                  ),
                ),
                SizedBox(width: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleSummaryCards() {
    return Container(
      height: 120,
      margin: EdgeInsets.all(20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: roles.length,
        itemBuilder: (context, index) {
          String role = roles[index];
          int enabledCount = permissions[role]!.values.where((enabled) => enabled).length;
          int totalCount = permissions[role]!.length;

          return Container(
            width: 140,
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _getRoleColor(role).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getRoleIcon(role),
                    color: _getRoleColor(role),
                    size: 20,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  _formatRoleName(role),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4),
                Text(
                  '$enabledCount/$totalCount',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _getRoleColor(role),
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
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: Offset(0, 10),
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
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppColors.buttonGraidentColour,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          Expanded(
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
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildPermissionRow(PermissionData permission, int index) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: index.isEven ? Colors.grey[50] : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Container(
                  padding:const EdgeInsets.all(8),
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
                    overflow: TextOverflow.ellipsis,
                    permission.displayName,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
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
                        duration: Duration(milliseconds: 200),
                        child: Container(
                          width: 24,
                          height: 24,
                          margin: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
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
          )).toList(),
        ],
      ),
    );
  }
}


extension StringExtension on String {
  String capitalize() {
    return this[0].toUpperCase() + this.substring(1);
  }
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
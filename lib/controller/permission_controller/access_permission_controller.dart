import 'package:flutter/foundation.dart';

import '../../core/services/api_service.dart';
import '../../core/shared/constants.dart';
import '../../model/access_permissions/access_permissions.dart';

class AccessPermissionProvider with ChangeNotifier {
  AccessPermissionProvider._privateConstructor();
  static final _instance = AccessPermissionProvider._privateConstructor();
  factory AccessPermissionProvider() => _instance;

  final ApiService apiService = ApiService();

  EmployeePermissionModel? _accessPermission;
  bool _isLoading = false;
  bool _isPatching = false;
  String? _error;

  EmployeePermissionModel? get accessPermission => _accessPermission;
  bool get isLoading => _isLoading;
  bool get isPatching => _isPatching;
  String? get error => _error;

  Future<void> fetchAccessPermissions() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await apiService.get(Constant().accessPermissions);
      _accessPermission = EmployeePermissionModel.fromJson(response['data']);
      _error = null;
    } catch (e) {
      _error = 'Failed to load permissions: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> patchAccessPermissions({
    required String category,
    required List<Map<String, dynamic>> updatedFields,
  }) async {
    _isPatching = true;
    notifyListeners();
    try {
      final data = {
        "category": category,
        "value": updatedFields,
      };
      final response = await apiService.patch(
        Constant().accessPermissionsEdit,
        data,
      );
      final success = response['success'] == true;
      if (success) {
        updatedFields.forEach((fieldMap) {
          final key = fieldMap['field'];
          final value = fieldMap['value'];
          final roleMap = _getRoleMap(category);
          if (roleMap != null) {
            roleMap[key] = value;
          }
        });
        notifyListeners();
      }
      return success;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isPatching = false;
      notifyListeners();
    }
  }

  Map<String, bool>? _getRoleMap(String role) {
    switch (role) {
      case 'admin':
        return _accessPermission?.admin;
      case 'counselor':
        return _accessPermission?.counselor;
      case 'manager':
        return _accessPermission?.manager;
      case 'front_desk':
        return _accessPermission?.frontDesk;
      case 'documentation':
        return _accessPermission?.documentation;
      case 'visa':
        return _accessPermission?.visa;
      default:
        return null;
    }
  }
}

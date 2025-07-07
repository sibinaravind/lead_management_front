

import 'package:flutter/material.dart';
import 'package:overseas_front_end/core/shared/contants.dart';

import '../../core/services/api_service.dart';
import '../../model/access_permissions/access_permissions.dart';

class AccessPermissionProvider with ChangeNotifier {

  AccessPermissionProvider._privateConstructor();
  static final _instance=AccessPermissionProvider._privateConstructor();
  factory AccessPermissionProvider(){
    return _instance;
  }
  final ApiService _api = ApiService();

  AccessPermission? _accessPermission;
  bool _isLoading = false;
  bool _isPatching = false;
  String? _error;

  AccessPermission? get accessPermission => _accessPermission;
  bool get isLoading => _isLoading;
  bool get isPatching => _isPatching;
  String? get error => _error;

  Future<void> fetchAccessPermissions() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _api.get(Constant().accessPermissions);
      _accessPermission = AccessPermission.fromJson(response);
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
      final payload = {
        "category": category,
        "value": updatedFields,
      };

      final response = await _api.patch(Constant().accessPermissionsEdit,payload );
      return response['success'] == true;
    } catch (e) {
      _error = "Failed to update permission: $e";
      return false;
    } finally {
      _isPatching = false;
      notifyListeners();
    }
  }
}

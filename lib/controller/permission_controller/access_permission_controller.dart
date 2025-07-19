// import 'package:flutter/foundation.dart';
//
// import '../../core/services/api_service.dart';
// import '../../core/shared/constants.dart';
// import '../../model/access_permissions/access_permissions.dart';
//
// class AccessPermissionProvider with ChangeNotifier {
//   AccessPermissionProvider._privateConstructor();
//   static final _instance = AccessPermissionProvider._privateConstructor();
//   factory AccessPermissionProvider() => _instance;
//
//   final ApiService apiService = ApiService();
//
//   EmployeePermissionModel? _accessPermission;
//   bool _isLoading = false;
//   bool _isPatching = false;
//   String? _error;
//
//   EmployeePermissionModel? get accessPermission => _accessPermission;
//   bool get isLoading => _isLoading;
//   bool get isPatching => _isPatching;
//   String? get error => _error;
//
//   // Future<void> fetchAccessPermissions() async {
//   //   _isLoading = true;
//   //   notifyListeners();
//   //   try {
//   //     final response = await apiService.get(Constant().accessPermissions);
//   //     _accessPermission = EmployeePermissionModel.fromJson(response['data']);
//   //     _error = null;
//   //   } catch (e) {
//   //     _error = 'Failed to load permissions: $e';
//   //   } finally {
//   //     _isLoading = false;
//   //     notifyListeners();
//   //   }
//   // }
//
//   Future<void> fetchAccessPermissions() async {
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       final response = await apiService.get(Constant().accessPermissions);
//
//       if (response['success'] == true && response['data'] != null) {
//         final List<dynamic> dataList = response['data'];
//         final permissionsList = dataList
//             .map((e) => EmployeePermissionModel.fromJson(e))
//             .toList();
//
//         _accessPermission = permissionsList;
//         _error = null;
//       } else {
//         _error = 'Invalid response data';
//       }
//     } catch (e) {
//       _error = 'Failed to load permissions: $e';
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//
//   Future<bool> patchAccessPermissions({
//     required String category,
//     required List<Map<String, dynamic>> updatedFields,
//   }) async {
//     _isPatching = true;
//     notifyListeners();
//     try {
//       final data = {
//         "category": category,
//         "value": updatedFields,
//       };
//       final response = await apiService.patch(
//         Constant().accessPermissionsEdit,
//         data,
//       );
//       final success = response['success'] == true;
//       if (success) {
//         updatedFields.forEach((fieldMap) {
//           final key = fieldMap['field'];
//           final value = fieldMap['value'];
//           final roleMap = _getRoleMap(category);
//           if (roleMap != null) {
//             roleMap[key] = value;
//           }
//         });
//         notifyListeners();
//       }
//       return success;
//     } catch (e) {
//       _error = e.toString();
//       return false;
//     } finally {
//       _isPatching = false;
//       notifyListeners();
//     }
//   }
//
//   Map<String, bool>? _getRoleMap(String role) {
//     switch (role) {
//       case 'admin':
//         return _accessPermission?.admin;
//       case 'counselor':
//         return _accessPermission?.counselor;
//       case 'manager':
//         return _accessPermission?.manager;
//       case 'front_desk':
//         return _accessPermission?.frontDesk;
//       case 'documentation':
//         return _accessPermission?.documentation;
//       case 'visa':
//         return _accessPermission?.visa;
//       default:
//         return null;
//     }
//   }
//
//   // List<RolePermission> _rolePermissions = [];
//   //
//   // List<RolePermission> get rolePermissions => _rolePermissions;
//   //
//   // void setRolePermissions(List<dynamic> data) {
//   //   _rolePermissions = data.map((e) => RolePermission.fromJson(e)).toList();
//   //   notifyListeners();
//   // }
//   //
//   // RolePermission? getPermissionByCategory(String category) {
//   //   try {
//   //     return _rolePermissions.firstWhere((element) => element.category == category);
//   //   } catch (e) {
//   //     return null;
//   //   }
//   // }
//
// }


import 'package:flutter/cupertino.dart';

import '../../core/services/api_service.dart';
import '../../core/shared/constants.dart';
import '../../model/access_permissions/access_permissions.dart';


class AccessPermissionProvider with ChangeNotifier {
  AccessPermissionProvider._privateConstructor();
  static final _instance = AccessPermissionProvider._privateConstructor();
  factory AccessPermissionProvider() => _instance;

  final ApiService apiService = ApiService();

  List<EmployeePermissionModel> _permissions = [];
  bool _isLoading = false;
  bool _isPatching = false;
  String? _error;

  List<EmployeePermissionModel> get permissions => _permissions;
  bool get isLoading => _isLoading;
  bool get isPatching => _isPatching;
  String? get error => _error;

  Future<void> fetchAccessPermissions() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await apiService.get(Constant().accessPermissions);

      if (response['success'] == true && response['data'] != null) {
        _permissions = (response['data'] as List)
            .map((e) => EmployeePermissionModel.fromJson(e))
            .toList();
        _error = null;
      } else {
        _error = 'Invalid response data';
      }
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

      if (response['success'] == true) {
        final role = getPermissionByCategory(category);
        if (role != null) {
          for (var field in updatedFields) {
            role.value[field['field']] = field['value'];
          }
        }
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isPatching = false;
      notifyListeners();
    }
  }
  Future<bool> deleteAccessPermission(String category) async {
    _isLoading = true;
    notifyListeners();
    Map<String, dynamic> data={
      "category": category,
    };
    try {
      final response = await apiService.delete(
        Constant().accessPermissionsDelete,
       data
      );

      if (response['success'] == true) {

        _permissions.removeWhere(
              (perm) => perm.category.toLowerCase() == category.toLowerCase(),
        );

        return true;
      } else {
        _error = response['message'] ?? 'Failed to delete permission.';
        return false;
      }
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  // Future<bool> addAccessPermission({
  //   required String category,
  //   required Map<String, bool> value,
  // }) async {
  //   _isLoading = true;
  //   notifyListeners();
  //
  //   try {
  //     final data = {
  //       "category": category,
  //       "value": value,
  //     };
  //
  //
  //     print(data);
  //     final response = await apiService.post(
  //       Constant().accessPermissionsAdd,
  //       data,
  //     );
  //
  //     if (response['success'] == true) {
  //       // Refresh the permissions list after successful insertion
  //       await fetchAccessPermissions();
  //       return true;
  //     } else {
  //
  //       _error = response['message'] ?? 'Failed to add permission.';
  //       return false;
  //     }
  //   } catch (e) {
  //     _error = 'Failed to add permission: $e';
  //     return false;
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  Future<bool> addAccessPermission({
    required String category,
    required Map<String, bool> value,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final data = {
        "category": category,
        "value": value,
      };

      final response = await apiService.post(
        Constant().accessPermissionsAdd,
        data,
      );

      if (response['success'] == true) {
        _permissions.add(EmployeePermissionModel(
          category: category,
          value: value,
        ));
        notifyListeners();
        return true;
      } else {
        _error = response['message'] ?? 'Failed to add permission.';
        return false;
      }
    } catch (e) {
      _error = 'Failed to add permission: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }



  EmployeePermissionModel? getPermissionByCategory(String category) {
    try {
      return _permissions.firstWhere(
              (element) => element.category.toLowerCase() == category.toLowerCase());
    } catch (e) {
      return null;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';
import '../../core/services/api_service.dart';
import '../../core/shared/constants.dart';
import '../../model/access_permissions/access_permissions.dart';

class AccessPermissionController extends GetxController {
  static AccessPermissionController get instance => Get.find();

  // Dependencies
  final ApiService apiService = ApiService();
  // Observables
  final RxList<EmployeePermissionModel> _permissions =
      <EmployeePermissionModel>[].obs;
  final RxBool _isLoading = false.obs;
  final RxBool _isPatching = false.obs;
  final RxnString _error = RxnString();

  // Getters
  RxList<EmployeePermissionModel> get permissions => _permissions;
  bool get isLoading => _isLoading.value;
  bool get isPatching => _isPatching.value;
  String? get error => _error.value;
  bool get hasError => _error.value != null;

  void clearError() => _error.value = null;
  Future<void> fetchAccessPermissions() async {
    _isLoading.value = true;
    clearError();
    final result = await apiService.getRequest<List<EmployeePermissionModel>>(
      endpoint: Constant().accessPermissions,
      fromJson: (dynamic json) {
        if (json is List) {
          return json.map((e) => EmployeePermissionModel.fromJson(e)).toList();
        } else {
          throw Exception('Expected List but got ${json.runtimeType}');
        }
      },
    );
    result.fold(
      (exception) {
        _error.value = 'Failed to load permissions: ${exception.toString()}';
      },
      (permissionsList) {
        _permissions.assignAll(permissionsList);
        clearError();
      },
    );

    _isLoading.value = false;
  }

  /// Updates access permissions for a specific category
  Future<bool> patchAccessPermissions({
    required String category,
    required List<Map<String, dynamic>> updatedFields,
  }) async {
    _isPatching.value = true;
    clearError();

    final data = {
      "category": category,
      "value": updatedFields,
    };

    final result = await apiService.patchRequest<dynamic>(
      endpoint: Constant().accessPermissionsEdit,
      body: data,
      fromJson: (dynamic json) => json,
    );

    bool success = false;
    result.fold(
      (exception) {
        _error.value = exception.toString();
        success = false;
      },
      (response) {
        success = true;
        // Update local data
        final role = getPermissionByCategory(category);
        if (role != null) {
          for (var field in updatedFields) {
            role.value[field['field']] = field['value'];
          }
          _permissions.refresh(); // Trigger reactivity
        }
        clearError();
      },
    );

    _isPatching.value = false;
    return success;
  }

  /// Deletes an access permission by category
  Future<bool> deleteAccessPermission(String category) async {
    _isLoading.value = true;
    clearError();
    final data = {
      "category": category,
    };

    final result = await apiService.deleteRequest<dynamic>(
      endpoint: Constant().accessPermissionsDelete,
      body: data,
      fromJson: (dynamic json) => json,
    );
    bool success = false;
    result.fold(
      (exception) {
        _error.value = exception.toString();
        success = false;
      },
      (response) {
        _permissions.removeWhere(
          (perm) => perm.category.toLowerCase() == category.toLowerCase(),
        );
        success = true;
        clearError();

        CustomSnackBar.showMessage('Success', 'Permission deleted successfully',
            backgroundColor: Colors.red.withOpacity(0.8));
      },
    );

    _isLoading.value = false;
    return success;
  }

  /// Adds a new access permission
  Future<bool> addAccessPermission({
    required String category,
    required Map<String, bool> value,
  }) async {
    _isLoading.value = true;
    clearError();

    // Check if category already exists
    if (getPermissionByCategory(category) != null) {
      _error.value = 'Permission category "$category" already exists';
      _isLoading.value = false;
      return false;
    }

    final data = {
      "category": category,
      "value": value,
    };

    final result = await apiService.postRequest<dynamic>(
      endpoint: Constant().accessPermissionsAdd,
      body: data,
      fromJson: (dynamic json) => json,
    );

    bool success = false;
    result.fold(
      (exception) {
        _error.value = 'Failed to add permission: ${exception.toString()}';
        success = false;
      },
      (response) {
        _permissions.add(EmployeePermissionModel(
          category: category,
          value: value,
        ));
        success = true;
        clearError();

        // Show success snackbar
        CustomSnackBar.showMessage(
          'Success',
          'Role added successfully',
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white,
        );
      },
    );

    _isLoading.value = false;
    return success;
  }

  /// Gets a permission by category name
  EmployeePermissionModel? getPermissionByCategory(String category) {
    try {
      return _permissions.firstWhere(
        (element) => element.category.toLowerCase() == category.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  /// Checks if a specific permission exists for a category
  bool hasPermission(String category, String permission) {
    final categoryPermission = getPermissionByCategory(category);
    return categoryPermission?.value[permission] ?? false;
  }

  /// Gets all categories
  List<String> get categories => _permissions.map((p) => p.category).toList();

  /// Refreshes the permissions list
  @override
  Future<void> refresh() async {
    await fetchAccessPermissions();
  }

  /// Gets permissions count
  int get permissionsCount => _permissions.length;

  /// Checks if permissions list is empty
  bool get isEmpty => _permissions.isEmpty;

  @override
  void onInit() {
    super.onInit();
    // Optionally load data on initialization
    fetchAccessPermissions();
  }

  @override
  void onClose() {
    // Clean up if needed
    super.onClose();
  }
}

// Binding class for dependency injection
class AccessPermissionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccessPermissionController>(() => AccessPermissionController());
  }
}

// Extension for easier access and additional functionality
extension AccessPermissionExtension on AccessPermissionController {
  /// Toggle a specific permission for a category
  Future<bool> togglePermission(String category, String permission) async {
    final currentValue = hasPermission(category, permission);
    return await patchAccessPermissions(
      category: category,
      updatedFields: [
        {
          'field': permission,
          'value': !currentValue,
        }
      ],
    );
  }

  /// Update multiple permissions at once
  Future<bool> updateMultiplePermissions(
    String category,
    Map<String, bool> permissions,
  ) async {
    final updatedFields = permissions.entries
        .map((entry) => {
              'field': entry.key,
              'value': entry.value,
            })
        .toList();

    return await patchAccessPermissions(
      category: category,
      updatedFields: updatedFields,
    );
  }

  /// Search permissions by category name
  List<EmployeePermissionModel> searchPermissions(String query) {
    if (query.isEmpty) return permissions;

    return permissions
        .where((permission) =>
            permission.category.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  /// Get permission by index
  EmployeePermissionModel? getPermissionByIndex(int index) {
    if (index >= 0 && index < permissions.length) {
      return permissions[index];
    }
    return null;
  }
}

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

// import 'package:flutter/cupertino.dart';

// import '../../core/services/api_service.dart';
// import '../../core/shared/constants.dart';
// import '../../model/access_permissions/access_permissions.dart';

// class AccessPermissionProvider with ChangeNotifier {
//   AccessPermissionProvider._privateConstructor();
//   static final _instance = AccessPermissionProvider._privateConstructor();
//   factory AccessPermissionProvider() => _instance;

//   final ApiService apiService = ApiService();

//   List<EmployeePermissionModel> _permissions = [];
//   bool _isLoading = false;
//   bool _isPatching = false;
//   String? _error;

//   List<EmployeePermissionModel> get permissions => _permissions;
//   bool get isLoading => _isLoading;
//   bool get isPatching => _isPatching;
//   String? get error => _error;

//   Future<void> fetchAccessPermissions(
//     context,
//   ) async {
//     _isLoading = true;
//     notifyListeners();

//     try {
//       final response =
//           await apiService.get(context: context, Constant().accessPermissions);

//       if (response['success'] == true && response['data'] != null) {
//         _permissions = (response['data'] as List)
//             .map((e) => EmployeePermissionModel.fromJson(e))
//             .toList();
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

//   Future<bool> patchAccessPermissions(
//     context, {
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
//         context: context,
//         Constant().accessPermissionsEdit,
//         data,
//       );

//       if (response['success'] == true) {
//         final role = getPermissionByCategory(category);
//         if (role != null) {
//           for (var field in updatedFields) {
//             role.value[field['field']] = field['value'];
//           }
//         }
//         notifyListeners();
//         return true;
//       }
//       return false;
//     } catch (e) {
//       _error = e.toString();
//       return false;
//     } finally {
//       _isPatching = false;
//       notifyListeners();
//     }
//   }

//   Future<bool> deleteAccessPermission(context, String category) async {
//     _isLoading = true;
//     notifyListeners();
//     Map<String, dynamic> data = {
//       "category": category,
//     };
//     try {
//       final response = await apiService.delete(
//           context: context, Constant().accessPermissionsDelete, data);

//       if (response['success'] == true) {
//         _permissions.removeWhere(
//           (perm) => perm.category.toLowerCase() == category.toLowerCase(),
//         );

//         return true;
//       } else {
//         _error = response['message'] ?? 'Failed to delete permission.';
//         return false;
//       }
//     } catch (e) {
//       _error = e.toString();
//       return false;
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//   // Future<bool> addAccessPermission({
//   //   required String category,
//   //   required Map<String, bool> value,
//   // }) async {
//   //   _isLoading = true;
//   //   notifyListeners();
//   //
//   //   try {
//   //     final data = {
//   //       "category": category,
//   //       "value": value,
//   //     };
//   //
//   //
//   //     print(data);
//   //     final response = await apiService.post(
//   //       Constant().accessPermissionsAdd,
//   //       data,
//   //     );
//   //
//   //     if (response['success'] == true) {
//   //       // Refresh the permissions list after successful insertion
//   //       await fetchAccessPermissions();
//   //       return true;
//   //     } else {
//   //
//   //       _error = response['message'] ?? 'Failed to add permission.';
//   //       return false;
//   //     }
//   //   } catch (e) {
//   //     _error = 'Failed to add permission: $e';
//   //     return false;
//   //   } finally {
//   //     _isLoading = false;
//   //     notifyListeners();
//   //   }
//   // }

//   Future<bool> addAccessPermission(
//     context, {
//     required String category,
//     required Map<String, bool> value,
//   }) async {
//     _isLoading = true;
//     notifyListeners();

//     try {
//       final data = {
//         "category": category,
//         "value": value,
//       };

//       final response = await apiService.post(
//         context: context,
//         Constant().accessPermissionsAdd,
//         data,
//       );

//       if (response['success'] == true) {
//         _permissions.add(EmployeePermissionModel(
//           category: category,
//           value: value,
//         ));
//         notifyListeners();
//         return true;
//       } else {
//         _error = response['message'] ?? 'Failed to add permission.';
//         return false;
//       }
//     } catch (e) {
//       _error = 'Failed to add permission: $e';
//       return false;
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   EmployeePermissionModel? getPermissionByCategory(String category) {
//     try {
//       return _permissions.firstWhere((element) =>
//           element.category.toLowerCase() == category.toLowerCase());
//     } catch (e) {
//       return null;
//     }
//   }
// }

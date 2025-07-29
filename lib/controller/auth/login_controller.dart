import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/core/services/user_cache_service.dart';
import 'package:overseas_front_end/core/shared/constants.dart';
import 'package:overseas_front_end/model/officer/officer_model.dart';
import 'package:overseas_front_end/view/widgets/custom_toast.dart';
import '../../core/di/service_locator.dart';
import '../../core/services/api_service.dart';
import '../../core/services/navigation_service.dart';
import '../../res/style/colors/colors.dart';
import '../../view/widgets/custom_snackbar.dart';

class LoginController extends GetxController {
  final ApiService _apiService = ApiService();
  final _userCacheService = serviceLocator<UserCacheService>();
  // Observables
  var officer = Rxn<OfficerModel>();
  var isLoading = false.obs;

  /// LOGIN OFFICER
  Future<void> loginOfficer({
    required String officerId,
    required String password,
  }) async {
    isLoading.value = true;
    try {
      final result = await _apiService.postRequest(
        endpoint: Constant().officerLogin,
        body: {
          "officer_id": officerId,
          "password": password,
        },
        fromJson: (json) {
          return OfficerModel.fromJson(json["officer"]);
        },
      );
      result.fold(
        (failure) {
          CustomToast.showToast(
            context: Get.context!,
            message: 'Login failed: $failure',
          );
        },
        (data) async {
          officer.value = data;
          _userCacheService.saveUser(data);
          _userCacheService.saveAuthToken(data.token ?? '');
          // Show success message
          NavigationService.goBack();
          NavigationService.goBack();
          CustomSnackBar.showMessage(
            'Login Successful',
            'Welcome ${data.name ?? 'Officer'}',
            backgroundColor: AppColors.greenSecondaryColor.withOpacity(0.5),
            colorText: Colors.white,
          );

          NavigationService.go('/dashboard/dashboard/overview');
        },
      );
    } catch (e) {
      CustomToast.showToast(
        context: Get.context!,
        message: 'Error: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// RESET PASSWORD
  Future<bool> resetPassword({
    required String officerId,
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final result = await _apiService.patchRequest(
        endpoint: '${Constant().officerPasswordReset}/$officerId',
        body: {
          "current_password": currentPassword,
          "new_password": newPassword,
        },
        fromJson: (json) => json,
      );

      bool success = false;
      result.fold(
        (failure) {
          CustomToast.showToast(
            context: Get.context!,
            message: 'Failed: $failure',
          );
          success = false;
        },
        (data) {
          CustomToast.showToast(
            context: Get.context!,
            message: 'Password updated successfully',
          );
          success = true;
        },
      );
      return success;
    } catch (e) {
      CustomToast.showToast(
        context: Get.context!,
        message: 'Error: $e',
      );
      return false;
    }
  }
}

// import 'package:flutter/material.dart';
// import 'package:overseas_front_end/core/services/user_cache_service.dart';
// import 'package:overseas_front_end/core/shared/constants.dart';
// import '../../core/services/api_service.dart';
// import '../../model/officer/officer_model.dart';
// import '../../view/widgets/custom_toast.dart';

// class LoginProvider extends ChangeNotifier {
//   LoginProvider._privateConstructor();
//   static final _instance = LoginProvider._privateConstructor();
//   factory LoginProvider() => _instance;

//   final ApiService _apiService = ApiService();
//   final UserCacheService _userCacheService = UserCacheService();

//   OfficerModel? _officer;
//   String? _token;
//   bool _isLoading = false;

//   OfficerModel? get officer => _officer;
//   String? get token => _token;
//   bool get isLoading => _isLoading;

//   Future<void> loginOfficer(
//     conext, {
//     required String officerId,
//     required String password,
//     required BuildContext context,
//   }) async {
//     _isLoading = true;
//     notifyListeners();

//     try {
//       final response =
//           await _apiService.post(context: context, Constant().officerLogin, {
//         "officer_id": officerId,
//         "password": password,
//       });

//       if (response["success"] == true) {
//         _officer = OfficerModel.fromJson(response["data"]["officer"]);
//         _token = response["data"]["token"];
//         // UserCacheService().saveAuthToken(_token ?? '');
//         await _userCacheService.saveUser(_officer!);
//         await _userCacheService.saveAuthToken(_token!);
//         await _userCacheService.saveAuthToken(_token ?? '');

//         CustomToast.showToast(context: context, message: 'Login successful');

//         // ScaffoldMessenger.of(context).showSnackBar(
//         //   const SnackBar(content: Text("Login successful")),
//         // );
//         // Navigator.pushReplacement(
//         //   context,
//         //   MaterialPageRoute(builder: (context) => const DrawerScreen()),
//         // );
//       } else {
//         CustomToast.showToast(
//             context: context, message: 'Login failed: Invalid credentials');
//         // ScaffoldMessenger.of(context).showSnackBar(
//         //   const SnackBar(content: Text("Login failed: Invalid credentials")),
//         // );
//       }
//     } catch (e) {
//       CustomToast.showToast(context: context, message: 'Error: $e');
//       // ScaffoldMessenger.of(context).showSnackBar(
//       //   SnackBar(content: Text("Error: $e")),
//       // );
//     }

//     _isLoading = false;
//     notifyListeners();
//   }

//   Future<void> loadFromCache() async {
//     _officer = _userCacheService.getUser();
//     _token = await _userCacheService.getAuthToken();
//     notifyListeners();
//   }

//   Future<bool> resetPassword({
//     required String officerId,
//     required String currentPassword,
//     required String newPassword,
//     required BuildContext context,
//   }) async {
//     try {
//       final response = await _apiService.patch(
//         context: context,
//         '${Constant().officerPasswordReset}/$officerId',
//         {
//           "current_password": currentPassword,
//           "new_password": newPassword,
//         },
//       );

//       if (response["success"] == true) {
//         CustomToast.showToast(
//             context: context, message: 'Password updated successfully');
//         // ScaffoldMessenger.of(context).showSnackBar(
//         //   const SnackBar(content: Text("Password updated successfully")),
//         // );
//         return true;
//       } else {
//         CustomToast.showToast(
//             context: context, message: '"Failed: ${response["data"]}"');
//         // ScaffoldMessenger.of(context).showSnackBar(
//         //   SnackBar(content: Text("Failed: ${response["data"]}")),
//         // );
//         return false;
//       }
//     } catch (e) {
//       CustomToast.showToast(context: context, message: 'Error: $e');
//       // ScaffoldMessenger.of(context).showSnackBar(
//       //   SnackBar(content: Text("Error: $e")),
//       // );
//       return false;
//     }
//   }
// }

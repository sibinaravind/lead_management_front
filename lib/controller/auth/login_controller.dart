// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:overseas_front_end/core/shared/constants.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../core/services/api_service.dart';
// import '../../model/officer/officers_lofin_model.dart';
// import '../../view/screens/drawer/drawer_screen.dart';
//
// class LoginProvider extends ChangeNotifier {
//   LoginProvider._privateConstructor();
//   static final _instance = LoginProvider._privateConstructor();
//   factory LoginProvider() {
//     return _instance;
//   }
//
//   final ApiService _apiService = ApiService();
//
//   Officer? _officer;
//   String? _token;
//   bool _isLoading = false;
//
//   Officer? get officer => _officer;
//   String? get token => _token;
//   bool get isLoading => _isLoading;
//
//   Future<void> loginOfficer({
//     required String officerId,
//     required String password,
//     required BuildContext context,
//   }) async {
//     _isLoading = true;
//     notifyListeners();
//     Map<String, dynamic> data = {
//       "officer_id": officerId,
//       "password": password,
//     };
//
//     try {
//       final response = await _apiService.post(Constant().officerLogin, data);
//
//       final jsonData = response;
//       if (jsonData["success"] == true) {
//         _officer = Officer.fromJson(jsonData["data"]["officer"]);
//         // _token = jsonData["data"]["token"];
//
//         final prefs = await SharedPreferences.getInstance();
//         // await prefs.setString("token", _token!);
//         await prefs.setString("officer", jsonEncode(_officer!.toJson()));
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Login successful")),
//         );
//
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const DrawerScreen()),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Login failed: Invalid credentials")),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error: $e")),
//       );
//     }
//
//     _isLoading = false;
//     notifyListeners();
//   }
//
//   Future<void> loadFromPreferences() async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString("token");
//     final officerData = prefs.getString("officer");
//
//     if (token != null && officerData != null) {
//       _token = token;
//       _officer = Officer.fromJson(jsonDecode(officerData));
//       notifyListeners();
//     }
//   }
//
//   Future<bool> resetPassword({
//     required String officerId,
//     required String currentPassword,
//     required String newPassword,
//     required BuildContext context,
//   }) async {
//     final url = '${Constant().officerPasswordReset}/$officerId';
//
//     final body = {
//       "current_password": currentPassword,
//       "new_password": newPassword,
//     };
//
//     try {
//       final response = await _apiService.patch(
//           url, body); // Ensure ApiService supports PATCH
//
//       if (response["success"] == true) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Password updated successfully")),
//         );
//         return true;
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//               content: Text(
//                   "Failed: ${response["data"] ?? "Something went wrong"}")),
//         );
//         return false;
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error: $e")),
//       );
//       return false;
//     }
//   }
//
//   void logout() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.clear();
//     _token = null;
//     _officer = null;
//     notifyListeners();
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:overseas_front_end/core/shared/constants.dart';
import '../../core/services/api_service.dart';
import '../../core/services/login_cache_service.dart';
import '../../model/officer/officers_lofin_model.dart';
import '../../view/screens/drawer/drawer_screen.dart';

class LoginProvider extends ChangeNotifier {
  LoginProvider._privateConstructor();
  static final _instance = LoginProvider._privateConstructor();
  factory LoginProvider() => _instance;

  final ApiService _apiService = ApiService();
  final OfficerCacheService _cacheService = OfficerCacheService();

  Officer? _officer;
  String? _token;
  bool _isLoading = false;

  Officer? get officer => _officer;
  String? get token => _token;
  bool get isLoading => _isLoading;

  Future<void> loginOfficer({
    required String officerId,
    required String password,
    required BuildContext context,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.post(Constant().officerLogin, {
        "officer_id": officerId,
        "password": password,
      });

      if (response["success"] == true) {
        _officer = Officer.fromJson(response["data"]["officer"]);
        _token = response["data"]["token"];

        await _cacheService.saveOfficer(_officer!);
        await _cacheService.saveToken(_token!);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login successful")),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DrawerScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login failed: Invalid credentials")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadFromCache() async {
    _officer = await _cacheService.getOfficer();
    _token = await _cacheService.getToken();
    notifyListeners();
  }

  Future<bool> resetPassword({
    required String officerId,
    required String currentPassword,
    required String newPassword,
    required BuildContext context,
  }) async {
    try {
      final response = await _apiService.patch(
        '${Constant().officerPasswordReset}/$officerId',
        {
          "current_password": currentPassword,
          "new_password": newPassword,
        },
      );

      if (response["success"] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Password updated successfully")),
        );
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed: ${response["data"]}")),
        );
        return false;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
      return false;
    }
  }

  // Future<void> logout(BuildContext context) async {
  //   try {
  //     final token = await _cacheService.getToken();
  //
  //     if (token != null) {
  //       final response = await _apiService.post(
  //         Constant().officerLogout,
  //         {},
  //         headers: {"Authorization": "Bearer $token"},
  //       );
  //
  //       if (response["success"] == true) {

  //         ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text("Logged out successfully")),
  //         );
  //       } else {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text("Logout failed: ${response["data"]}")),
  //         );
  //       }
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("Error during logout: $e")),
  //     );
  //   } finally {
  //     await _cacheService.clearAll();
  //     _officer = null;
  //     _token = null;
  //     notifyListeners();
  //
  //     // Optional: Navigate to login screen
  //     Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
  //   }
  // }
}

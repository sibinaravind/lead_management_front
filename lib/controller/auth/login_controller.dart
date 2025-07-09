import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:overseas_front_end/core/shared/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/services/api_service.dart';
import '../../model/officer/officers_lofin_model.dart';
import '../../view/screens/drawer/drawer_screen.dart';

class LoginProvider extends ChangeNotifier {

  LoginProvider._privateConstructor();
  static final _instance = LoginProvider._privateConstructor();
  factory LoginProvider() {
    return _instance;
  }

  final ApiService _apiService = ApiService();

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
    Map<String, dynamic> data= {
      "officer_id": officerId,
      "password": password,
    };

    try {
      final response= await _apiService.post(Constant().officerLogin, data);

      final jsonData = response;
      if (jsonData["success"] == true) {
        _officer = Officer.fromJson(jsonData["data"]["officer"]);
        _token = jsonData["data"]["token"];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", _token!);
        await prefs.setString("officer", jsonEncode(_officer!.toJson()));

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login successful")),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DrawerScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login failed: Invalid credentials")),
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

  Future<void> loadFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final officerData = prefs.getString("officer");

    if (token != null && officerData != null) {
      _token = token;
      _officer = Officer.fromJson(jsonDecode(officerData));
      notifyListeners();
    }
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _token = null;
    _officer = null;
    notifyListeners();
  }
}

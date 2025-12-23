// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/flavour_config.dart';
import '../../model/officer/officer_model.dart';
import '../di/service_locator.dart';

const String USER_CACHE_KEY = 'usercache';
const String USERNAME_CACHE_KEY = 'username';
const String TOKEN_CACHE_KEY = 'tokencache';
const String SIGNUP_STATUS_CACHE_KEY = 'signupcache';

class UserCacheService {
  OfficerModel? _user;
  OfficerModel? get user => _user;
  SharedPreferences get sharedPrefs => serviceLocator<SharedPreferences>();

  bool isLogin() {
    final token = sharedPrefs.getString(TOKEN_CACHE_KEY);
    return token != null && token.isNotEmpty;
  }

  Future<bool> saveUser(OfficerModel user) async {
    // _user = user;
    var saved = await sharedPrefs.setString(USER_CACHE_KEY, jsonEncode(user));

    return saved;
  }

  OfficerModel? getUser() {
    var userMap = sharedPrefs.getString(USER_CACHE_KEY);
    if (userMap == null) {
      return null;
    }
    _user = OfficerModel.fromJson(jsonDecode(userMap));
    return _user;
  }

  // Future<int> getUserId() async {
  //   final user = await getUser();
  //   var userId = user!.clientId;
  //   return int.parse(userId!);
  // }

  Future<bool> deleteUser() async {
    _user = null;
    return await sharedPrefs.remove(TOKEN_CACHE_KEY);
  }

  Future<bool> saveAuthToken(String token) async {
    return await sharedPrefs.setString(TOKEN_CACHE_KEY, token);
  }

  Future<String?> getAuthToken() async {
    var token = sharedPrefs.getString(TOKEN_CACHE_KEY);
    if (token == null) {
      // return null;  //test
      return "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2ODZjZWRhOWU5Mjk5ZjM0MjlkNjIzOWEiLCJvZmZpY2VyX2lkIjoiQUVPSUQwMDAwNCIsImRlc2lnbmF0aW9uIjpbIkNPVU5TSUxPUiIsIkFETUlOIl0sImJyYW5jaCI6WyJUU1QxMyJdLCJvZmZpY2VycyI6W10sImlhdCI6MTc2NjUwNzc5OCwiZXhwIjoxNzY2NTI1Nzk4fQ.j8WrAcNzDHAjvhij_yTTNLAAitkq4ujmN9Q7kehbO8I";
    } else {
      return "Bearer $token";
    }
  }

  Future<bool> setSignupStatus(bool signupStatus) async {
    return await sharedPrefs.setBool(SIGNUP_STATUS_CACHE_KEY, signupStatus);
  }

  Future<OfficerModel?> getIsSignedUp() async {
    var status = sharedPrefs.getBool(SIGNUP_STATUS_CACHE_KEY);

    if (status == null) {
      return null;
    } else {
      return getUser();
    }
  }
}

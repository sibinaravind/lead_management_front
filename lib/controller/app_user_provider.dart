import 'package:flutter/material.dart';

import '../model/app_configs/config_model.dart';
import '../model/officer/user_model.dart';

class AppUserProvider extends ChangeNotifier {
  AppUserProvider._privateConstructor();
  static final _instance = AppUserProvider._privateConstructor();
  factory AppUserProvider() {
    return _instance;
  }
  int? selectedIndex = 0;
  UserModel? userModel;
  ConfigModel? configModel;

  void updateIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  UserModel getUserDetails() {
    if (userModel != null) {
      return userModel ?? const UserModel();
    }
    return userModel ?? const UserModel();
  }
}

import 'package:flutter/material.dart';
import 'package:overseas_front_end/model/models.dart';

import '../model/app_configs/config_model.dart';

class AppUserProvider extends ChangeNotifier {
  AppUserProvider._privateConstructor();
  static final _instance = AppUserProvider._privateConstructor();
  factory AppUserProvider() {
    return _instance;
  }
  int? selectedIndex = 0;
  OfficerModel? userModel;
  ConfigModel? configModel;

  void updateIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  OfficerModel getUserDetails() {
    if (userModel != null) {
      return userModel ?? OfficerModel();
    }
    return userModel ?? OfficerModel();
  }
}

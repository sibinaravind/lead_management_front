import 'package:flutter/material.dart';
import 'package:overseas_front_end/controller/app_user_provider.dart';

import '../../../model/app_configs/config_model.dart';

class ConfigProvider extends ChangeNotifier {
  ConfigProvider._privateContstructor();
  static final ConfigProvider _instance = ConfigProvider._privateContstructor();
  factory ConfigProvider() {
    return _instance;
  }

  ConfigModel? configModel;

  void getConfigData() {
    configModel = ConfigModel.fromMap(AppUserProvider().data);
    notifyListeners();
  }
}

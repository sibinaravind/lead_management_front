import 'package:flutter/material.dart';
import 'package:overseas_front_end/controller/config/data_source/config_api.dart';
import 'package:overseas_front_end/model/app_configs/config_list_model.dart';
import 'package:overseas_front_end/model/app_configs/config_model.dart';

import '../core/services/api_service.dart';

class ConfigProvider extends ChangeNotifier {
  ConfigProvider._privateConstructor() {
    _init();
  }

  static final ConfigProvider _instance = ConfigProvider._privateConstructor();
  factory ConfigProvider() => _instance;
  ConfigListModel? configModelList = ConfigListModel();
  Future<void> _init() async {
    await fetchConfigData();
  }

  Future<void> fetchConfigData() async {
    try {
      // Example API call (you can replace this with real API)
      // final response = await ConfigApi().getConfigItem(); // currently not used

      // Temporary fallback data (for testing)
      final localData = {
        "_id": "6829fcbf3deca8f5b103613b",
        "name": "constants",
        "education_program": [
          {
            "_id": "5f8d8a7b54687e3a14000001",
            "name": "PG",
            "status": "INACTIVE"
          },
          {"_id": "5f8d8a7b54687e3a14000002", "name": "UG", "status": "ACTIVE"},
        ]
      };

      configModelList = ConfigListModel.fromJson(localData);
      notifyListeners();
    } catch (e) {}
  }

  /// Removes an item from a category
  void removeItem(String category, ConfigModel item) {
    configModelList?.deleteItem(category, item);
    notifyListeners();
  }

  // void toggleStatus(String category, ConfigModel item) {
  //   final newStatus =
  //       item.status?.toUpperCase() == 'ACTIVE' ? 'INACTIVE' : 'ACTIVE';
  //   item.status = newStatus;
  //   notifyListeners();
  // }

  /// Calls the API to edit a program
  Future<bool> editProgramApi({required Map<String, dynamic> data}) async {
    final response = await ApiService().patch("endpoint", data);
    return response.statusCode == 200;
  }

  /// Calls the API to add a program
  Future<bool> addProgramApi({required Map<String, dynamic> data}) async {
    final response = await ApiService().put("endpoint", data);
    return response.statusCode == 200;
  }

  Future<bool> deleteProgramApi({required Map<String, dynamic> data}) async {
    final response = await ApiService().delete("endpoint", data);
    return response.statusCode == 200;
  }
}

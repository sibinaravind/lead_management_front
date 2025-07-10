import 'package:flutter/material.dart';
import 'package:overseas_front_end/core/shared/enums.dart';
import 'package:overseas_front_end/model/app_configs/config_list_model.dart';
import 'package:overseas_front_end/model/app_configs/config_model.dart';

import '../core/services/api_service.dart';
import '../core/shared/constants.dart';

class ConfigProvider extends ChangeNotifier {
  ConfigProvider._privateConstructor() {
    _init();
  }

  static final ConfigProvider _instance = ConfigProvider._privateConstructor();
  factory ConfigProvider() => _instance;

  final ApiService _api = ApiService();

  bool isLoading = false;
  bool _isPatching = false;
  String? _error;

  ConfigListModel? configModelList;
  Future<void> _init() async {
    await fetchConfigData();
  }

  Future<void> fetchConfigData() async {
    try {
      // Example API call (you can replace this with real API)
      // final response = await ConfigApi().getConfigItem(); // currently not used

      // Temporary fallback data (for testing)
      // final localData = {
      //   "_id": "6829fcbf3deca8f5b103613b",
      //   "name": "constants",
      //   "education_program": [
      //     {
      //       "_id": "5f8d8a7b54687e3a14000001",
      //       "name": "PG",
      //       "status": "INACTIVE"
      //     },
      //     {"_id": "5f8d8a7b54687e3a14000002", "name": "UG", "status": "ACTIVE"},
      //   ]
      // };

      // configModelList = ConfigListModel.fromJson(localData);
      notifyListeners();
    } catch (e) {}
  }

  Future<void> getConfigList() async {
    isLoading = true;
    _error = null;
    // notifyListeners();

    try {
      final response = await _api.get(Constant().configList);
      configModelList = ConfigListModel.fromJson(response['data']);
    } catch (e) {
      _error = 'Failed to load permissions: $e';
    } finally {
      isLoading = false;
      // notifyListeners();
    }
    notifyListeners();
  }

  Future<void> addConfig(
      {required String field, required String name, String colour = ""}) async {
    isLoading = true;
    _error = null;
    // notifyListeners();

    try {
      final response = await _api.patch(Constant().editConfigList, {
        "field": field,
        "action": "insert",
        "value": {"name": name, "status": "ACTIVE", "colour": colour}
      });
      if (response['success'] == true) {
        configModelList?.insertItem(
            field,
            ConfigModel(
                name: name,
                id: response['data']['insertedId'],
                status: Status.ACTIVE));
        notifyListeners();
      }
      // return response['success'] == true;
    } catch (e) {
      _error = 'Failed to load permissions: $e';
      // return false;
    } finally {
      isLoading = false;
      // await getConfigList();
      notifyListeners();
    }
  }

  void toggleStatus(String category, ConfigModel item) {
    if (item.status == Status.ACTIVE) {
      updateConfig(
          field: category,
          name: item.name ?? "",
          id: item.id ?? "",
          status: "INACTIVE");
    } else {
      updateConfig(
          field: category,
          name: item.name ?? "",
          id: item.id ?? "",
          status: "ACTIVE");
    }
  }

  Future<bool> updateConfig(
      {required String field,
      required String name,
      required String id,
      required String status,
      String colour = ""}) async {
    isLoading = true;
    _error = null;
    try {
      final response = await _api.patch(Constant().editConfigList, {
        "field": field,
        "action": "update",
        "value": {"_id": id, "name": name, "status": status, "colour": colour}
      });
      if (response['success'] == true) {
        configModelList?.updateItem(
            field,
            ConfigModel(
              id: id,
              name: name,
              status: status == "ACTIVE" ? Status.ACTIVE : Status.INACTIVE,
            ));
        notifyListeners();
      }
      return response['success'] == true;
    } catch (e) {
      _error = 'Failed to load permissions: $e';
      return false;
    } finally {
      isLoading = false;
      // await getConfigList();
      notifyListeners();
    }
  }

  Future<bool> deleteConfig({
    required String field,
    required String id,
  }) async {
    isLoading = true;
    _error = null;
    // notifyListeners();

    try {
      final response = await _api.patch(Constant().editConfigList, {
        "field": field,
        "action": "delete",
        "value": {
          "_id": id,
        }
      });
      // _campaignModel = CampaignModel.fromJson(response.data);
      if (response['success'] == true) {
        configModelList?.deleteItem(
            field,
            ConfigModel(
              id: id,
            ));
        notifyListeners();
      }
      return response['success'] == true;
    } catch (e) {
      _error = 'Failed to load permissions: $e';
      return false;
    } finally {
      isLoading = false;
      // await getConfigList();
      notifyListeners();
    }
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
  // Future<bool> editProgramApi({required Map<String, dynamic> data}) async {
  //   final response = await ApiService().patch("endpoint", data);
  //   return response.statusCode == 200;
  // }

  // /// Calls the API to add a program
  // Future<bool> addProgramApi({required Map<String, dynamic> data}) async {
  //   final response = await ApiService().put("endpoint", data);
  //   return response.statusCode == 200;
  // }

  // Future<bool> deleteProgramApi({required Map<String, dynamic> data}) async {
  //   final response = await ApiService().delete("endpoint", data);
  //   return response.statusCode == 200;
  // }
}

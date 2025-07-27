import 'package:get/get.dart';

class ConfigController extends GetxController {
  var isLoading = false.obs;
  var configData = Rxn<Map<String, dynamic>>();

  @override
  void onInit() {
    super.onInit();
    loadConfigData();
  }

  void loadConfigData() {
    isLoading.value = true;
    // Your JSON data from paste.txt
    configData.value = {
      "program_type": [
        {"_id": "5f8d8a7b54687e3a14000001", "name": "PG", "status": "ACTIVE"},
        {"_id": "5f8d8a7b54687e3a14000002", "name": "UG", "status": "INACTIVE"},
        // Add more items...
      ],
      "program": [
        {
          "_id": "6870dcec396fb1d521cfef8d",
          "name": "MBBS",
          "program": "UG",
          "status": "ACTIVE"
        },
        // Add more items...
      ],
      "country": [
        {"_id": "5f8d8a7b54687e3a1400001a", "name": "UAE", "status": "ACTIVE"},
        // Add more items...
      ],
      "lead_source": [
        {
          "_id": "5f8d8a7b54687e3a1400001e",
          "name": "FACEBOOK",
          "status": "ACTIVE"
        },
        // Add more items...
      ],
      "service_type": [
        {
          "_id": "5f8d8a7b54687e3a14000020",
          "name": "MIGRATION",
          "status": "ACTIVE"
        },
        // Add more items...
      ],
      "call_type": [
        {
          "_id": "5f8d8a7b54687e3a14000029",
          "name": "INCOMING",
          "status": "ACTIVE"
        },
        // Add more items...
      ],
      "call_status": [
        {
          "_id": "5f8d8a7b54687e3a1400002c",
          "name": "ATTENDED",
          "status": "ACTIVE"
        },
        // Add more items...
      ],
      "client_status": [
        {
          "_id": "5f8d8a7b54687e3a1400002f",
          "name": "FOLLOW UP",
          "status": "ACTIVE",
          "colour": "0XFFFF5C5C"
        },
        // Add more items...
      ],
      "test": [
        {
          "_id": "5f8d8a7b54687e3a14000044",
          "name": "IELTS",
          "status": "ACTIVE"
        },
        // Add more items...
      ],
      "branch": [
        {
          "_id": "6880f11072758fd3e6b6752b",
          "name": "AFFINIX ",
          "address": "edappally",
          "phone": "124567778",
          "status": "ACTIVE"
        },
        // Add more items...
      ],
      "job_category": [
        {
          "_id": "6880f32d72758fd3e6b6752c",
          "name": "DOCTOR ",
          "status": "ACTIVE"
        },
        // Add more items...
      ],
      "specialized": [
        {
          "_id": "6870dcc9396fb1d521cfef8c",
          "name": "NICU",
          "status": "ACTIVE",
          "category": "NURSE"
        },
        // Add more items...
      ],
      "closed_status": [
        {
          "_id": "6881937af94bb11450150504",
          "name": "AGE OVER",
          "status": "ACTIVE"
        },
        // Add more items...
      ]
    };
    isLoading.value = false;
  }

  List<Map<String, dynamic>> getItemsByCategory(String category) {
    return List<Map<String, dynamic>>.from(configData.value?[category] ?? []);
  }

  void addItem(String category, Map<String, dynamic> newItem) {
    if (configData.value != null) {
      List<Map<String, dynamic>> items =
          List.from(configData.value![category] ?? []);

      // Generate new ID
      newItem['_id'] = DateTime.now().millisecondsSinceEpoch.toString();

      items.add(newItem);
      configData.value![category] = items;
      configData.refresh();

      Get.snackbar(
        'Success',
        'Item added successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void updateItem(
      String category, String itemId, Map<String, dynamic> updatedItem) {
    if (configData.value != null) {
      List<Map<String, dynamic>> items =
          List.from(configData.value![category] ?? []);

      int index = items.indexWhere((item) => item['_id'] == itemId);
      if (index != -1) {
        items[index] = {...items[index], ...updatedItem};
        configData.value![category] = items;
        configData.refresh();

        Get.snackbar(
          'Success',
          'Item updated successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  void deleteItem(String category, String itemId) {
    if (configData.value != null) {
      List<Map<String, dynamic>> items =
          List.from(configData.value![category] ?? []);

      items.removeWhere((item) => item['_id'] == itemId);
      configData.value![category] = items;
      configData.refresh();

      Get.snackbar(
        'Success',
        'Item deleted successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  List<String> getFieldsForCategory(String category) {
    switch (category) {
      case 'program_type':
        return ['name', 'status', 'colour'];
      case 'program':
        return ['name', 'program', 'status', 'address', 'phone', 'category'];
      case 'country':
        return ['name', 'status', 'colour'];
      case 'lead_source':
        return ['name', 'status'];
      case 'service_type':
        return ['name', 'status'];
      case 'call_type':
        return ['name', 'status'];
      case 'call_status':
        return ['name', 'status'];
      case 'client_status':
        return ['name', 'status', 'colour'];
      case 'test':
        return ['name', 'status'];
      case 'branch':
        return ['name', 'address', 'phone', 'status'];
      case 'job_category':
        return ['name', 'status'];
      case 'specialized':
        return ['name', 'status', 'category'];
      case 'closed_status':
        return ['name', 'status'];
      default:
        return ['name', 'status'];
    }
  }

  String getCategoryDisplayName(String category) {
    return category.replaceAll('_', ' ').toUpperCase();
  }
}


// import 'package:flutter/material.dart';
// import 'package:overseas_front_end/core/shared/enums.dart';
// import 'package:overseas_front_end/model/app_configs/config_list_model.dart';
// import 'package:overseas_front_end/model/app_configs/config_model.dart';

// import '../../core/services/api_service.dart';
// import '../../core/shared/constants.dart';

// class ConfigProvider extends ChangeNotifier {
//   ConfigProvider._privateConstructor() {
//     _init();
//   }

//   static final ConfigProvider _instance = ConfigProvider._privateConstructor();
//   factory ConfigProvider() => _instance;

//   final ApiService _api = ApiService();

//   bool isLoading = false;

//   ConfigListModel? configModelList;
//   Future<void> _init() async {
//     await fetchConfigData();
//   }

//   Future<void> fetchConfigData() async {
//     try {
//       // Example API call (you can replace this with real API)
//       // final response = await ConfigApi().getConfigItem(); // currently not used

//       // Temporary fallback data (for testing)
//       // final localData = {
//       //   "_id": "6829fcbf3deca8f5b103613b",
//       //   "name": "constants",
//       //   "education_program": [
//       //     {
//       //       "_id": "5f8d8a7b54687e3a14000001",
//       //       "name": "PG",
//       //       "status": "INACTIVE"
//       //     },
//       //     {"_id": "5f8d8a7b54687e3a14000002", "name": "UG", "status": "ACTIVE"},
//       //   ]
//       // };

//       // configModelList = ConfigListModel.fromJson(localData);
//       notifyListeners();
//     } catch (e) {}
//   }

//   Future<void> getConfigList(
//     context,
//   ) async {
//     isLoading = true;

//     try {
//       final response = await _api.get(context: context, Constant().configList);
//       configModelList = ConfigListModel.fromJson(response['data']);
//     } catch (e) {
//     } finally {
//       isLoading = false;
//     }
//     notifyListeners();
//   }

//   Future<void> addConfig(context,
//       {required String field, required String name, String colour = ""}) async {
//     isLoading = true;

//     Map colorMap = colour.isNotEmpty ? {"colour": colour} : {};

//     try {
//       final response =
//           await _api.patch(context: context, Constant().editConfigList, {
//         "field": field,
//         "action": "insert",
//         "value": {"name": name, "status": "ACTIVE", ...colorMap}
//       });
//       if (response['success'] == true) {
//         try {
//           configModelList?.insertItem(
//               field,
//               ConfigModel(
//                   name: name,
//                   // colour: response['value']['colour'],
//                   id: response['data']['insertedId'],
//                   status: Status.ACTIVE));
//           notifyListeners();
//         } catch (e) {
//           print(e);
//         }
//       }
//       // return response['success'] == true;
//     } catch (e) {
//       // return false;
//     } finally {
//       isLoading = false;
//       // await getConfigList();
//       notifyListeners();
//     }
//   }

//   void toggleStatus(context, String category, ConfigModel item) {
//     if (item.status == Status.ACTIVE) {
//       updateConfig(context,
//           field: category,
//           name: item.name ?? "",
//           id: item.id ?? "",
//           status: "INACTIVE");
//     } else {
//       updateConfig(context,
//           field: category,
//           name: item.name ?? "",
//           id: item.id ?? "",
//           status: "ACTIVE");
//     }
//   }

//   Future<bool> updateConfig(context,
//       {required String field,
//       required String name,
//       required String id,
//       required String status,
//       String colour = ""}) async {
//     isLoading = true;
//     Map colorMap = colour.isNotEmpty ? {"colour": colour} : {};

//     try {
//       final response =
//           await _api.patch(context: context, Constant().editConfigList, {
//         "field": field,
//         "action": "update",
//         "value": {"_id": id, "name": name, "status": status, ...colorMap}
//       });
//       if (response['success'] == true) {
//         configModelList?.updateItem(
//             field,
//             ConfigModel(
//               id: id,
//               colour: colour,
//               name: name,
//               status: status == "ACTIVE" ? Status.ACTIVE : Status.INACTIVE,
//             ));
//         notifyListeners();
//       }
//       return response['success'] == true;
//     } catch (e) {
//       return false;
//     } finally {
//       isLoading = false;
//       // await getConfigList();
//       notifyListeners();
//     }
//   }

//   Future<bool> deleteConfig(
//     context, {
//     required String field,
//     required String id,
//   }) async {
//     isLoading = true;
//     // notifyListeners();

//     try {
//       final response =
//           await _api.patch(context: context, Constant().editConfigList, {
//         "field": field,
//         "action": "delete",
//         "value": {
//           "_id": id,
//         }
//       });
//       // _campaignModel = CampaignModel.fromJson(response.data);
//       if (response['success'] == true) {
//         configModelList?.deleteItem(
//             field,
//             ConfigModel(
//               id: id,
//             ));
//         notifyListeners();
//       }
//       return response['success'] == true;
//     } catch (e) {
//       return false;
//     } finally {
//       isLoading = false;
//       // await getConfigList();
//       notifyListeners();
//     }
//   }

//   /// Removes an item from a category
//   void removeItem(context, String category, ConfigModel item) {
//     configModelList?.deleteItem(category, item);
//     notifyListeners();
//   }

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
// }

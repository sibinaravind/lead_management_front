import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:overseas_front_end/controller/app_user_provider.dart';
import 'package:overseas_front_end/controller/config/data_source/config_api.dart';
import 'package:overseas_front_end/model/app_configs/config_list_model.dart';
import 'package:overseas_front_end/model/app_configs/list_config_model.dart';

import '../../../../model/app_configs/config_model.dart';

class ConfigProvider extends ChangeNotifier {
  ConfigProvider._privateContstructor();
  static final ConfigProvider _instance = ConfigProvider._privateContstructor();
  factory ConfigProvider() {
    return _instance;
  }

  ConfigListModel? configModelList = ConfigListModel();

  void removeItem(category, item) {
    configModelList!.deleteItem(category, item);
    notifyListeners();
  }

  var data = {
    "_id": "6829fcbf3deca8f5b103613b",
    "name": "constants",
    "education_program": [
      {"_id": "5f8d8a7b54687e3a14000001", "name": "PG", "status": "INACTIVE"},
      {"_id": "5f8d8a7b54687e3a14000002", "name": "UG", "status": "ACTIVE"},
      {
        "_id": "5f8d8a7b54687e3a14000003",
        "name": "Diploma",
        "status": "ACTIVE"
      },
      {
        "_id": "5f8d8a7b54687e3a14000004",
        "name": "Pre Masters",
        "status": "ACTIVE"
      },
      {
        "_id": "5f8d8a7b54687e3a14000005",
        "name": "Masters by Taught",
        "status": "ACTIVE"
      },
      {
        "_id": "5f8d8a7b54687e3a14000006",
        "name": "Masters by Research",
        "status": "ACTIVE"
      },
      {
        "_id": "5f8d8a7b54687e3a14000007",
        "name": "Foundation",
        "status": "ACTIVE"
      },
      {"_id": "5f8d8a7b54687e3a14000008", "name": "10th", "status": "ACTIVE"},
      {"_id": "686a70015eb2af8e38c2eba7", "name": "MPhils", "status": "ACTIVE"}
    ],
    "known_languages": [
      {
        "_id": "5f8d8a7b54687e3a1400000a",
        "name": "Malayalam",
        "status": "ACTIVE"
      },
      {"_id": "5f8d8a7b54687e3a1400000b", "name": "English", "status": "ACTIVE"}
    ],
    "university": [
      {
        "_id": "5f8d8a7b54687e3a1400000c",
        "name": "Cam",
        "code": "12",
        "country": "Canada",
        "province": "CAN",
        "status": "ACTIVE"
      },
      {
        "_id": "5f8d8a7b54687e3a1400000d",
        "name": "2",
        "code": "12",
        "country": "Canada",
        "province": "CAN",
        "status": "INACTIVE"
      }
    ],
    "intake": [
      {"_id": "5f8d8a7b54687e3a1400000e", "name": "Jan", "status": "ACTIVE"},
      {"_id": "5f8d8a7b54687e3a1400000f", "name": "Feb", "status": "ACTIVE"},
      {"_id": "5f8d8a7b54687e3a14000010", "name": "Mar", "status": "ACTIVE"},
      {"_id": "5f8d8a7b54687e3a14000011", "name": "Apr", "status": "ACTIVE"},
      {"_id": "5f8d8a7b54687e3a14000012", "name": "May", "status": "ACTIVE"},
      {"_id": "5f8d8a7b54687e3a14000013", "name": "Jun", "status": "ACTIVE"},
      {"_id": "5f8d8a7b54687e3a14000014", "name": "Jul", "status": "ACTIVE"},
      {"_id": "5f8d8a7b54687e3a14000015", "name": "Aug", "status": "ACTIVE"},
      {"_id": "5f8d8a7b54687e3a14000016", "name": "Sep", "status": "ACTIVE"},
      {"_id": "5f8d8a7b54687e3a14000017", "name": "Oct", "status": "ACTIVE"},
      {"_id": "5f8d8a7b54687e3a14000018", "name": "Nov", "status": "ACTIVE"},
      {"_id": "5f8d8a7b54687e3a14000019", "name": "Dec", "status": "ACTIVE"}
    ],
    "country": [
      {"_id": "5f8d8a7b54687e3a1400001a", "name": "UAE", "status": "ACTIVE"},
      {"_id": "5f8d8a7b54687e3a1400001b", "name": "US", "status": "ACTIVE"}
    ],
    "lead_category": [
      {
        "_id": "5f8d8a7b54687e3a1400001c",
        "name": "Potential",
        "status": "ACTIVE"
      },
      {
        "_id": "5f8d8a7b54687e3a1400001d",
        "name": "Non-Potential",
        "status": "ACTIVE"
      }
    ],
    "lead_source": [
      {
        "_id": "5f8d8a7b54687e3a1400001e",
        "name": "Facebook",
        "status": "ACTIVE"
      },
      {
        "_id": "5f8d8a7b54687e3a1400001f",
        "name": "Instagram",
        "status": "ACTIVE"
      }
    ],
    "service_type": [
      {
        "_id": "5f8d8a7b54687e3a14000020",
        "name": "Migration",
        "status": "ACTIVE"
      },
      {
        "_id": "5f8d8a7b54687e3a14000021",
        "name": "Outgoing",
        "status": "ACTIVE"
      }
    ],
    "profession": [
      {
        "_id": "5f8d8a7b54687e3a14000022",
        "name": "Medical",
        "status": "ACTIVE"
      },
      {
        "_id": "5f8d8a7b54687e3a14000023",
        "name": "Non-Medical",
        "status": "ACTIVE"
      }
    ],
    "medical_profession_category": [
      {
        "_id": "5f8d8a7b54687e3a14000024",
        "name": "Operation Theater",
        "status": "ACTIVE"
      },
      {"_id": "5f8d8a7b54687e3a14000025", "name": "ICU", "status": "ACTIVE"},
      {"_id": "5f8d8a7b54687e3a14000026", "name": "NICU", "status": "ACTIVE"}
    ],
    "non_medical": [
      {"_id": "5f8d8a7b54687e3a14000027", "name": "IT", "status": "ACTIVE"},
      {
        "_id": "5f8d8a7b54687e3a14000028",
        "name": "Cleaning",
        "status": "ACTIVE"
      }
    ],
    "call_type": [
      {
        "_id": "5f8d8a7b54687e3a14000029",
        "name": "Incoming",
        "status": "ACTIVE"
      },
      {
        "_id": "5f8d8a7b54687e3a1400002a",
        "name": "Outgoing",
        "status": "ACTIVE"
      },
      {"_id": "5f8d8a7b54687e3a1400002b", "name": "Missed", "status": "ACTIVE"}
    ],
    "call_status": [
      {
        "_id": "5f8d8a7b54687e3a1400002c",
        "name": "Attended",
        "status": "ACTIVE"
      },
      {
        "_id": "5f8d8a7b54687e3a1400002d",
        "name": "Not Attended",
        "status": "ACTIVE"
      },
      {
        "_id": "5f8d8a7b54687e3a1400002e",
        "name": "Switched Off",
        "status": "ACTIVE"
      }
    ],
    "client_status": [
      {
        "_id": "5f8d8a7b54687e3a1400002f",
        "name": "FOLLOW UP",
        "status": "ACTIVE",
        "colour": "0XFFFFA500"
      },
      {
        "_id": "5f8d8a7b54687e3a14000030",
        "name": "INTERESTED",
        "status": "ACTIVE",
        "colour": "0XFF4CAF50"
      },
      {
        "_id": "5f8d8a7b54687e3a14000031",
        "name": "NOT INTERESTED",
        "status": "ACTIVE",
        "colour": "0XFFF44336"
      },
      {
        "_id": "5f8d8a7b54687e3a14000032",
        "name": "IN DISCUSSION",
        "status": "ACTIVE",
        "colour": "0XFF03A9F4"
      },
      {
        "_id": "5f8d8a7b54687e3a14000033",
        "name": "DOCUMENTS PENDING",
        "status": "ACTIVE",
        "colour": "0XFFFF9800"
      },
      {
        "_id": "5f8d8a7b54687e3a14000034",
        "name": "APPLICATION SUBMITTED",
        "status": "ACTIVE",
        "colour": "0XFF3F51B5"
      },
      {
        "_id": "5f8d8a7b54687e3a14000035",
        "name": "OFFER RECEIVED",
        "status": "ACTIVE",
        "colour": "0XFF009688"
      },
      {
        "_id": "5f8d8a7b54687e3a14000036",
        "name": "PAYMENT PENDING",
        "status": "ACTIVE",
        "colour": "0XFFFFC107"
      },
      {
        "_id": "5f8d8a7b54687e3a14000037",
        "name": "PAYMENT RECEIVED",
        "status": "ACTIVE",
        "colour": "0XFF8BC34A"
      },
      {
        "_id": "5f8d8a7b54687e3a14000038",
        "name": "VISA FILED",
        "status": "ACTIVE",
        "colour": "0XFF00BCD4"
      },
      {
        "_id": "5f8d8a7b54687e3a14000039",
        "name": "VISA APPROVED",
        "status": "ACTIVE",
        "colour": "0XFF4CAF50"
      },
      {
        "_id": "5f8d8a7b54687e3a1400003a",
        "name": "VISA REJECTED",
        "status": "ACTIVE",
        "colour": "0XFFD32F2F"
      },
      {
        "_id": "5f8d8a7b54687e3a1400003b",
        "name": "READY TO FLY",
        "status": "ACTIVE",
        "colour": "0XFF9C27B0"
      },
      {
        "_id": "5f8d8a7b54687e3a1400003c",
        "name": "COMPLETED",
        "status": "ACTIVE",
        "colour": "0XFF607D8B"
      },
      {
        "_id": "5f8d8a7b54687e3a1400003d",
        "name": "DROPPED",
        "status": "ACTIVE",
        "colour": "0XFF795548"
      },
      {
        "_id": "5f8d8a7b54687e3a1400003e",
        "name": "BLOCKED",
        "status": "INACTIVE",
        "colour": "0XFFBDBDBD"
      }
    ],
    "designation": [
      {"_id": "5f8d8a7b54687e3a1400003f", "name": "admin", "status": "ACTIVE"},
      {
        "_id": "5f8d8a7b54687e3a14000040",
        "name": "Junior counselor",
        "status": "ACTIVE"
      },
      {
        "_id": "686aa1fc93de920ff70c9e96",
        "name": "Team Lead",
        "status": "ACTIVE"
      },
      {
        "_id": "5f8d8a7b54687e3a14000041",
        "name": "manager",
        "status": "ACTIVE"
      },
      {
        "_id": "5f8d8a7b54687e3a14000042",
        "name": "front_desk",
        "status": "ACTIVE"
      },
      {
        "_id": "5f8d8a7b54687e3a14000043",
        "name": "documentation",
        "status": "ACTIVE"
      }
    ],
    "department": [
      {
        "_id": "686aa23793de920ff70c9e97",
        "name": "counselor",
        "status": "ACTIVE"
      },
      {
        "_id": "686aa26c93de920ff70c9e98",
        "name": "documentation",
        "status": "ACTIVE"
      }
    ],
    "test": [
      {"_id": "5f8d8a7b54687e3a14000044", "name": "IELTS", "status": "ACTIVE"},
      {"_id": "5f8d8a7b54687e3a14000045", "name": "PTE", "status": "ACTIVE"},
      {"_id": "5f8d8a7b54687e3a14000046", "name": "TOEFL", "status": "ACTIVE"}
    ],
    "branch": [
      {
        "_id": "5f8d8a7b54687e3a14000047",
        "name": "Affinix",
        "status": "ACTIVE"
      },
      {
        "_id": "5f8d8a7b54687e3a14000048",
        "name": "HeadOffice",
        "status": "ACTIVE"
      }
    ]
  };

  // Map<String, List<Map<String, dynamic>>> permissionsData = {
  //   'Education Programs': [
  //     {'name': 'PG', 'status': 'active'},
  //     {'name': 'UG', 'status': 'active'},
  //     {'name': 'Diploma', 'status': 'active'},
  //     {'name': 'Pre Masters', 'status': 'active'},
  //     {'name': 'Masters by Taught', 'status': 'active'},
  //     {'name': 'Masters by Research', 'status': 'active'},
  //     {'name': 'Foundation', 'status': 'active'},
  //     {'name': '10th', 'status': 'active'},
  //     {'name': '12th', 'status': 'active'},
  //     {'name': 'PhD', 'status': 'active'},
  //   ],
  //   'Known Languages': [
  //     {'name': 'Malayalam', 'status': 'active'},
  //     {'name': 'English', 'status': 'active'},
  //     {'name': 'Hindi', 'status': 'active'},
  //   ],
  //   'Universities': [
  //     {
  //       'name': 'Cam',
  //       'code': '12',
  //       'country': 'Canada',
  //       'province': 'CAN',
  //       'status': 'active'
  //     },
  //     {
  //       'name': 'Oxford',
  //       'code': '13',
  //       'country': 'UK',
  //       'province': 'ENG',
  //       'status': 'inactive'
  //     },
  //     {
  //       'name': 'MIT',
  //       'code': '14',
  //       'country': 'USA',
  //       'province': 'MA',
  //       'status': 'active'
  //     },
  //     {
  //       'name': 'Stanford',
  //       'code': '15',
  //       'country': 'USA',
  //       'province': 'CA',
  //       'status': 'active'
  //     },
  //   ],
  // };

  void toggleStatus(String category, ConfigModel item) {
    // item['status'] = item['status'] == 'active' ? 'inactive' : 'active';
    notifyListeners();
  }

  void getConfigData() {
    try {
      ConfigApi().getConfigItem();
      // ListConfigModel model = ListConfigModel.fromJson(data);
      configModelList = ConfigListModel.fromJson(data);
    } catch (e) {
      print(e);
    }
    // notifyListeners();
  }

  Future<bool> editProgramApi({required Map<String, dynamic> data}) async {
    final response = await ApiService().patch("endpoint", data);
    if (response.statusCode == 200) return true;
    return false;
  }

  Future<bool> addProgramApi({required Map<String, dynamic> data}) async {
    final response = await ApiService().put("endpoint", data);
    if (response.statusCode == 200) return true;

    return false;
  }

  Future<bool> deleteProgramApi({required Map<String, dynamic> data}) async {
    final response = await ApiService().delete("endpoint", data);
    if (response.statusCode == 200) return true;

    return false;
  }

  // void editEducationProgram() {}

  // void addEducationProgram() {}

  // void deleteEducationProgram() {}

  // void editLangsProgram() {}

  // void addLangsProgram() {}

  // void deleteLangsProgram() {}

  // void editUniversityProgram() {}

  // void addUniversityProgram() {}

  // void deleteUniversityProgram() {}

  // void editIntakeProgram() {}

  // void addIntakeProgram() {}

  // void deleteIntakeProgram() {}

  // void editCountryProgram() {}

  // void addCountryProgram() {}

  // void deleteCountryProgram() {}

  // void editLeadCategoryProgram() {}

  // void addLeadCategoryProgram() {}

  // void deleteLeadCategoryProgram() {}

  // void editCountryProgram() {}

  // void addCountryProgram() {}

  // void deleteCountryProgram() {}

  // void editCountryProgram() {}

  // void addCountryProgram() {}

  // void deleteCountryProgram() {}
}

class ApiService {
  // Singleton pattern (optional but recommended)
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  late Dio _dio;

  void init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: '', // Replace with your API base URL
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    // You can add interceptors for logging, auth, etc.
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  Future<Response> get(String endpoint,
      {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: queryParams);
      return response;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Response> post(String endpoint, dynamic data) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Response> patch(String endpoint, dynamic data) async {
    try {
      final response = await _dio.patch(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Response> put(String endpoint, dynamic data) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Response> delete(String endpoint, data) async {
    try {
      final response = await _dio.delete(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  void _handleError(DioException e) {
    // Basic error handling
    if (e.type == DioExceptionType.connectionTimeout) {
      print("Connection Timeout");
    } else if (e.type == DioExceptionType.receiveTimeout) {
      print("Receive Timeout");
    } else if (e.type == DioExceptionType.badResponse) {
      print("Bad Response: ${e.response?.statusCode} - ${e.response?.data}");
    } else {
      print("Unhandled Dio error: $e");
    }
  }
}

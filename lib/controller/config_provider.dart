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
            {
              "_id": "5f8d8a7b54687e3a14000002",
              "name": "UG",
              "status": "ACTIVE"
            },
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
            {
              "_id": "5f8d8a7b54687e3a14000008",
              "name": "10th",
              "status": "ACTIVE"
            },
            {
              "_id": "686a70015eb2af8e38c2eba7",
              "name": "MPhils",
              "status": "ACTIVE"
            },
            {
              "_id": "686b79ead1602c72763f86fa",
              "name": "MPhil",
              "status": "ACTIVE"
            }
          ],
          "known_languages": [
            {
              "_id": "5f8d8a7b54687e3a1400000a",
              "name": "Malayalam",
              "status": "ACTIVE"
            },
            {
              "_id": "5f8d8a7b54687e3a1400000b",
              "name": "English",
              "status": "ACTIVE"
            }
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
            {
              "_id": "5f8d8a7b54687e3a1400000e",
              "name": "Jan",
              "status": "ACTIVE"
            },
            {
              "_id": "5f8d8a7b54687e3a1400000f",
              "name": "Feb",
              "status": "ACTIVE"
            },
            {
              "_id": "5f8d8a7b54687e3a14000010",
              "name": "Mar",
              "status": "ACTIVE"
            },
            {
              "_id": "5f8d8a7b54687e3a14000011",
              "name": "Apr",
              "status": "ACTIVE"
            },
            {
              "_id": "5f8d8a7b54687e3a14000012",
              "name": "May",
              "status": "ACTIVE"
            },
            {
              "_id": "5f8d8a7b54687e3a14000013",
              "name": "Jun",
              "status": "ACTIVE"
            },
            {
              "_id": "5f8d8a7b54687e3a14000014",
              "name": "Jul",
              "status": "ACTIVE"
            },
            {
              "_id": "5f8d8a7b54687e3a14000015",
              "name": "Aug",
              "status": "ACTIVE"
            },
            {
              "_id": "5f8d8a7b54687e3a14000016",
              "name": "Sep",
              "status": "ACTIVE"
            },
            {
              "_id": "5f8d8a7b54687e3a14000017",
              "name": "Oct",
              "status": "ACTIVE"
            },
            {
              "_id": "5f8d8a7b54687e3a14000018",
              "name": "Nov",
              "status": "ACTIVE"
            },
            {
              "_id": "5f8d8a7b54687e3a14000019",
              "name": "Dec",
              "status": "ACTIVE"
            }
          ],
          "country": [
            {
              "_id": "5f8d8a7b54687e3a1400001a",
              "name": "UAE",
              "status": "ACTIVE"
            },
            {
              "_id": "5f8d8a7b54687e3a1400001b",
              "name": "US",
              "status": "ACTIVE"
            }
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
            {
              "_id": "5f8d8a7b54687e3a14000025",
              "name": "ICU",
              "status": "ACTIVE"
            },
            {
              "_id": "5f8d8a7b54687e3a14000026",
              "name": "NICU",
              "status": "ACTIVE"
            }
          ],
          "non_medical": [
            {
              "_id": "5f8d8a7b54687e3a14000027",
              "name": "IT",
              "status": "ACTIVE"
            },
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
            {
              "_id": "5f8d8a7b54687e3a1400002b",
              "name": "Missed",
              "status": "ACTIVE"
            }
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
            {
              "_id": "5f8d8a7b54687e3a1400003f",
              "name": "admin",
              "code": "1",
              "status": "ACTIVE"
            },
            {
              "_id": "5f8d8a7b54687e3a14000041",
              "code": "2",
              "name": "Manager",
              "status": "ACTIVE"
            },
            {
              "_id": "5f8d8a7b54687e3a14000041",
              "code": "3",
              "name": "Counselor Team Lead",
              "status": "ACTIVE"
            },
            {
              "_id": "5f8d8a7b54687e3a14000040",
              "code": "4",
              "name": "Junior counselor",
              "status": "ACTIVE"
            },
            {
              "_id": "5f8d8a7b54687e3a14000040",
              "code": "4",
              "name": "Senior counselor",
              "status": "ACTIVE"
            },
            {
              "_id": "686aa1fc93de920ff70c9e96",
              "code": "6",
              "name": "Documentation Team Lead",
              "status": "ACTIVE"
            },
            {
              "_id": "686aa1fc93de920ff70c9e96",
              "code": "7",
              "name": "Documentation Team",
              "status": "ACTIVE"
            },
            {
              "_id": "5f8d8a7b54687e3a14000042",
              "code": "8",
              "name": "CRE",
              "status": "ACTIVE"
            }
          ],
          "department": [
            {
              "_id": "686bd7fceb026cb8dfbde82a",
              "name": "Admin",
              "status": "ACTIVE"
            },
            {
              "_id": "686bd80eeb026cb8dfbde82b",
              "name": "ACCOUNTING",
              "status": "ACTIVE"
            },
            {
              "_id": "686bd81aeb026cb8dfbde82c",
              "name": "CRE",
              "status": "ACTIVE"
            },
            {
              "_id": "686bd84eeb026cb8dfbde82d",
              "name": "COUNSELLOR",
              "status": "ACTIVE"
            }
          ],
          "test": [
            {
              "_id": "5f8d8a7b54687e3a14000044",
              "name": "IELTS",
              "status": "ACTIVE"
            },
            {
              "_id": "5f8d8a7b54687e3a14000045",
              "name": "PTE",
              "status": "ACTIVE"
            },
            {
              "_id": "5f8d8a7b54687e3a14000046",
              "name": "TOEFL",
              "status": "ACTIVE"
            }
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

      configModelList = ConfigListModel.fromJson(localData);
      print(configModelList?.toJson());
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

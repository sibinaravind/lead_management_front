import 'package:flutter/material.dart';

import '../model/app_configs/config_model.dart';
import '../model/officer/user_model.dart';

class AppUserProvider extends ChangeNotifier {
  int? selectedIndex = 0;
  UserModel? userModel;
  ConfigModel? configModel;

  getConfigConstants() async {
    configModel = ConfigModel.fromMap(data);
    // var result = await AppUserApi().getConfigItem();
    // result.fold(
    //   (failure) {},
    //   (data) async {
    //     configList.value = data;
    //   },
    // );
  }

  void updateIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  UserModel getUserDetails() {
    if (userModel != null) {
      return userModel ?? const UserModel();
    }
    // userModel = serviceLocator<UserCacheService>().getUser();
    return userModel ?? const UserModel();
  }

  var data = {
    "success": true,
    "data": {
      "_id": "6829fcbf3deca8f5b103613b",
      "name": "constants",
      "education_program": [
        {"name": "PG", "status": "active"},
        {"name": "UG", "status": "active"},
        {"name": "Diploma", "status": "active"},
        {"name": "Pre Masters", "status": "active"},
        {"name": "Masters by Taught", "status": "active"},
        {"name": "Masters by Research", "status": "active"},
        {"name": "Foundation", "status": "active"},
        {"name": "10th", "status": "active"},
        {"name": "12th", "status": "active"}
      ],
      "known_languages": [
        {"name": "Malayalam", "status": "active"},
        {"name": "English", "status": "active"}
      ],
      "university": [
        {
          "name": "Cam",
          "code": "12",
          "country": "Canada",
          "province": "CAN",
          "status": "active"
        },
        {
          "name": "2",
          "code": "12",
          "country": "Canada",
          "province": "CAN",
          "status": "inactive"
        }
      ],
      "intake": [
        {"name": "Jan", "status": "active"},
        {"name": "Feb", "status": "active"},
        {"name": "Mar", "status": "active"},
        {"name": "Apr", "status": "active"},
        {"name": "May", "status": "active"},
        {"name": "Jun", "status": "active"},
        {"name": "Jul", "status": "active"},
        {"name": "Aug", "status": "active"},
        {"name": "Sep", "status": "active"},
        {"name": "Oct", "status": "active"},
        {"name": "Nov", "status": "active"},
        {"name": "Dec", "status": "active"}
      ],
      "country": [
        {"name": "UAE", "status": "active"},
        {"name": "US", "status": "active"}
      ],
      "lead_category": [
        {"name": "Potential", "status": "active"},
        {"name": "Non-Potential", "status": "active"}
      ],
      "lead_source": [
        {"name": "Facebook", "status": "active"},
        {"name": "Instagram", "status": "active"}
      ],
      "service_type": [
        {"name": "Migration", "status": "active"},
        {"name": "Outgoing", "status": "active"}
      ],
      "profession": [
        {"name": "Medical", "status": "active"},
        {"name": "Non-Medical", "status": "active"}
      ],
      "medical_profession_category": [
        {"name": "Operation Theater", "status": "active"},
        {"name": "ICU", "status": "active"},
        {"name": "NICU", "status": "active"}
      ],
      "non_medical": [
        {"name": "IT", "status": "active"},
        {"name": "Cleaning", "status": "active"}
      ],
      "call_type": [
        {"name": "Incoming", "status": "active"},
        {"name": "Outgoing", "status": "active"},
        {"name": "Missed", "status": "active"}
      ],
      "call_status": [
        {"name": "Attended", "status": "active"},
        {"name": "Not Attended", "status": "active"},
        {"name": "Switched Off", "status": "active"}
      ],
      "client_status": [
        {"name": "FOLLOW UP", "status": "active", "colour": "0XFFFFA500"},
        {"name": "INTERESTED", "status": "active", "colour": "0XFF4CAF50"},
        {"name": "NOT INTERESTED", "status": "active", "colour": "0XFFF44336"},
        {"name": "IN DISCUSSION", "status": "active", "colour": "0XFF03A9F4"},
        {
          "name": "DOCUMENTS PENDING",
          "status": "active",
          "colour": "0XFFFF9800"
        },
        {
          "name": "APPLICATION SUBMITTED",
          "status": "active",
          "colour": "0XFF3F51B5"
        },
        {"name": "OFFER RECEIVED", "status": "active", "colour": "0XFF009688"},
        {"name": "PAYMENT PENDING", "status": "active", "colour": "0XFFFFC107"},
        {
          "name": "PAYMENT RECEIVED",
          "status": "active",
          "colour": "0XFF8BC34A"
        },
        {"name": "VISA FILED", "status": "active", "colour": "0XFF00BCD4"},
        {"name": "VISA APPROVED", "status": "active", "colour": "0XFF4CAF50"},
        {"name": "VISA REJECTED", "status": "active", "colour": "0XFFD32F2F"},
        {"name": "READY TO FLY", "status": "active", "colour": "0XFF9C27B0"},
        {"name": "COMPLETED", "status": "active", "colour": "0XFF607D8B"},
        {"name": "DROPPED", "status": "active", "colour": "0XFF795548"},
        {"name": "BLOCKED", "status": "inactive", "colour": "0XFFBDBDBD"}
      ],
      "designation": [
        {"name": "admin", "status": "active"},
        {"name": "counselor", "status": "active"},
        {"name": "manager", "status": "active"},
        {"name": "front_desk", "status": "active"},
        {"name": "documentation", "status": "active"}
      ],
      "test": [
        {"name": "IELTS", "status": "active"},
        {"name": "PTE", "status": "active"},
        {"name": "TOEFL", "status": "active"}
      ],
      "branch": [
        {"name": "Affinix", "status": "active"},
        {"name": "HeadOffice", "status": "active"}
      ]
    }
  };
}

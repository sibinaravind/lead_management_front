import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:overseas_front_end/core/di/service_locator.dart';
import 'package:overseas_front_end/core/services/api_service.dart'
    show ApiService;
import 'package:overseas_front_end/model/app_configs/config_list_model.dart';
import '../../../core/services/user_cache_service.dart';
import '../../../core/shared/constants.dart';
import '../../../model/officer/officer_model.dart';
import '../../../view/screens/error_screen/error_screen.dart';
// import '../data_source/dashboard_api.dart';

class AppUserController extends GetxController {
  var selectedIndex = 0.obs;
  OfficerModel? userModel;
  var configList = ConfigListModel().obs;
  @override
  void onInit() {
    super.onInit();
    getUserDetails();
    getConfigConstants();
  }

  getConfigConstants() async {
    try {
      var result = await ApiService().getRequest(
          endpoint: Constant().configList,
          fromJson: (json) => ConfigListModel.fromJson(json));
      result.fold(
        (failure) {
          // CustomSnackBar.showMessage(
          //   "Failed to fetch configuration",
          //   "Configuration fetched successfully",
          //   backgroundColor: Colors.red,
          // );
        },
        (data) async {
          GoRouter.of(Get.key.currentContext!).replace('/');
          GoRouter.of(Get.key.currentContext!).push('/error');

          await Future.delayed(Duration(seconds: 2), () {
            Get.back();
          });
          configList.value = data;
        },
      );
    } catch (e) {
      print("Exception occurred while fetching config: $e");
    }
  }

  void updateIndex(int index) {
    selectedIndex.value = index;
  }

  OfficerModel getUserDetails() {
    if (userModel != null && userModel!.id != null) {
      return userModel ?? OfficerModel();
    }
    userModel = serviceLocator<UserCacheService>().getUser();
    return userModel ?? OfficerModel();
  }
}

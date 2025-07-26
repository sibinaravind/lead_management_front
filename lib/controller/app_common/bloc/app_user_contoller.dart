import 'package:get/get.dart';
import 'package:overseas_front_end/core/di/service_locator.dart';
import 'package:overseas_front_end/model/app_configs/config_list_model.dart';
import '../../../core/services/user_cache_service.dart';
import '../../../model/officer/officer_model.dart';
import '../data_source/app_user_api.dart';
// import '../data_source/dashboard_api.dart';

class AppUserController extends GetxController {
  var selectedIndex = 0.obs;
  OfficerModel? userModel;
  var configList = ConfigListModel().obs;
  @override
  void onInit() {
    super.onInit();
    // getUserDetails();
    // getConfigConstants();
  }

  getConfigConstants() async {
    var result = await AppUserApi().getConfigItem();
    result.fold(
      (failure) {},
      (data) async {
        configList.value = data;
      },
    );
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

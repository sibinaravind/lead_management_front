import 'package:get/get.dart';
import 'package:overseas_front_end/core/services/api_service.dart'
    show ApiService;
import 'package:overseas_front_end/model/app_configs/config_list_model.dart';
import '../../../core/shared/constants.dart';
import '../../../model/officer/officer_model.dart';
// import '../data_source/dashboard_api.dart';

class AppUserController extends GetxController {
  OfficerModel? userModel;

  var configList = ConfigListModel().obs;
  @override
  void onInit() {
    super.onInit();
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
          // GoRouter.of(Get.key.currentContext!).replace('/');
          // GoRouter.of(Get.key.currentContext!).push('/error');

          // await Future.delayed(Duration(seconds: 2), () {
          //   NavigationService.goBack();
          // });
          configList.value = data;
        },
      );
    } catch (e) {
      print("Exception occurred while fetching config: $e");
    }
  }
}

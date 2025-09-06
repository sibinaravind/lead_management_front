import 'dart:ui';

import 'package:get/get.dart';

import '../../controller/config/config_controller.dart';
import '../../model/app_configs/config_model.dart';

Color? getColorBasedOnStatus(String status) {
  String? value = Get.find<ConfigController>()
          .configData
          .value
          .clientStatus
          ?.firstWhere(
            (element) =>
                element.name?.toLowerCase() == status.toString().toLowerCase(),
            orElse: () => ConfigModel(colour: "0XFFBDBDBD"),
          )
          .colour ??
      "0XFFBDBDBD";
  return hexToColorWithAlpha(value);
}

Color hexToColorWithAlpha(String hexString) {
  hexString = hexString.replaceFirst('0X', '');
  return Color(int.parse(hexString, radix: 16));
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/res/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/custom_text.dart';

class CustomSnackBar {
  CustomSnackBar._();

  static void show(BuildContext context, String message,
      {Duration duration = const Duration(seconds: 3),
      Color backgroundColor = AppColors.blackNeutralColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CustomText(
          text: message,
          color: Colors.white,
          maxLines: 3,
        ),
        backgroundColor: backgroundColor,
        duration: duration,
      ),
    );
  }

  static void showMessage(String title, String message,
      {Duration duration = const Duration(seconds: 3),
      Color backgroundColor = Colors.transparent,
      Color colorText = Colors.white}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: backgroundColor,
      colorText: colorText,
    );
  }
}

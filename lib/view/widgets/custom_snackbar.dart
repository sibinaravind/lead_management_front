import 'package:flutter/material.dart';
import 'package:overseas_front_end/res/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/custom_text.dart';

class CustomSnackBar {
  CustomSnackBar._();

  static void show(BuildContext context, String message,
      {Duration duration = const Duration(seconds: 3)}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CustomText(
          text: message,
          color: Colors.white,
          maxLines: 3,
        ),
        backgroundColor: AppColors.blackNeutralColor,
        duration: duration,
      ),
    );
  }
}

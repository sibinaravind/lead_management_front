import 'package:flutter/material.dart';
import 'package:overseas_front_end/utils/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/custom_text.dart';

import '../../my_app.dart';

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
    final context = routerNavigatorKey.currentContext;
    if (context == null) {
      debugPrint("❌ Navigator context is null — cannot show snackbar");
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: colorText)),
        backgroundColor: backgroundColor,
        duration: duration,
      ),
    );
  }
}

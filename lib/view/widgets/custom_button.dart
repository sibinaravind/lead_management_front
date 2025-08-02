import 'package:flutter/material.dart';

import '../../utils/style/colors/colors.dart';
import 'widgets.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? color;
  final double? width;
  final double? height;
  final double? borderRadius;
  final void Function()? onTap;

  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.width = double.infinity,
    this.height = 36,
    this.borderRadius,
    this.fontSize = 16,
    this.color = AppColors.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? AppColors.primaryColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 3),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.2),
          //     offset: Offset(0, 2),
          //     blurRadius: 4,
          //   ),
          // ],
        ),
        alignment: Alignment.center,
        child: CustomText(
          text: text,
          textAlign: TextAlign.center,
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}

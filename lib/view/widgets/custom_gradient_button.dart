import 'package:flutter/material.dart';
import 'package:overseas_front_end/res/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';

class CustomGradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Gradient gradientColors;
  final double borderRadius;
  final double height;
  final double width;

  const CustomGradientButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.gradientColors = AppColors.buttonGraidentColour,
    this.borderRadius = 24.0,
    this.height = 48.0,
    this.width = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 20,
        minWidth: 45,
        maxHeight: 30,
        maxWidth: 150,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: gradientColors,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(borderRadius),
            onTap: onPressed,
            child: Center(
              child: CustomText(
                text: text,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

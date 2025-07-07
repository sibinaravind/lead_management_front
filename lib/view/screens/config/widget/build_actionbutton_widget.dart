import 'package:flutter/material.dart';

import '../../../../res/style/colors/colors.dart';


class BuildActionButtonWidget extends StatelessWidget {

  final IconData icon;
  final LinearGradient gradient;
  final VoidCallback onTap;
  final String tooltip;
  const BuildActionButtonWidget({super.key,
    required this.icon, required this.gradient, required this.onTap, required this.tooltip,});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: gradient.colors.first.withOpacity(0.3),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: AppColors.whiteMainColor,
            size: 16,
          ),
        ),
      ),
    );
  }
}
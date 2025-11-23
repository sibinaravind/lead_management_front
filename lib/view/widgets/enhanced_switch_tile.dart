import 'package:flutter/material.dart';
import 'package:overseas_front_end/utils/style/colors/colors.dart';

import 'custom_text.dart';

class EnhancedSwitchTile extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool value;
  final ValueChanged<bool> onChanged;

  const EnhancedSwitchTile({
    super.key,
    required this.label,
    this.icon,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: value
            ? AppColors.violetPrimaryColor.withOpacity(0.1)
            : Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: value
                ? AppColors.violetPrimaryColor.withOpacity(0.3)
                : Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,
              size: 18,
              color:
                  value ? AppColors.violetPrimaryColor : Colors.grey.shade600),
          const SizedBox(width: 12),
          Expanded(
            child: CustomText(
                text: label,
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: value
                    ? AppColors.violetPrimaryColor
                    : AppColors.primaryColor),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.violetPrimaryColor,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }
}

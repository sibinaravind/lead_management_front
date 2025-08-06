import 'package:flutter/material.dart';
import '../../../../../utils/style/colors/colors.dart';

import 'custom_text.dart';

class FilterToggleButtonsWidget extends StatelessWidget {
  final bool isFilterActive;
  final VoidCallback onReset;
  final VoidCallback onToggle;

  const FilterToggleButtonsWidget({
    super.key,
    required this.isFilterActive,
    required this.onReset,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Reset button
        GestureDetector(
          onTap: onReset,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isFilterActive ? AppColors.primaryColor : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isFilterActive
                    ? AppColors.primaryColor
                    : Colors.grey.shade300,
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.refresh,
                  color: isFilterActive ? Colors.white : AppColors.primaryColor,
                  size: 18,
                ),
                CustomText(
                  text: "Reset",
                  color: isFilterActive ? Colors.white : AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),

        // Filter toggle button
        GestureDetector(
          onTap: onToggle,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isFilterActive ? AppColors.primaryColor : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isFilterActive
                    ? AppColors.primaryColor
                    : Colors.grey.shade300,
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.filter_list,
                  color: isFilterActive ? Colors.white : AppColors.primaryColor,
                  size: 18,
                ),
                const SizedBox(width: 8),
                CustomText(
                  text: "Filters",
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: isFilterActive ? Colors.white : AppColors.primaryColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

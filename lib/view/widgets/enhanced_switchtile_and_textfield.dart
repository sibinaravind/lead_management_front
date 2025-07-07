import 'package:flutter/material.dart';
import 'package:overseas_front_end/res/style/colors/colors.dart';

import 'custom_text.dart';

class EnhancedSwitchTileWithButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool visibleButton;
  final VoidCallback? onPressed;
  final bool hasPdf;

  const EnhancedSwitchTileWithButton(
      {super.key,
      required this.label,
      required this.icon,
      required this.value,
      required this.onChanged,
      required this.visibleButton,
      required this.onPressed,
      required this.hasPdf});

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
        // spacing: 10,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(icon,
              size: 18,
              color:
                  value ? AppColors.violetPrimaryColor : Colors.grey.shade600),
          const SizedBox(width: 12),
          Expanded(
            flex: 4,
            child: CustomText(
                text: label,
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: value
                    ? AppColors.violetPrimaryColor
                    : AppColors.primaryColor),
          ),
          Expanded(
            flex: 2,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: AppColors.violetPrimaryColor,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          Visibility(
            visible: visibleButton,
            child: Expanded(
              flex: 1,
              child: SizedBox(
                width: 100,
                child: OutlinedButton.icon(
                  onPressed: onPressed,
                  icon: const Icon(Icons.upload_rounded, size: 16),
                  label: const CustomText(text: 'Upload', fontSize: 12),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    side:  BorderSide(color: AppColors.violetPrimaryColor),
                    foregroundColor: AppColors.violetPrimaryColor,
                  ),
                ),
              ),
            ),
          ),
          if (hasPdf) ...[
            const SizedBox(width: 10),
            const Expanded(
                flex: 2, child: Icon(Icons.picture_as_pdf, color: Colors.red)),
          ],
        ],
      ),
    );
  }
}

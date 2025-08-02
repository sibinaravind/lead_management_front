import 'package:flutter/material.dart';

import '../../utils/style/colors/colors.dart';

class CustomSwitchTile extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitchTile({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
        Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primaryColor //Colors.blue,
            ),
      ],
    );
  }
}

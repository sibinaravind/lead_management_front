import 'package:flutter/material.dart';

import 'custom_text.dart';

// You may need to import your CustomText widget as well.

class CustomInfoChip extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const CustomInfoChip({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          CustomText(text: text, fontSize: 12, color: color),
        ],
      ),
    );
  }
}

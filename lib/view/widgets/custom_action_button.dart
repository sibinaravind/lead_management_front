import 'package:flutter/material.dart';

class CustomActionButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onPressed;
  final bool isFilled;
  final Gradient? gradient;
  final Color? textColor;
  final Color? borderColor;
  final Color? backgroundColor;

  const CustomActionButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isFilled = false,
    this.backgroundColor,
    this.gradient,
    this.textColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final buttonChild = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 18, color: isFilled ? Colors.white : textColor),
          const SizedBox(width: 8),
        ],
        Flexible(
          child: Text(
            overflow: TextOverflow.ellipsis,
            text,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: isFilled ? Colors.white : textColor ?? Colors.black,
            ),
          ),
        ),
      ],
    );

    return isFilled
        ? Container(
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color:
                      (gradient?.colors.first ?? Colors.black).withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: buttonChild,
            ),
          )
        : OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              side: BorderSide(
                color: borderColor ?? Colors.grey.shade300,
                width: 1.5,
              ),
            ),
            child: buttonChild,
          );
  }
}

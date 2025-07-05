import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color borderColor;
  final double? width;
  final double? height;
  final void Function()? onTap;

  const CustomOutlinedButton({
    super.key,
    required this.text,
    this.onTap,
    this.width = double.infinity,
    this.height = 36,
    this.fontSize = 13,
    this.borderColor = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: borderColor,
          side: BorderSide(color: borderColor),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: borderColor,
            fontFamily: 'Noto Sans',
            fontSize: fontSize,
            fontWeight: FontWeight.normal,
            height: 1,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final bool maxline;
  final int? maxLines;
  final TextAlign textAlign;
  final TextDecoration decoration;
  final TextOverflow? overflow;
  final FontStyle fontStyle;
  const CustomText(
      {super.key,
      required this.text,
      this.color = Colors.black,
      this.fontWeight = FontWeight.w400,
      this.fontSize = 13,
      this.maxline = false,
      this.textAlign = TextAlign.start,
      this.decoration = TextDecoration.none,
      this.overflow = TextOverflow.ellipsis,
      this.fontStyle = FontStyle.normal,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: maxline ? TextOverflow.ellipsis : null,
      maxLines: maxLines,
      style: TextStyle(
        fontStyle: fontStyle,
        overflow: overflow,
        fontFamily: 'Noto Sans',
        color: color,
        fontSize: fontSize,
        decoration: decoration,
        fontWeight: fontWeight,
      ),
    );
  }
}

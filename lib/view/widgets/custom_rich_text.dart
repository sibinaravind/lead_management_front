import 'package:flutter/material.dart';

import '../../utils/style/colors/colors.dart';

class CustomRichText extends StatelessWidget {
  final List<RichTextSection> sections;
  final TextAlign textAlign;

  const CustomRichText({
    super.key,
    required this.sections,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign,
      text: TextSpan(
        children: sections.map((section) {
          return TextSpan(
            text: section.text,
            style: TextStyle(
              color: section.color ?? AppColors.textColor,
              fontWeight: section.fontWeight ?? FontWeight.w400,
              fontSize: section.fontSize ?? 13,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class RichTextSection {
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;

  RichTextSection({
    required this.text,
    this.color,
    this.fontWeight,
    this.fontSize,
  });
}

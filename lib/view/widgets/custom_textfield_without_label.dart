import 'package:flutter/material.dart';

import '../../../res/style/colors/colors.dart';

class CustomTextfieldWithoutLabel extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final bool isRequired;
  const CustomTextfieldWithoutLabel(
      {super.key,
      required this.hint,
      required this.controller,
      required this.isRequired});

  @override
  State<CustomTextfieldWithoutLabel> createState() =>
      _CustomTextfieldWithoutLabelState();
}

class _CustomTextfieldWithoutLabelState
    extends State<CustomTextfieldWithoutLabel> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: AppColors.textColor,
      ),
      decoration: InputDecoration(
        hintText: widget.hint,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
        ),
      ),
      validator: widget.isRequired
          ? (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            }
          : null,
    );
  }
}

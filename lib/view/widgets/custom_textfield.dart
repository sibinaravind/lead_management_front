import 'package:flutter/material.dart';
import '../../utils/style/colors/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool passwordfield;
  final String? Function(String?)? validator;
  final Function()? onPressed;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.passwordfield = false,
    required this.validator,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofillHints: const [AutofillHints.password],
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.black54),
      decoration: InputDecoration(
        suffixIcon: passwordfield
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                ),
                iconSize: 17,
                color: Colors.black45,
                onPressed: onPressed,
              )
            : null,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: -5),
        counterText: '',
        hintText: labelText,
        focusColor: AppColors.primaryColor,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 97, 96, 96)),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        hintStyle: TextStyle(
          color: Colors.grey.withOpacity(0.7),
          fontSize: 14,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../utils/style/colors/colors.dart';
import 'custom_text.dart';

class PopupTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final IconData icon;
  final String hint;
  final bool requiredField;
  final String? Function(String?)? customValidator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int? maxLines;
  final int? minLines;

  const PopupTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.icon,
    required this.hint,
    this.requiredField = false,
    this.customValidator,
    this.keyboardType,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomText(
              text: label,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            if (requiredField)
              const Padding(
                padding: EdgeInsets.only(left: 4),
                child: Text(
                  '*',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          maxLines: maxLines,
          minLines: minLines,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(
              icon,
              color: AppColors.primaryColor,
              size: 20,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.primaryColor,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            filled: true,
            fillColor: Colors.grey[50],
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
          validator: (value) {
            // First check custom validator if provided
            if (customValidator != null) {
              final customError = customValidator!(value);
              if (customError != null) return customError;
            }

            // Then check required field
            if (requiredField && (value == null || value.trim().isEmpty)) {
              return '$label is required';
            }

            return null;
          },
        ),
      ],
    );
  }
}
// import 'package:flutter/material.dart';
// import '../../utils/style/colors/colors.dart';

// import 'custom_text.dart';

// class PopupTextField extends StatelessWidget {
//   final String label;
//   final TextEditingController controller;
//   final IconData icon;
//   final String hint;
//   final bool requiredField;

//   const PopupTextField(
//       {super.key,
//       required this.label,
//       required this.controller,
//       required this.icon,
//       required this.hint,
//       required this.requiredField});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         CustomText(
//           text: label,
//           fontSize: 14,
//           fontWeight: FontWeight.w600,
//           color: Colors.black87,
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           controller: controller,
//           decoration: InputDecoration(
//             hintText: hint,
//             prefixIcon: Icon(
//               icon,
//               color: AppColors.primaryColor,
//               size: 20,
//             ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(color: Colors.grey[300]!),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(color: Colors.grey[300]!),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: const BorderSide(
//                 color: AppColors.primaryColor,
//                 width: 2,
//               ),
//             ),
//             errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: const BorderSide(color: Colors.red),
//             ),
//             filled: true,
//             fillColor: Colors.grey[50],
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 16,
//               vertical: 14,
//             ),
//           ),
//           validator: (value) {
//             if (requiredField) {
//               if (value == null || value.trim().isEmpty) {
//                 return '$label is required';
//               }
//             }

//             return null;
//           },
//         ),
//       ],
//     );
//   }
// }

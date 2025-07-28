// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/services.dart';

// class CustomPasswordTextFormField extends StatelessWidget {
//   final String label;
//   final TextEditingController controller;
//   final bool isRequired;
//   final bool readOnly;
//   final Function()? onTap;
//   final bool obscureText;
//   final bool isEmail;
//   final bool isdate;
//   final int maxLines;
//   final TextInputType? keyboardType;
//   final DateTime? firstDate;
//   final DateTime? lastDate;
//   final String? hintText;
//   final List<TextInputFormatter>? inputFormatters;
//   final FormFieldValidator<String>validator;

//   const CustomPasswordTextFormField({
//     super.key,
//     required this.label,
//     required this.controller,
//     this.isRequired = false,
//     this.readOnly = false,
//     this.onTap,
//     this.obscureText = false,
//     this.isEmail = false,
//     this.isdate = false,
//     this.keyboardType,
//     this.maxLines = 1,
//     this.firstDate,
//     this.lastDate,
//     this.hintText,
//     this.inputFormatters, required this.validator,
//   });

//   Future<void> _selectDate(BuildContext context) async {
//     final date = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: firstDate ?? DateTime.now(),
//       lastDate: lastDate ?? DateTime(2030),
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: const ColorScheme.light(
//               primary: Colors.deepPurple,
//               onPrimary: Colors.white,
//               surface: Colors.white,
//               onSurface: Colors.black,
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//     if (date != null) {
//       controller.text =
//       "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final defaultFormatters = keyboardType == TextInputType.number
//         ? [FilteringTextInputFormatter.digitsOnly]
//         : null;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         RichText(
//           text: TextSpan(
//             children: [
//               TextSpan(
//                 text: label,
//                 style: const TextStyle(color: Colors.black87),
//               ),
//               if (isRequired)
//                 const TextSpan(
//                   text: ' *',
//                   style: TextStyle(color: Colors.red),
//                 ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           controller: controller,
//           decoration: InputDecoration(
//             hintText: hintText,
//             fillColor: Colors.white,
//             filled: true,
//             border: const OutlineInputBorder(),
//             contentPadding:
//             const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
//             isDense: true,
//           ),
//           keyboardType: keyboardType ?? TextInputType.text,
//           maxLines: maxLines,
//           readOnly: isdate ? true : readOnly,
//           onTap: isdate
//               ? () async {
//             await _selectDate(context);
//           }
//               : onTap,
//           obscureText: obscureText,
//           inputFormatters: inputFormatters ?? defaultFormatters,
//           validator:validator
//         ),
//       ],
//     );
//   }
// }

// class DurationInputFormatter extends TextInputFormatter {
//   final bool allowHours;

//   DurationInputFormatter({this.allowHours = false});

//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue,
//       TextEditingValue newValue,
//       ) {
//     final text = newValue.text;

//     // Allow only digits and colon
//     final filtered = text.replaceAll(RegExp(r'[^0-9:]'), '');

//     // Optionally limit to `hh:mm:ss` or `mm:ss`
//     final parts = filtered.split(':');
//     if (parts.length > (allowHours ? 3 : 2)) {
//       return oldValue; // Prevent too many colons
//     }

//     // Prevent parts from being too long (e.g., mm or ss > 2 digits)
//     for (final part in parts) {
//       if (part.length > 2) return oldValue;
//     }

//     return TextEditingValue(
//       text: filtered,
//       selection: TextSelection.collapsed(offset: filtered.length),
//     );
//   }
// }

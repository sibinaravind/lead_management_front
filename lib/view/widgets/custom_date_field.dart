import 'package:flutter/material.dart';

import '../../utils/style/colors/colors.dart';

class CustomDateField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final void Function(String formattedDate)? onChanged;
  final bool isRequired;
  final DateTime? initialDate;
  final DateTime? endDate;
  final DateTime? focusDate;
  final bool isTimeRequired;
  CustomDateField({
    super.key,
    required this.label,
    required this.controller,
    this.onChanged,
    this.isRequired = false,
    this.isTimeRequired = false,
    this.focusDate,
    this.initialDate,
    this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: label,
              style: const TextStyle(color: Colors.black87),
            ),
            if (isRequired)
              const TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
      const SizedBox(height: 8),
      TextFormField(
        controller: controller,
        readOnly: true,
        decoration: const InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(),
          // contentPadding:
          //     const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          suffixIcon: Icon(Icons.calendar_today),
        ),
        validator: isRequired
            ? (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return null;
              }
            : null,
        onTap: () async {
          final date = await showDatePicker(
            context: context,
            initialDate: controller.text.isNotEmpty
                ? DateTime.tryParse(controller.text
                    .split(' ')
                    .first
                    .split('/')
                    .reversed
                    .join('-'))
                : focusDate ?? initialDate ?? DateTime.now(),
            firstDate: initialDate ?? DateTime(1970),
            lastDate: endDate ?? DateTime(2050),
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  // Change background color here
                  colorScheme: ColorScheme.light(
                    primary: AppColors.primaryColor, // Primary color
                    onPrimary: Colors.white, // Text color on primary
                    surface: Colors.white, // Background color of the popup
                    onSurface: Colors.black, // Text color on surface
                    background: Colors.grey[50]!, // Overall background
                  ),
                  dialogBackgroundColor: Colors.grey[50], // Dialog background
                  dialogTheme: DialogThemeData(
                    backgroundColor: Colors.grey[50], // Dialog background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  // You can also customize the text theme
                  textTheme: Theme.of(context).textTheme.copyWith(
                        bodyLarge: TextStyle(color: Colors.black87),
                        bodyMedium: TextStyle(color: Colors.black87),
                      ),
                ),
                child: child!,
              );
            },
          );
          final time;
          if (isTimeRequired) {
            time = await showTimePicker(
                context: context, initialTime: TimeOfDay.now());
          } else {
            time = "";
          }

          if (date != null) {
            final formattedDate =
                "${date.day}/${date.month.toString().padLeft(2, '0')}/${date.year.toString().padLeft(2, '0')}${isTimeRequired ? " ${time?.format(context)}" : ""}";
            controller.text = formattedDate;
            onChanged?.call(formattedDate);
          }
        },
      ),
    ]);
  }
}

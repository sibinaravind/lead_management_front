import 'package:flutter/material.dart';

class CustomDateField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final void Function(String formattedDate)? onChanged;
  final bool isRequired;
  final bool isTimeRequired;
  const CustomDateField({
    super.key,
    required this.label,
    required this.controller,
    this.onChanged,
    this.isRequired = false,
    this.isTimeRequired = false,
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
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime(2050),
          );
          final time = await showTimePicker(
              context: context, initialTime: TimeOfDay.now());

          if (date != null) {
            final formattedDate =
                "${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')} ${time?.format(context)}";
            controller.text = formattedDate;
            onChanged?.call(formattedDate);
          }
        },
      ),
    ]);
  }
}

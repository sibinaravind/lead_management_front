import 'package:flutter/material.dart';
import 'custom_text.dart';

class PopupDateField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final void Function(String formattedDate)? onChanged;
  final bool isRequired;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? hintText;

  const PopupDateField({
    super.key,
    required this.label,
    required this.controller,
    this.onChanged,
    this.isRequired = false,
    this.firstDate,
    this.lastDate,
    this.hintText,
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
            if (isRequired)
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
          readOnly: true,
          decoration: InputDecoration(
            hintText: hintText ?? 'Select date',
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.deepPurple, width: 2),
            ),
            suffixIcon: const Icon(Icons.calendar_today, size: 20),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 16,
            ),
            isDense: true,
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
              firstDate: firstDate ?? DateTime(1950),
              lastDate: lastDate ?? DateTime(2050),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: Colors.deepPurple,
                      onPrimary: Colors.white,
                      surface: Colors.white,
                      onSurface: Colors.black,
                    ),
                  ),
                  child: child!,
                );
              },
            );

            if (date != null) {
              final formattedDate =
                  "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
              controller.text = formattedDate;
              onChanged?.call(formattedDate);
            }
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../../res/style/colors/colors.dart';
import 'custom_text.dart';

class CustomRadioGroup extends StatelessWidget {
  final String label;
  final List<String> options;
  final String? selectedValue;
  final Function(String?) onChanged;
  final bool isRequired;

  const CustomRadioGroup({
    super.key,
    required this.label,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: selectedValue,
      validator: (value) {
        if (isRequired && (value == null || value.isEmpty)) {
          return 'Please select an option';
        }
        return null;
      },
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style:
                    DefaultTextStyle.of(context).style.copyWith(fontSize: 16),
                children: [
                  TextSpan(text: label),
                  if (isRequired)
                    const TextSpan(
                        text: ' *', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              children: options.map((option) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<String>(
                      value: option,
                      groupValue: field.value,
                      onChanged: (val) {
                        field.didChange(val); // update form field state
                        onChanged(val); // call external onChanged
                      },
                      activeColor: AppColors.primaryColor,
                      visualDensity: VisualDensity.compact,
                    ),
                    CustomText(text: option),
                  ],
                );
              }).toList(),
            ),
            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  field.errorText!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }
}

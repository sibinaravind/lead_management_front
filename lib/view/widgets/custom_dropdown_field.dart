import 'package:flutter/material.dart';
import 'custom_text.dart';

class CustomDropdownField extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final Function(String?) onChanged;
  final bool isRequired;
  final bool isSplit;

  const CustomDropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.isRequired = false,
    this.isSplit = false,
  });

  @override
  Widget build(BuildContext context) {
    // Case-insensitive check for "Choose..."
    bool hasChoose = items.any((item) => item.toLowerCase() == 'choose...');
    bool hasValue = value != null &&
        items.any((item) => item.toLowerCase() == value!.toLowerCase());

    final dropdownItems =
        (hasChoose || hasValue) ? items : ['Choose...'] + items;

    // Match selected value ignoring case
    final selectedValue = dropdownItems.firstWhere(
      (item) => value != null && item.toLowerCase() == value!.toLowerCase(),
      orElse: () => 'Choose...',
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: constraints.maxWidth,
                minWidth: 100,
              ),
              child: DropdownButtonFormField<String>(
                value: selectedValue,
                isExpanded: true,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
                dropdownColor: Colors.white,
                items: dropdownItems.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child:
                        CustomText(text: isSplit ? item.split(',')[0] : item),
                  );
                }).toList(),
                onChanged: onChanged,
                validator: isRequired
                    ? (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.toLowerCase() == 'choose...') {
                          return 'This field is required';
                        }
                        return null;
                      }
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

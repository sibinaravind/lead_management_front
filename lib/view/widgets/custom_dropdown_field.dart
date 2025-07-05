import 'package:flutter/material.dart';
import 'custom_text.dart';

class CustomDropdownField extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final Function(String?) onChanged;
  final bool isRequired;

  const CustomDropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    // Include "Choose..." as the first item if not already present
    final dropdownItems = (items.contains('Choose...') ||
            (value != null && items.contains(value)))
        ? items
        : ['Choose...'] + items;

    final selectedValue = dropdownItems.contains(value) ? value : 'Choose...';

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
                    child: CustomText(text: item),
                  );
                }).toList(),
                onChanged: onChanged,
                validator: isRequired
                    ? (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value == 'Choose...') {
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

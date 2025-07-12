import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'custom_text.dart'; // Assuming you have a reusable CustomText widget

class CustomMultiSelectDropdownField extends StatelessWidget {
  final String label;
  final List<String> selectedItems;
  final List<String> items;
  final Function(List<String>) onChanged;
  final bool isRequired;

  const CustomMultiSelectDropdownField({
    super.key,
    required this.label,
    required this.selectedItems,
    required this.items,
    required this.onChanged,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: label,
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
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
        DropdownSearch<String>.multiSelection(
          items:(filter, infiniteScrollProps) => items,
          selectedItems: selectedItems,
          onChanged: onChanged,
          popupProps: PopupPropsMultiSelection.menu(
            showSearchBox: true,
            showSelectedItems: true,

            // itemBuilder: (context, item) {
            //   return DropdownSearchPopupItemBuilder<String>?(
            //     leading: Checkbox(
            //       value: isSelected,
            //       onChanged: null, // handled internally
            //     ),
            //     title: CustomText(text: item),
            //   );
            // },
          ),
          dropdownBuilder: (context, selectedItems) {
            return Wrap(
              spacing: 6,
              children: selectedItems
                  .map((item) => Chip(label: Text(item)))
                  .toList(),
            );
          },
          // dropdownDecoratorProps: DropDownDecoratorProps(
          //   dropdownSearchDecoration: InputDecoration(
          //     fillColor: Theme.of(context).colorScheme.surface,
          //     filled: true,
          //     border: const OutlineInputBorder(),
          //     contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          //   ),
          // ),
          validator: isRequired
              ? (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            return null;
          }
              : null,
        ),
      ],
    );
  }
}

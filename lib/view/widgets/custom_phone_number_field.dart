import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomPhoneField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? selectedCountry;
  final Function(String?) onCountryChanged;
  final bool isRequired;
  final bool showCountryCode;

  const CustomPhoneField({
    super.key,
    required this.label,
    required this.controller,
    required this.selectedCountry,
    required this.onCountryChanged,
    this.isRequired = false,
    this.showCountryCode = true,
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
        Row(
          children: [
            if (showCountryCode)
              Container(
                width: 80,
                height: 49,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    dropdownColor: Colors.white,
                    value: selectedCountry,
                    padding: const EdgeInsets.symmetric(),
                    items: ['+91', '+1', '+44', '+61', '+971', '']
                        .map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text('$item'),
                      );
                    }).toList(),
                    onChanged: onCountryChanged,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            const SizedBox(width: 8),
            Expanded(
                child: TextFormField(
              controller: controller,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                hintText: 'Phone number',
                hintStyle: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              style: const TextStyle(
                fontSize: 14,
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (isRequired) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }

                  if (!RegExp(r'^\d+$').hasMatch(value)) {
                    return 'Only numbers are allowed';
                  }
                  if (value.length < 10 || value.length > 13) {
                    return 'Phone number must be 10-13 digits';
                  }
                  return null;
                } else {
                  if (value != null && value.isNotEmpty) {
                    if (!RegExp(r'^\d+$').hasMatch(value)) {
                      return 'Only numbers are allowed';
                    }
                    if (value.length < 10 || value.length > 13) {
                      return 'Phone number must be 10-13 digits';
                    }
                  }
                  return null;
                }
              },

              // validator: (value) {
              //   if (isRequired) {
              //     if (isRequired && (value == null || value.isEmpty)) {
              //       return 'This field is required';
              //     }
              //     if (value != null && !RegExp(r'^\d+$').hasMatch(value)) {
              //       return 'Only numbers are allowed';
              //     }
              //     if (value != null &&
              //         (value.length < 10 || value.length > 13)) {
              //       return 'Phone number must be 10-13 digits';
              //     }
              //     return null;
              //   } else {
              //     if (value != null && value.isNotEmpty) {
              //       if (value.length < 10 || value.length > 13) {
              //         return 'Phone number must be 10-13 digits';
              //       }
              //     }
              //   }
              //   return null;
              // },
            )),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool isRequired;
  final bool readOnly;
  final Function()? onTap;
  final bool obscureText;
  final bool isEmail;
  final bool isdate;
  final int maxLines;
  final TextInputType? keyboardType;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final bool showPasswordToggle; // ⬅️ New

  const CustomTextFormField({
    super.key,
    required this.label,
    required this.controller,
    this.isRequired = false,
    this.readOnly = false,
    this.onTap,
    this.obscureText = false,
    this.isEmail = false,
    this.isdate = false,
    this.keyboardType,
    this.maxLines = 1,
    this.firstDate,
    this.lastDate,
    this.hintText,
    this.inputFormatters,
    this.validator,
    this.showPasswordToggle = false, // ⬅️ Default off
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _obscureText; // ⬅️ Controls visibility

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText; // Start with given state
  }

  Future<void> _selectDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: widget.firstDate ?? DateTime.now(),
      lastDate: widget.lastDate ?? DateTime(2030),
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
      widget.controller.text =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultFormatters = widget.keyboardType == TextInputType.number
        ? [FilteringTextInputFormatter.digitsOnly]
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: widget.label,
                style: const TextStyle(color: Colors.black87),
              ),
              if (widget.isRequired)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: widget.hintText,
            fillColor: Colors.white,
            filled: true,
            border: const OutlineInputBorder(),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            isDense: true,
            suffixIcon: widget.showPasswordToggle
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
          ),
          keyboardType: widget.keyboardType ?? TextInputType.text,
          maxLines: widget.maxLines,
          readOnly: widget.isdate ? true : widget.readOnly,
          onTap: widget.isdate
              ? () async {
                  await _selectDate(context);
                }
              : widget.onTap,
          obscureText: _obscureText,
          inputFormatters: widget.inputFormatters ?? defaultFormatters,
          validator: (value) {
            if (widget.isRequired && (value == null || value.trim().isEmpty)) {
              return 'This field is required';
            }

            if (widget.isEmail && value != null && value.trim().isNotEmpty) {
              final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
              if (!emailRegex.hasMatch(value)) {
                return 'Enter a valid email address';
              }
            }

            if (widget.validator != null) {
              return widget.validator!(value);
            }

            return null;
          },
        ),
      ],
    );
  }
}

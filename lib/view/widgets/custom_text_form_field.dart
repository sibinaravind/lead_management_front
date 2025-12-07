import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/style/colors/colors.dart';

class CustomTextFormField extends StatefulWidget {
  final String label;
  final IconData? prefixIcon;
  final String? value; // Changed from controller to value
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
  final DateTime? initialDate;
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final bool showPasswordToggle;
  final void Function(String)? onChanged;
  final TextEditingController? controller; // Optional external controller

  CustomTextFormField({
    super.key,
    required this.label,
    this.value,
    this.controller, // Optional: for external control
    this.isRequired = false,
    this.prefixIcon,
    this.readOnly = false,
    this.onTap,
    this.obscureText = false,
    this.isEmail = false,
    this.isdate = false,
    this.keyboardType,
    this.maxLines = 1,
    this.firstDate,
    this.lastDate,
    this.initialDate,
    this.hintText,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.showPasswordToggle = false,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late TextEditingController _internalController;
  late bool _obscureText;

  // Getter for controller (internal or external)
  TextEditingController get _effectiveController {
    return widget.controller ?? _internalController;
  }

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;

    // Initialize internal controller only if external controller is not provided
    if (widget.controller == null) {
      _internalController = TextEditingController(text: widget.value ?? '');
    }
  }

  @override
  void didUpdateWidget(covariant CustomTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Update internal controller if value changes and we're using internal controller
    if (widget.controller == null && oldWidget.value != widget.value) {
      _internalController.text = widget.value ?? '';
    }

    // Update obscureText if changed
    if (oldWidget.obscureText != widget.obscureText) {
      _obscureText = widget.obscureText;
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: widget.initialDate ?? DateTime.now(),
      firstDate: widget.firstDate ?? DateTime(1900),
      lastDate: widget.lastDate ?? DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (date != null && context.mounted) {
      _effectiveController.text =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      widget.onChanged?.call(_effectiveController.text);
    }
  }

  @override
  void dispose() {
    // Only dispose internal controller, not external one
    if (widget.controller == null) {
      _internalController.dispose();
    }
    super.dispose();
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
          controller: _effectiveController,
          decoration: InputDecoration(
            prefixIcon:
                widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
            hintText: widget.hintText,
            fillColor: Colors.white,
            filled: true,
            border: const OutlineInputBorder(),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            isDense: true,
            suffixIcon: _buildSuffixIcon(),
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
          validator: widget.validator ?? _defaultValidator,
          onChanged: widget.onChanged,
        ),
      ],
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.showPasswordToggle) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: Colors.grey,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    }
    return null;
  }

  String? _defaultValidator(String? value) {
    if (widget.isRequired && (value == null || value.trim().isEmpty)) {
      return 'This field is required';
    }

    if (widget.isEmail && value != null && value.trim().isNotEmpty) {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(value)) {
        return 'Enter a valid email address';
      }
    }

    return null;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/utils/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';
import '../../../../controller/config/config_controller.dart';
import '../../../../core/services/navigation_service.dart';

class AddEditDialog extends StatefulWidget {
  final String category;
  final Map<String, dynamic>? item;
  final Function(Map<String, dynamic>) onSave;
  const AddEditDialog({
    super.key,
    required this.category,
    this.item,
    required this.onSave,
  });
  @override
  State<AddEditDialog> createState() => _AddEditDialogState();
}

class _AddEditDialogState extends State<AddEditDialog> {
  final _formKey = GlobalKey<FormState>();
  final ConfigController controller = Get.find<ConfigController>();
  late Map<String, TextEditingController> _controllers;
  late Map<String, dynamic> _formData;
  late List<String> _fields;
  late List<String> _requiredFields;
  @override
  @override
  void initState() {
    super.initState();
    _fields = controller.getFieldsList(widget.category);
    _requiredFields = controller.getRequiredFields(widget.category);
    _controllers = {};
    _formData = {};
    for (String field in _fields) {
      _controllers[field] = TextEditingController();
      if (widget.item != null && widget.item!.containsKey(field)) {
        var value = widget.item![field];
        _controllers[field]!.text = value?.toString() ?? '';
        _formData[field] = value;
      } else {
        // Set default values
        if (field == 'status') {
          _formData[field] = 'ACTIVE';
          _controllers[field]!.text = 'ACTIVE';
        } else if (field == 'colour') {
          _formData[field] = '0XFFFFFFFF'; // Default white color
          _controllers[field]!.text = '0XFFFFFFFF';
        } else {
          _formData[field] = '';
          _controllers[field]!.text = '';
        }
      }
    }
  }

  @override
  void dispose() {
    for (var c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
          minHeight: 400,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppColors.blackGradient,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Row(
                children: [
                  Icon(
                    widget.item == null ? Icons.add : Icons.edit,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomText(
                        text:
                            '${widget.item == null ? 'Add' : 'Edit'} ${controller.getCategoryDisplayName(widget.category)} Item',
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () => NavigationService.goBack(),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Required fields info panel
                      ..._fields.map((field) => _buildFormField(field)),
                      const SizedBox(height: 24),
                      CustomActionButton(
                        text: 'Done',
                        icon: Icons.check,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            for (String field in _fields) {
                              if (_controllers[field] != null) {
                                if (!['status', 'program', 'category']
                                    .contains(field)) {
                                  _formData[field] = _controllers[field]!.text;
                                }
                              }
                            }
                            if (_controllers['name'] != null &&
                                _formData['name'] != null) {
                              _controllers['name']!.text =
                                  _formData['name'].toString().toUpperCase();
                              _formData['name'] =
                                  _formData['name'].toString().toUpperCase();
                            }
                            _formData['status'] ??= 'ACTIVE';
                            widget.onSave(_formData);
                          }
                        },
                        isFilled: true,
                        gradient: AppColors.blackGradient,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormField(String field) {
    final isRequired = _requiredFields.contains(field);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomText(
                text: _getFieldLabel(field),
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.black87,
              ),
              if (isRequired) ...[
                const SizedBox(width: 4),
                const Text(
                  '*',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),
          if (field == 'status')
            _buildStatusDropdown(isRequired)
          else if (field == 'colour')
            _buildColorField(isRequired)
          else if (field == 'program' && widget.category == 'program')
            _buildProgramTypeDropdown(isRequired)
          else if (field == 'category' && widget.category == 'specialized')
            _buildCategoryDropdown(isRequired)
          else
            _buildTextFormField(field, isRequired),
        ],
      ),
    );
  }

  Widget _buildStatusDropdown(bool isRequired) {
    return DropdownButtonFormField<String>(
      value: (['ACTIVE', 'INACTIVE'].contains(_formData['status']))
          ? _formData['status']
          : null,
      decoration: _inputDecoration('Select status', isRequired),
      validator: isRequired
          ? (value) {
              if (value == null || value.isEmpty) {
                return 'Status is required';
              }
              return null;
            }
          : null,
      items: ['ACTIVE', 'INACTIVE'].map((status) {
        return DropdownMenuItem(
          value: status,
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: status == 'ACTIVE' ? Colors.green : Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(status),
            ],
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _formData['status'] = value;
          // Update the controller as well
          if (_controllers['status'] != null) {
            _controllers['status']!.text = value ?? '';
          }
        });
      },
    );
  }

  /// Fixed Color Field
  Widget _buildColorField(bool isRequired) {
    return Column(
      children: [
        // Color picker
        Container(
          height: 200,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade300, // Remove red border
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ColorPicker(
            pickerColor:
                _parseColor(_formData['colour']?.toString() ?? '0XFFFFFFFF'),
            onColorChanged: (color) {
              setState(() {
                String hexColor =
                    "0X${color.value.toRadixString(16).toUpperCase().padLeft(8, '0')}";
                _controllers['colour']!.text = hexColor;
                _formData['colour'] = hexColor;
              });
            },
            displayThumbColor: true,
            showLabel: false,
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        const SizedBox(height: 8),
        // Color code display
        TextFormField(
          controller: _controllers['colour'],
          decoration: _inputDecoration('Color code (0XFFFFFFFF)', isRequired),
          validator: isRequired
              ? (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Color is required';
                  }
                  if (!RegExp(r'^0[xX][0-9A-Fa-f]{8}$').hasMatch(value)) {
                    return 'Please enter a valid color format (0XFFFFFFFF)';
                  }
                  return null;
                }
              : (value) {
                  if (value != null && value.isNotEmpty) {
                    if (!RegExp(r'^0[xX][0-9A-Fa-f]{8}$').hasMatch(value)) {
                      return 'Please enter a valid color format (0XFFFFFFFF)';
                    }
                  }
                  return null;
                },
          onChanged: (value) {
            _formData['colour'] = value;

            try {
              if (RegExp(r'^0[xX][0-9A-Fa-f]{8}$').hasMatch(value)) {
                setState(() {});
              }
            } catch (e) {}
          },
          readOnly: false,
        ),
      ],
    );
  }

  Widget _buildProgramTypeDropdown(bool isRequired) {
    final programTypes = controller.configData.value.courseType
            ?.where((e) => e.name != null && e.name!.trim().isNotEmpty)
            .map((e) => e.name!)
            .toList() ??
        [];

    return DropdownButtonFormField<String>(
      value: (programTypes.contains(_formData['program']))
          ? _formData['program']
          : null,
      decoration: _inputDecoration('Select program type', isRequired),
      validator: isRequired
          ? (value) {
              if (value == null || value.isEmpty) {
                return 'Program type is required';
              }
              return null;
            }
          : null,
      items: programTypes.map((program) {
        return DropdownMenuItem(
          value: program,
          child: Text(program),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _formData['program'] = value;
          _controllers['program']?.text = value ?? '';
        });
      },
    );
  }

  Widget _buildCategoryDropdown(bool isRequired) {
    final categories = controller.configData.value.jobCategory
            ?.where((e) => e.name != null && e.name!.trim().isNotEmpty)
            .map((e) => e.name!)
            .toList() ??
        [];

    return DropdownButtonFormField<String>(
      value: (categories.contains(_formData['category']))
          ? _formData['category']
          : null,
      decoration: _inputDecoration('Select category', isRequired),
      validator: isRequired
          ? (value) {
              if (value == null || value.isEmpty) {
                return 'Category is required';
              }
              return null;
            }
          : null,
      items: categories.map((category) {
        return DropdownMenuItem(
          value: category,
          child: Text(category),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _formData['category'] = value;
          _controllers['category']?.text = value ?? '';
        });
      },
    );
  }

  Widget _buildTextFormField(String field, bool isRequired) {
    return TextFormField(
      controller: _controllers[field],
      decoration: _inputDecoration(
        'Enter ${_getFieldLabel(field).toLowerCase()}${isRequired ? ' (required)' : ''}',
        isRequired,
      ),
      validator: (value) {
        if (isRequired && (value == null || value.trim().isEmpty)) {
          return '${_getFieldLabel(field)} is required';
        }

        // Additional field-specific validations
        if (field == 'phone' && value != null && value.isNotEmpty) {
          if (!RegExp(r'^[\+]?[0-9\s\-\(\)]{10,15}$').hasMatch(value)) {
            return 'Please enter a valid phone number';
          }
        }

        return null;
      },
      onChanged: (value) {
        _formData[field] = value;
      },
      maxLines: field == 'address' ? 3 : 1,
      keyboardType: field == 'phone' ? TextInputType.phone : TextInputType.text,
    );
  }

  InputDecoration _inputDecoration(String hint, [bool isRequired = false]) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.blue.shade700),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.red.shade400),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.red.shade400),
      ),
      filled: true,
      fillColor: Colors.grey.shade50,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }

  Color _parseColor(String colorString) {
    try {
      if (colorString.startsWith('0X') || colorString.startsWith('0x')) {
        return Color(int.parse(colorString.substring(2), radix: 16));
      }
      return const Color(0xFFFFFFFF);
    } catch (e) {
      return const Color(0xFFFFFFFF);
    }
  }

  String _getFieldLabel(String field) {
    switch (field) {
      case 'name':
        return 'Name';
      case 'code':
        return 'Code';
      case 'country':
        return 'Country';
      case 'province':
        return 'Province';
      case 'status':
        return 'Status';
      case 'colour':
        return 'Color';
      case 'address':
        return 'Address';
      case 'phone':
        return 'Phone';
      default:
        return field.replaceAll('_', ' ').toUpperCase();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/config/config_controller.dart';

class AddEditDialog extends StatefulWidget {
  final String category;
  final Map<String, dynamic>? item;
  final Function(Map<String, dynamic>) onSave;

  const AddEditDialog({
    Key? key,
    required this.category,
    this.item,
    required this.onSave,
  }) : super(key: key);

  @override
  State<AddEditDialog> createState() => _AddEditDialogState();
}

class _AddEditDialogState extends State<AddEditDialog> {
  final _formKey = GlobalKey<FormState>();
  final ConfigController controller = Get.find<ConfigController>();

  late Map<String, TextEditingController> _controllers;
  late Map<String, dynamic> _formData;
  late List<String> _fields;

  @override
  void initState() {
    super.initState();
    _fields = controller.getFieldsForCategory(widget.category);
    _controllers = {};
    _formData = {};

    for (String field in _fields) {
      _controllers[field] = TextEditingController();
      if (widget.item != null && widget.item!.containsKey(field)) {
        _controllers[field]!.text = widget.item![field]?.toString() ?? '';
        _formData[field] = widget.item![field];
      } else {
        _formData[field] = field == 'status' ? 'ACTIVE' : '';
      }
    }
  }

  @override
  void dispose() {
    _controllers.values.forEach((c) => c.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ..._fields.map((field) => _buildFormField(field)),
                      const SizedBox(height: 24),
                      _buildActionButtons(),
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

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.shade700,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        children: [
          Icon(
            widget.item == null ? Icons.add : Icons.edit,
            color: Colors.white,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '${widget.item == null ? 'Add' : 'Edit'} ${controller.getCategoryDisplayName(widget.category)} Item',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.close, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField(String field) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_getFieldLabel(field),
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.black87)),
          const SizedBox(height: 8),
          if (field == 'status')
            _buildStatusDropdown()
          else if (field == 'colour')
            _buildColorField()
          else if (field == 'program' && widget.category == 'program')
            _buildProgramTypeDropdown()
          else if (field == 'category' && widget.category == 'specialized')
            _buildCategoryDropdown()
          else
            _buildTextFormField(field),
        ],
      ),
    );
  }

  Widget _buildTextFormField(String field) {
    return TextFormField(
      controller: _controllers[field],
      decoration:
          _inputDecoration('Enter ${_getFieldLabel(field).toLowerCase()}'),
      validator: (value) {
        if (field == 'name' && (value == null || value.trim().isEmpty)) {
          return 'This field is required';
        }
        return null;
      },
      onChanged: (value) {
        _formData[field] = value;
      },
      maxLines: field == 'address' ? 3 : 1,
    );
  }

  Widget _buildStatusDropdown() {
    return DropdownButtonFormField<String>(
      value: _formData['status'] ?? 'ACTIVE',
      decoration: _inputDecoration('Select status'),
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
        });
      },
    );
  }

  Widget _buildColorField() {
    return TextFormField(
      controller: _controllers['colour'],
      decoration:
          _inputDecoration('Enter color code (e.g., 0XFFFF5C5C)').copyWith(
        suffixIcon: _controllers['colour']!.text.isNotEmpty
            ? Container(
                margin: const EdgeInsets.all(8),
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: _parseColor(_controllers['colour']!.text),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.grey.shade400),
                ),
              )
            : null,
      ),
      onChanged: (value) {
        setState(() {
          _formData['colour'] = value;
        });
      },
    );
  }

  Widget _buildProgramTypeDropdown() {
    final programTypes = [
      'PG',
      'UG',
      'DIPLOMA',
      'PRE MASTERS',
      'MASTERS BY TAUGHT',
      'MASTERS BY RESEARCH',
      'FOUNDATION',
      '10TH',
      'PHD',
    ];

    return DropdownButtonFormField<String>(
      value:
          _formData['program']?.isEmpty == true ? null : _formData['program'],
      decoration: _inputDecoration('Select program type'),
      items: programTypes.map((program) {
        return DropdownMenuItem(
          value: program,
          child: Text(program),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _formData['program'] = value;
        });
      },
    );
  }

  Widget _buildCategoryDropdown() {
    final categories = ['DOCTOR', 'NURSE'];

    return DropdownButtonFormField<String>(
      value:
          _formData['category']?.isEmpty == true ? null : _formData['category'],
      decoration: _inputDecoration('Select category'),
      items: categories.map((category) {
        return DropdownMenuItem(
          value: category,
          child: Text(category),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _formData['category'] = value;
        });
      },
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Get.back(),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Cancel'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: _saveItem,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(widget.item == null ? 'Add Item' : 'Update Item'),
          ),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration(String hint) {
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
      filled: true,
      fillColor: Colors.grey.shade50,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }

  String _getFieldLabel(String field) {
    switch (field) {
      case 'name':
        return 'Name';
      case 'status':
        return 'Status';
      case 'colour':
        return 'Color';
      case 'program':
        return 'Program Type';
      case 'address':
        return 'Address';
      case 'phone':
        return 'Phone';
      case 'category':
        return 'Category';
      default:
        return field.replaceAll('_', ' ').toUpperCase();
    }
  }

  Color _parseColor(String colorString) {
    try {
      if (colorString.startsWith('0X') || colorString.startsWith('0x')) {
        return Color(int.parse(colorString.substring(2), radix: 16));
      }
      return Colors.grey;
    } catch (_) {
      return Colors.grey;
    }
  }

  void _saveItem() {
    if (_formKey.currentState!.validate()) {
      for (String field in _fields) {
        if (_controllers[field] != null) {
          _formData[field] = _controllers[field]!.text;
        }
      }
      _formData['status'] ??= 'ACTIVE';
      widget.onSave(_formData);
      Get.back();
    }
  }
}

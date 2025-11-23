// add_edit_project.dart (Updated)
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/controller/config/config_controller.dart';
import 'package:overseas_front_end/controller/project/project_controller.dart';
import '../../../../model/project/project_model.dart';
import '../../../widgets/widgets.dart';

// project_model.dart
class ProductModel {
  String? sId;
  String projectName;
  String organizationType;
  String organizationCategory;
  String city;
  String country;
  String status;
  List<Product>? products;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProductModel({
    this.sId,
    required this.projectName,
    required this.organizationType,
    required this.organizationCategory,
    required this.city,
    required this.country,
    required this.status,
    this.products,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      sId: json['_id'],
      projectName: json['projectName'] ?? '',
      organizationType: json['organizationType'] ?? '',
      organizationCategory: json['organizationCategory'] ?? '',
      city: json['city'] ?? '',
      country: json['country'] ?? '',
      status: json['status'] ?? 'ACTIVE',
      products: json['products'] != null
          ? (json['products'] as List).map((i) => Product.fromJson(i)).toList()
          : [],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (sId != null) '_id': sId,
      'projectName': projectName,
      'organizationType': organizationType,
      'organizationCategory': organizationCategory,
      'city': city,
      'country': country,
      'status': status,
      'products': products?.map((product) => product.toJson()).toList(),
      if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
    };
  }

  ProductModel copyWith({
    String? sId,
    String? projectName,
    String? organizationType,
    String? organizationCategory,
    String? city,
    String? country,
    String? status,
    List<Product>? products,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductModel(
      sId: sId ?? this.sId,
      projectName: projectName ?? this.projectName,
      organizationType: organizationType ?? this.organizationType,
      organizationCategory: organizationCategory ?? this.organizationCategory,
      city: city ?? this.city,
      country: country ?? this.country,
      status: status ?? this.status,
      products: products ?? this.products,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class Product {
  String? id;
  String name;
  String description;
  double totalAmount;
  List<AmountBreakdown> breakdown;
  DateTime? deadline;
  int? targetCount;
  DateTime createdAt;

  Product({
    this.id,
    required this.name,
    required this.description,
    required this.totalAmount,
    required this.breakdown,
    this.deadline,
    this.targetCount,
    required this.createdAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? json['_id'],
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0.0,
      breakdown: json['breakdown'] != null
          ? (json['breakdown'] as List)
              .map((i) => AmountBreakdown.fromJson(i))
              .toList()
          : [],
      deadline:
          json['deadline'] != null ? DateTime.parse(json['deadline']) : null,
      targetCount: json['targetCount'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'description': description,
      'totalAmount': totalAmount,
      'breakdown': breakdown.map((item) => item.toJson()).toList(),
      'deadline': deadline?.toIso8601String(),
      'targetCount': targetCount,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? totalAmount,
    List<AmountBreakdown>? breakdown,
    DateTime? deadline,
    int? targetCount,
    DateTime? createdAt,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      totalAmount: totalAmount ?? this.totalAmount,
      breakdown: breakdown ?? this.breakdown,
      deadline: deadline ?? this.deadline,
      targetCount: targetCount ?? this.targetCount,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class AmountBreakdown {
  String description;
  double amount;

  AmountBreakdown({
    required this.description,
    required this.amount,
  });

  factory AmountBreakdown.fromJson(Map<String, dynamic> json) {
    return AmountBreakdown(
      description: json['description'] ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'amount': amount,
    };
  }
}

class ProductFormWidget extends StatefulWidget {
  final Product? product;
  final Function(Product) onSave;
  final Function() onCancel;

  const ProductFormWidget({
    super.key,
    this.product,
    required this.onSave,
    required this.onCancel,
  });

  @override
  State<ProductFormWidget> createState() => _ProductFormWidgetState();
}

class _ProductFormWidgetState extends State<ProductFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _targetCountController = TextEditingController();

  DateTime? _selectedDeadline;
  bool _hasDeadline = false;

  List<AmountBreakdown> _breakdownItems = [];
  final _breakdownDescController = TextEditingController();
  final _breakdownAmountController = TextEditingController();

  @override
  void initState() {
    if (widget.product != null) {
      _nameController.text = widget.product!.name;
      _descriptionController.text = widget.product!.description;
      _selectedDeadline = widget.product!.deadline;
      _hasDeadline = widget.product!.deadline != null;
      _breakdownItems = List.from(widget.product!.breakdown);
      if (widget.product!.targetCount != null) {
        _targetCountController.text = widget.product!.targetCount.toString();
      }
    }
    super.initState();
  }

  double get _totalAmount {
    return _breakdownItems.fold(0.0, (sum, item) => sum + item.amount);
  }

  void _addBreakdownItem() {
    final description = _breakdownDescController.text.trim();
    final amount = double.tryParse(_breakdownAmountController.text) ?? 0.0;

    if (description.isNotEmpty && amount > 0) {
      setState(() {
        _breakdownItems.add(AmountBreakdown(
          description: description,
          amount: amount,
        ));
      });
      _breakdownDescController.clear();
      _breakdownAmountController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter valid description and amount'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _removeBreakdownItem(int index) {
    setState(() {
      _breakdownItems.removeAt(index);
    });
  }

  void _saveProduct() {
    if (_formKey.currentState!.validate()) {
      if (_breakdownItems.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please add at least one amount breakdown item'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final product = Product(
        id: widget.product?.id,
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        totalAmount: _totalAmount,
        breakdown: _breakdownItems,
        deadline: _hasDeadline ? _selectedDeadline : null,
        targetCount: _targetCountController.text.isNotEmpty
            ? int.tryParse(_targetCountController.text)
            : null,
        createdAt: widget.product?.createdAt ?? DateTime.now(),
      );
      widget.onSave(product);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 600,
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.inventory_2_rounded, color: Colors.purple),
                  const SizedBox(width: 8),
                  Text(
                    widget.product == null ? 'Add Product' : 'Edit Product',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Product Basic Info
                      CustomTextFormField(
                        label: 'Product Name *',
                        controller: _nameController,
                        isRequired: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter product name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      CustomTextFormField(
                        label: 'Description *',
                        controller: _descriptionController,
                        isRequired: true,
                        maxLines: 3,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter product description';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Deadline Section
                      Row(
                        children: [
                          Checkbox(
                            value: _hasDeadline,
                            onChanged: (value) {
                              setState(() {
                                _hasDeadline = value ?? false;
                                if (!_hasDeadline) {
                                  _selectedDeadline = null;
                                }
                              });
                            },
                          ),
                          const Text('Set Deadline'),
                          const SizedBox(width: 16),
                          if (_hasDeadline) ...[
                            Expanded(
                              child: InkWell(
                                onTap: () async {
                                  final selectedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now()
                                        .add(const Duration(days: 30)),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2100),
                                  );
                                  if (selectedDate != null) {
                                    setState(() {
                                      _selectedDeadline = selectedDate;
                                    });
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.calendar_today,
                                          size: 16),
                                      const SizedBox(width: 8),
                                      Text(
                                        _selectedDeadline != null
                                            ? '${_selectedDeadline!.day}/${_selectedDeadline!.month}/${_selectedDeadline!.year}'
                                            : 'Select Deadline',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Target Count
                      CustomTextFormField(
                        label: 'Target Count (Optional)',
                        controller: _targetCountController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            final count = int.tryParse(value);
                            if (count == null || count <= 0) {
                              return 'Please enter a valid target count';
                            }
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),

                      // Amount Breakdown Section
                      const Row(
                        children: [
                          Icon(Icons.attach_money_rounded, size: 18),
                          SizedBox(width: 8),
                          Text(
                            'Amount Breakdown *',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Add Breakdown Item
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _breakdownDescController,
                                    decoration: const InputDecoration(
                                      labelText: 'Item Description',
                                      border: OutlineInputBorder(),
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 12),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: TextFormField(
                                    controller: _breakdownAmountController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: 'Amount',
                                      border: OutlineInputBorder(),
                                      prefixText: '\$ ',
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 12),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                IconButton(
                                  icon: const Icon(Icons.add_circle,
                                      color: Colors.green, size: 32),
                                  onPressed: _addBreakdownItem,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Click + to add breakdown item',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Breakdown List
                      if (_breakdownItems.isNotEmpty) ...[
                        const Text(
                          'Breakdown Items:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        ..._breakdownItems.asMap().entries.map((entry) {
                          final index = entry.key;
                          final item = entry.value;
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.purple.shade50,
                                child: Text(
                                  '\$${item.amount.toStringAsFixed(0)}',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                              title: Text(item.description),
                              subtitle:
                                  Text('\$${item.amount.toStringAsFixed(2)}'),
                              trailing: IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _removeBreakdownItem(index),
                              ),
                            ),
                          );
                        }),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.green.shade200),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total Amount:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '\$${_totalAmount.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ],
                  ),
                ),
              ),

              // Buttons
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: widget.onCancel,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _saveProduct,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        'Save Product',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom Text Form Field for Product Form
class CustomTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isRequired;
  final int maxLines;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    required this.label,
    required this.controller,
    this.isRequired = false,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
      validator: validator ??
          (value) {
            if (isRequired && (value == null || value.isEmpty)) {
              return 'This field is required';
            }
            return null;
          },
    );
  }
}

class AddEditProject extends StatefulWidget {
  final ProductModel? project;
  final bool isEditMode;
  const AddEditProject({super.key, required this.isEditMode, this.project});

  @override
  State<AddEditProject> createState() => _AddEditProjectState();
}

class _AddEditProjectState extends State<AddEditProject> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedOrganizationType;
  String? _selectedOrganizationCategory;
  String? _selectedCountry;
  String? _selectedStatus;

  List<String> selectedRemarks = [];
  final _locationController = TextEditingController();
  final _projectNameController = TextEditingController();
  final projectController = Get.find<ProjectController>();

  List<Product> _products = [];

  @override
  void initState() {
    _selectedOrganizationType = widget.project?.organizationType ?? '';
    _selectedOrganizationCategory = widget.project?.organizationCategory ?? '';
    _selectedCountry = widget.project?.country ?? '';
    _locationController.text = widget.project?.city ?? '';
    _projectNameController.text = widget.project?.projectName ?? '';
    _selectedStatus = widget.project?.status ?? '';
    _products = widget.project?.products?.toList() ?? [];
    super.initState();
  }

  void _addProduct() {
    showDialog(
      context: context,
      builder: (context) => ProductFormWidget(
        onSave: (product) {
          setState(() {
            _products.add(product);
          });
          Navigator.pop(context);
        },
        onCancel: () => Navigator.pop(context),
      ),
    );
  }

  void _editProduct(int index) {
    showDialog(
      context: context,
      builder: (context) => ProductFormWidget(
        product: _products[index],
        onSave: (updatedProduct) {
          setState(() {
            _products[index] = updatedProduct;
          });
          Navigator.pop(context);
        },
        onCancel: () => Navigator.pop(context),
      ),
    );
  }

  void _removeProduct(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Product'),
        content: const Text('Are you sure you want to remove this product?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _products.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: const Text('Remove', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  double get _totalProjectValue {
    return _products.fold(0.0, (sum, product) => sum + product.totalAmount);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(8),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            double dialogWidth = maxWidth;
            if (maxWidth > 1400) {
              dialogWidth = maxWidth * 0.85;
            } else if (maxWidth > 1000) {
              dialogWidth = maxWidth * 0.95;
            } else if (maxWidth > 600) {
              dialogWidth = maxWidth * 0.98;
            }

            return Padding(
              padding:
                  const EdgeInsets.only(left: 12, right: 0, top: 2, bottom: 5),
              child: Form(
                key: _formKey,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(24),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final availableWidth = constraints.maxWidth;
                              int columnsCount = availableWidth > 500 ? 2 : 1;

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Project Basic Information
                                  const SectionTitle(
                                    title: 'Project Information',
                                    icon: Icons.info_outline_rounded,
                                  ),
                                  const SizedBox(height: 16),
                                  ResponsiveGrid(
                                    columns: columnsCount,
                                    children: [
                                      CustomTextFormField(
                                        label: 'Project Name',
                                        controller: _projectNameController,
                                        // isdate: false,
                                        // readOnly: false,
                                        isRequired: true,
                                      ),
                                      CustomDropdownField(
                                        label: 'Organization Type',
                                        value: _selectedOrganizationType,
                                        items: const [
                                          'GOV',
                                          'PRIVATE',
                                        ],
                                        onChanged: (val) => setState(() =>
                                            _selectedOrganizationType = val),
                                        isRequired: true,
                                      ),
                                      CustomDropdownField(
                                        label: 'Organization Category',
                                        value: _selectedOrganizationCategory,
                                        items: const [
                                          'HOSPITAL',
                                          'CONSTRUCTION',
                                          'LOGISTICS'
                                        ],
                                        onChanged: (val) => setState(() =>
                                            _selectedOrganizationCategory =
                                                val),
                                        isRequired: true,
                                      ),
                                      if (widget.isEditMode)
                                        CustomDropdownField(
                                          label: 'Status',
                                          value: _selectedStatus,
                                          items: ['ACTIVE', 'INACTIVE'],
                                          onChanged: (val) => setState(
                                              () => _selectedStatus = val),
                                          isRequired: true,
                                        ),
                                      CustomDropdownField(
                                        items: (Get.find<ConfigController>()
                                                    .configData
                                                    .value
                                                    .country ??
                                                [])
                                            .map((country) => country.name)
                                            .whereType<String>()
                                            .toList(),
                                        label: 'Country',
                                        isRequired: true,
                                        value: _selectedCountry,
                                        onChanged: (value) {
                                          _selectedCountry = value ?? '';
                                        },
                                      ),
                                      CustomTextFormField(
                                        label: 'City',
                                        controller: _locationController,
                                        // isdate: false,
                                        // readOnly: false,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 32),

                                  // Products Section
                                  const SectionTitle(
                                    title: 'Products',
                                    icon: Icons.inventory_2_rounded,
                                  ),
                                  const SizedBox(height: 16),

                                  // Total Project Value
                                  if (_products.isNotEmpty)
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(16),
                                      margin: const EdgeInsets.only(bottom: 16),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.shade50,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: Colors.blue.shade200),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Total Project Value:',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                            ),
                                          ),
                                          Text(
                                            '\$${_totalProjectValue.toStringAsFixed(2)}',
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                  // Add Product Button
                                  Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.only(bottom: 16),
                                    child: CustomActionButton(
                                      text: 'Add Product',
                                      icon: Icons.add,
                                      isFilled: true,
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF7F00FF),
                                          Color(0xFFE100FF)
                                        ],
                                      ),
                                      onPressed: _addProduct,
                                    ),
                                  ),

                                  // Products List
                                  if (_products.isNotEmpty) ...[
                                    ..._products.asMap().entries.map((entry) {
                                      final index = entry.key;
                                      final product = entry.value;
                                      return ProductCard(
                                        product: product,
                                        onEdit: () => _editProduct(index),
                                        onDelete: () => _removeProduct(index),
                                      );
                                    }),
                                    const SizedBox(height: 16),
                                  ],

                                  const SizedBox(height: 32),

                                  // Action Buttons
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: CustomActionButton(
                                            text: 'Cancel',
                                            icon: Icons.close_rounded,
                                            textColor: Colors.grey,
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            borderColor: Colors.grey.shade300,
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          flex: 2,
                                          child: CustomActionButton(
                                            text: widget.isEditMode
                                                ? 'Update Project'
                                                : 'Create Project',
                                            icon: Icons.save_rounded,
                                            isFilled: true,
                                            gradient: const LinearGradient(
                                              colors: [
                                                Color(0xFF7F00FF),
                                                Color(0xFFE100FF)
                                              ],
                                            ),
                                            onPressed: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                final project = ProductModel(
                                                  sId: widget.project?.sId,
                                                  status: _selectedStatus ??
                                                      'ACTIVE',
                                                  projectName:
                                                      _projectNameController
                                                          .text
                                                          .trim(),
                                                  organizationType:
                                                      _selectedOrganizationType ??
                                                          '',
                                                  organizationCategory:
                                                      _selectedOrganizationCategory ??
                                                          '',
                                                  city: _locationController.text
                                                      .trim(),
                                                  country: _selectedCountry
                                                          ?.trim() ??
                                                      '',
                                                  products: _products,
                                                );

                                                // if (widget.isEditMode) {
                                                //   showLoaderDialog(context);
                                                //   await projectController
                                                //       .editProject(
                                                //     project: project,
                                                //     context: context,
                                                //     projectId:
                                                //         widget.project?.sId ??
                                                //             '',
                                                //   );
                                                //   Navigator.pop(context);
                                                // } else {
                                                //   showLoaderDialog(context);
                                                //   await projectController
                                                //       .createProject(
                                                //     context: context,
                                                //     project: project,
                                                //   );
                                                //   Navigator.pop(context);
                                                // }
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Product Card Widget
class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProductCard({
    super.key,
    required this.product,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: onEdit,
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: onDelete,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              product.description,
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: [
                _buildInfoItem('Total Amount',
                    '\$${product.totalAmount.toStringAsFixed(2)}'),
                if (product.targetCount != null)
                  _buildInfoItem(
                      'Target Count', product.targetCount.toString()),
                if (product.deadline != null)
                  _buildInfoItem('Deadline',
                      '${product.deadline!.day}/${product.deadline!.month}/${product.deadline!.year}'),
                _buildInfoItem(
                    'Breakdown Items', product.breakdown.length.toString()),
              ],
            ),
            const SizedBox(height: 12),
            if (product.breakdown.isNotEmpty) ...[
              const Text(
                'Amount Breakdown:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...product.breakdown.map((item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        Expanded(child: Text(item.description)),
                        Text('\$${item.amount.toStringAsFixed(2)}'),
                      ],
                    ),
                  )),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        '$label: $value',
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}

// Helper function to show loader dialog
void showLoaderDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    },
  );
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:overseas_front_end/controller/config/config_controller.dart';
// import 'package:overseas_front_end/controller/project/project_controller.dart';
// import '../../../../model/project/project_model.dart';
// import '../../../widgets/widgets.dart';

// class AddEditProject extends StatefulWidget {
//   final ProductModel? project;

//   final bool isEditMode;
//   const AddEditProject({super.key, required this.isEditMode, this.project});

//   @override
//   State<AddEditProject> createState() => _AddEditProjectState();
// }

// class _AddEditProjectState extends State<AddEditProject> {
//   final _formKey = GlobalKey<FormState>();

//   String? _selectedOrganizationType;
//   String? _selectedOrganizationCategory;
//   String? _selectedCountry;
//   String? _selectedStatus;

//   List<String> selectedRemarks = [];
//   final _locationController = TextEditingController();
//   final _projectNameController = TextEditingController();
//   final projectController = Get.find<ProjectController>();

//   @override
//   void initState() {
//     _selectedOrganizationType = widget.project?.organizationType ?? '';
//     _selectedOrganizationCategory = widget.project?.organizationCategory ?? '';
//     _selectedCountry = widget.project?.country ?? '';
//     _locationController.text = widget.project?.city ?? '';
//     _projectNameController.text = widget.project?.projectName ?? '';
//     _selectedStatus = widget.project?.status ?? '';
//     // _selectedStatus=widget.project?.status??'';
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       insetPadding: const EdgeInsets.all(8),
//       child: ConstrainedBox(
//         constraints: BoxConstraints(maxWidth: 1000),
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             final maxWidth = constraints.maxWidth;
//             // final maxHeight = constraints.maxHeight;
//             double dialogWidth = maxWidth;
//             if (maxWidth > 1400) {
//               dialogWidth = maxWidth * 0.72;
//             } else if (maxWidth > 1000) {
//               dialogWidth = maxWidth * 0.9;
//             } else if (maxWidth > 600) {
//               dialogWidth = maxWidth * 0.95;
//             }

//             return Padding(
//                 padding: const EdgeInsets.only(
//                     left: 12, right: 0, top: 2, bottom: 5),
//                 child: Form(
//                   key: _formKey,
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         flex: 3,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.grey.shade50,
//                             borderRadius: BorderRadius.circular(16),
//                             border: Border.all(color: Colors.grey.shade200),
//                           ),
//                           child: SingleChildScrollView(
//                             padding: const EdgeInsets.all(24),
//                             child: LayoutBuilder(
//                               builder: (context, constraints) {
//                                 final availableWidth = constraints.maxWidth;
//                                 int columnsCount = availableWidth > 500 ? 2 : 1;

//                                 return Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     // Project Basic Information
//                                     const SectionTitle(
//                                       title: 'Project Information',
//                                       icon: Icons.info_outline_rounded,
//                                     ),
//                                     const SizedBox(height: 16),
//                                     ResponsiveGrid(
//                                       columns: columnsCount,
//                                       children: [
//                                         CustomTextFormField(
//                                           label: 'Project Name',
//                                           controller: _projectNameController,
//                                           isdate: false,
//                                           readOnly: false,
//                                           isRequired: true,
//                                         ),
//                                         CustomDropdownField(
//                                           label: 'Organization Type',
//                                           value: _selectedOrganizationType,
//                                           items: const [
//                                             'GOV',
//                                             'PRIVATE',
//                                           ],
//                                           onChanged: (val) => setState(() =>
//                                               _selectedOrganizationType = val),
//                                           isRequired: true,
//                                         ),
//                                         CustomDropdownField(
//                                           label: 'Organization Category',
//                                           value: _selectedOrganizationCategory,
//                                           items: const [
//                                             'HOSPITAL',
//                                             'CONSTRUCTION',
//                                             'LOGISTICS'
//                                           ],
//                                           onChanged: (val) => setState(() =>
//                                               _selectedOrganizationCategory =
//                                                   val),
//                                           isRequired: true,
//                                         ),
//                                         if (widget.isEditMode)
//                                           CustomDropdownField(
//                                             label: 'Status',
//                                             value: _selectedStatus,
//                                             items: ['ACTIVE', 'INACTIVE'],
//                                             onChanged: (val) => setState(
//                                                 () => _selectedStatus = val),
//                                             isRequired: true,
//                                           ),
//                                         CustomDropdownField(
//                                           items: (Get.find<ConfigController>()
//                                                       .configData
//                                                       .value
//                                                       .country ??
//                                                   [])
//                                               .map((country) => country.name)
//                                               .whereType<String>()
//                                               .toList(),
//                                           label: 'Country',
//                                           isRequired: true,
//                                           value: _selectedCountry,
//                                           onChanged: (value) {
//                                             _selectedCountry = value ?? '';
//                                           },
//                                         ),
//                                         CustomTextFormField(
//                                           label: 'City',
//                                           controller: _locationController,
//                                           isdate: false,
//                                           readOnly: false,
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(height: 20),

//                                     const SizedBox(height: 32),

//                                     // Client Assignment Section
//                                     Padding(
//                                       padding: const EdgeInsets.all(16),
//                                       child: Row(
//                                         children: [
//                                           const SizedBox(width: 16),
//                                           Expanded(
//                                             child: CustomActionButton(
//                                               text: 'Cancel',
//                                               icon: Icons.close_rounded,
//                                               textColor: Colors.grey,
//                                               onPressed: () =>
//                                                   Navigator.pop(context),
//                                               borderColor: Colors.grey.shade300,
//                                             ),
//                                           ),
//                                           const SizedBox(width: 16),
//                                           Expanded(
//                                             flex: 2,
//                                             child: CustomActionButton(
//                                               text: widget.isEditMode
//                                                   ? 'Update Project'
//                                                   : 'Create Project',
//                                               icon: Icons.save_rounded,
//                                               isFilled: true,
//                                               gradient: const LinearGradient(
//                                                 colors: [
//                                                   Color(0xFF7F00FF),
//                                                   Color(0xFFE100FF)
//                                                 ],
//                                               ),
//                                               onPressed: () async {
//                                                 if (_formKey.currentState!
//                                                     .validate()) {
//                                                   if (widget.isEditMode) {
//                                                     showLoaderDialog(context);
//                                                     await projectController
//                                                         .editProject(
//                                                       project: ProductModel(
//                                                         sId:
//                                                             widget.project?.sId,
//                                                         status:
//                                                             _selectedStatus ??
//                                                                 'ACTIVE',
//                                                         projectName:
//                                                             _projectNameController
//                                                                 .text
//                                                                 .trim(),
//                                                         organizationType:
//                                                             _selectedOrganizationType ??
//                                                                 '',
//                                                         organizationCategory:
//                                                             _selectedOrganizationCategory ??
//                                                                 '',
//                                                         city:
//                                                             _locationController
//                                                                 .text
//                                                                 .trim(),
//                                                         country:
//                                                             _selectedCountry
//                                                                 ?.trim(),
//                                                       ),
//                                                       context: context,
//                                                       projectId:
//                                                           widget.project?.sId ??
//                                                               '',
//                                                     );
//                                                     Navigator.pop(context);
//                                                   } else {
//                                                     showLoaderDialog(context);
//                                                     await projectController
//                                                         .createProject(
//                                                       context: context,
//                                                       project: ProductModel(
//                                                         status: 'ACTIVE',
//                                                         projectName:
//                                                             _projectNameController
//                                                                 .text
//                                                                 .trim(),
//                                                         organizationType:
//                                                             _selectedOrganizationType ??
//                                                                 '',
//                                                         organizationCategory:
//                                                             _selectedOrganizationCategory ??
//                                                                 '',
//                                                         city:
//                                                             _locationController
//                                                                 .text
//                                                                 .trim(),
//                                                         country:
//                                                             _selectedCountry
//                                                                 ?.trim(),
//                                                       ),
//                                                     );
//                                                     Navigator.pop(context);
//                                                   }
//                                                 }
//                                               },
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 24),
//                     ],
//                   ),
//                 ));
//           },
//         ),
//       ),
//     );
//   }
// }

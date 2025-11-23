// product_service_controller.dart
import 'package:get/get.dart';

// add_edit_product_service.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/widgets.dart';
// product_service_list.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductServiceListScreen extends StatelessWidget {
  final ProductServiceController controller =
      Get.find<ProductServiceController>();

  ProductServiceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products & Services'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Get.dialog(const AddEditProductService(isEditMode: false));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filters
          _buildFilters(),

          // Statistics
          _buildStatistics(),

          // List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              final items = controller.filteredItems;

              if (items.isEmpty) {
                return const Center(
                  child: Text('No items found'),
                );
              }

              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return _buildItemCard(item);
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.dialog(const AddEditProductService(isEditMode: false));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildFilters() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                value: controller.selectedType.value,
                items: ['ALL', ...ProductServiceConfig.types]
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (value) {
                  controller.selectedType.value = value!;
                },
                decoration: const InputDecoration(
                  labelText: 'Type',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: controller.selectedCategory.value,
                items: ['ALL', ...ProductServiceConfig.categories]
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                onChanged: (value) {
                  controller.selectedCategory.value = value!;
                },
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: controller.filterStatus.value,
                items: ['ALL', 'ACTIVE', 'INACTIVE', 'DISCONTINUED']
                    .map((status) => DropdownMenuItem(
                          value: status,
                          child: Text(status),
                        ))
                    .toList(),
                onChanged: (value) {
                  controller.filterStatus.value = value!;
                },
                decoration: const InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatistics() {
    return Obx(() {
      final products = controller.getProducts();
      final services = controller.getServices();

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildStatCard('Total Items',
                controller.productsServices.length.toString(), Colors.blue),
            _buildStatCard(
                'Products', products.length.toString(), Colors.green),
            _buildStatCard(
                'Services', services.length.toString(), Colors.orange),
            _buildStatCard(
                'Inventory Value',
                '\$${controller.totalInventoryValue.toStringAsFixed(2)}',
                Colors.purple),
            _buildStatCard('Low Stock',
                controller.lowStockItems.length.toString(), Colors.red),
          ],
        ),
      );
    });
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemCard(ProductService item) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: item.type == 'PRODUCT' ? Colors.green : Colors.blue,
          child: Icon(
            item.type == 'PRODUCT' ? Icons.inventory_2 : Icons.construction,
            color: Colors.white,
          ),
        ),
        title: Text(item.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.description),
            Text('${item.category} • ${item.brand}'),
            Text(
                'Price: \$${item.sellingPrice.toStringAsFixed(2)} • Cost: \$${item.totalCost.toStringAsFixed(2)}'),
            if (item.type == 'PRODUCT' && item.currentStock != null)
              Text('Stock: ${item.currentStock} • Min: ${item.minStockLevel}'),
            if (item.type == 'SERVICE' && item.durationHours != null)
              Text('Duration: ${item.durationHours} hours'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Chip(
              label: Text(
                item.status,
                style: TextStyle(
                  color: item.status == 'ACTIVE' ? Colors.green : Colors.red,
                ),
              ),
              backgroundColor: item.status == 'ACTIVE'
                  ? Colors.green.shade50
                  : Colors.red.shade50,
            ),
            const SizedBox(width: 8),
            PopupMenuButton(
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Text('Edit'),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Text('Delete'),
                ),
              ],
              onSelected: (value) {
                if (value == 'edit') {
                  Get.dialog(
                      AddEditProductService(item: item, isEditMode: true));
                } else if (value == 'delete') {
                  controller.deleteProductService(item.id!);
                }
              },
            ),
          ],
        ),
        onTap: () {
          _showItemDetails(item);
        },
      ),
    );
  }

  void _showItemDetails(ProductService item) {
    Get.dialog(
      Dialog(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor:
                        item.type == 'PRODUCT' ? Colors.green : Colors.blue,
                    child: Icon(
                      item.type == 'PRODUCT'
                          ? Icons.inventory_2
                          : Icons.construction,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      item.name,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildDetailRow('Type', item.type),
              _buildDetailRow('Category', item.category),
              if (item.subCategory != null)
                _buildDetailRow('Sub Category', item.subCategory!),
              _buildDetailRow('Brand', item.brand),
              if (item.model != null) _buildDetailRow('Model', item.model!),
              _buildDetailRow('Description', item.description),
              const SizedBox(height: 16),
              const Text('Pricing:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              _buildDetailRow(
                  'Base Price', '\$${item.basePrice.toStringAsFixed(2)}'),
              _buildDetailRow(
                  'Selling Price', '\$${item.sellingPrice.toStringAsFixed(2)}'),
              _buildDetailRow(
                  'GST %', '${item.gstPercent.toStringAsFixed(2)}%'),
              _buildDetailRow('CGST', '\$${item.cgst.toStringAsFixed(2)}'),
              _buildDetailRow('SGST', '\$${item.sgst.toStringAsFixed(2)}'),
              _buildDetailRow(
                  'Total Price', '\$${item.totalPrice.toStringAsFixed(2)}'),
              _buildDetailRow(
                  'Total Cost', '\$${item.totalCost.toStringAsFixed(2)}'),
              if (item.costComponents.isNotEmpty) ...[
                const SizedBox(height: 16),
                const Text('Cost Components:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                ...item.costComponents.map((component) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                                  '${component.componentName} (${component.type})')),
                          Text('\$${component.amount.toStringAsFixed(2)}'),
                        ],
                      ),
                    )),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class AddEditProductService extends StatefulWidget {
  final ProductService? item;
  final bool isEditMode;

  const AddEditProductService({super.key, this.item, required this.isEditMode});

  @override
  State<AddEditProductService> createState() => _AddEditProductServiceState();
}

class _AddEditProductServiceState extends State<AddEditProductService> {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.find<ProductServiceController>();

  // Basic Information
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _skuController = TextEditingController();

  // Pricing
  final _basePriceController = TextEditingController();
  final _sellingPriceController = TextEditingController();
  final _gstPercentController = TextEditingController();

  // Inventory
  final _currentStockController = TextEditingController();
  final _minStockController = TextEditingController();
  final _reorderQuantityController = TextEditingController();

  // Service Specific
  final _durationController = TextEditingController();
  final _targetQuantityController = TextEditingController();
  final _locationController = TextEditingController();
  final _countryController = TextEditingController();

  // Dropdown Values
  String? _selectedType;
  String? _selectedCategory;
  String? _selectedSubCategory;
  String? _selectedServiceType;
  String? _selectedStatus;

  // Cost Components
  List<CostComponent> _costComponents = [];
  final _costNameController = TextEditingController();
  final _costDescController = TextEditingController();
  final _costAmountController = TextEditingController();
  String? _selectedCostType;

  // Calculated Values
  double _cgst = 0.0;
  double _sgst = 0.0;
  double _totalPrice = 0.0;
  double _totalCost = 0.0;

  @override
  void initState() {
    _initializeForm();
    super.initState();
  }

  void _initializeForm() {
    if (widget.isEditMode && widget.item != null) {
      final item = widget.item!;

      // Basic Information
      _nameController.text = item.name;
      _descriptionController.text = item.description;
      _brandController.text = item.brand;
      _modelController.text = item.model ?? '';
      _skuController.text = item.sku ?? '';

      // Pricing
      _basePriceController.text = item.basePrice.toString();
      _sellingPriceController.text = item.sellingPrice.toString();
      _gstPercentController.text = item.gstPercent.toString();

      // Inventory
      if (item.currentStock != null) {
        _currentStockController.text = item.currentStock.toString();
      }
      if (item.minStockLevel != null) {
        _minStockController.text = item.minStockLevel.toString();
      }
      if (item.reorderQuantity != null) {
        _reorderQuantityController.text = item.reorderQuantity.toString();
      }

      // Service Specific
      if (item.durationHours != null) {
        _durationController.text = item.durationHours.toString();
      }
      if (item.targetQuantity != null) {
        _targetQuantityController.text = item.targetQuantity.toString();
      }
      _locationController.text = item.location ?? '';
      _countryController.text = item.country ?? '';

      // Dropdowns
      _selectedType = item.type;
      _selectedCategory = item.category;
      _selectedSubCategory = item.subCategory;
      _selectedServiceType = item.serviceType;
      _selectedStatus = item.status;

      // Cost Components
      _costComponents = List.from(item.costComponents);

      // Calculated Values
      _cgst = item.cgst;
      _sgst = item.sgst;
      _totalPrice = item.totalPrice;
      _totalCost = item.totalCost;
    } else {
      _selectedType = 'PRODUCT';
      _selectedCategory = 'OTHER';
      _selectedStatus = 'ACTIVE';
      _selectedCostType = 'VARIABLE';
    }
  }

  void _calculateTaxes() {
    final basePrice = double.tryParse(_basePriceController.text) ?? 0.0;
    final gstPercent = double.tryParse(_gstPercentController.text) ?? 0.0;

    setState(() {
      _cgst = (basePrice * gstPercent / 100) / 2;
      _sgst = (basePrice * gstPercent / 100) / 2;
      _totalPrice = basePrice + _cgst + _sgst;
    });
  }

  void _calculateTotalCost() {
    setState(() {
      _totalCost =
          _costComponents.fold(0.0, (sum, component) => sum + component.amount);
    });
  }

  void _addCostComponent() {
    final name = _costNameController.text.trim();
    final description = _costDescController.text.trim();
    final amount = double.tryParse(_costAmountController.text) ?? 0.0;
    final type = _selectedCostType ?? 'VARIABLE';

    if (name.isNotEmpty && amount > 0) {
      setState(() {
        _costComponents.add(CostComponent(
          componentName: name,
          description: description,
          amount: amount,
          type: type,
        ));
      });
      _costNameController.clear();
      _costDescController.clear();
      _costAmountController.clear();
      _calculateTotalCost();
    } else {
      Get.snackbar('Error', 'Please enter valid cost component details',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void _removeCostComponent(int index) {
    setState(() {
      _costComponents.removeAt(index);
    });
    _calculateTotalCost();
  }

  void _saveItem() {
    if (_formKey.currentState!.validate()) {
      final basePrice = double.tryParse(_basePriceController.text) ?? 0.0;
      final sellingPrice = double.tryParse(_sellingPriceController.text) ?? 0.0;

      final item = ProductService(
        id: widget.item?.id,
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        type: _selectedType!,
        category: _selectedCategory!,
        subCategory: _selectedSubCategory,
        brand: _brandController.text.trim(),
        model: _modelController.text.trim().isEmpty
            ? null
            : _modelController.text.trim(),
        sku: _skuController.text.trim().isEmpty
            ? null
            : _skuController.text.trim(),
        basePrice: basePrice,
        sellingPrice: sellingPrice,
        gstPercent: double.tryParse(_gstPercentController.text) ?? 0.0,
        cgst: _cgst,
        sgst: _sgst,
        totalPrice: _totalPrice,
        costComponents: _costComponents,
        totalCost: _totalCost,
        currentStock: _currentStockController.text.trim().isEmpty
            ? null
            : int.tryParse(_currentStockController.text.trim()),
        minStockLevel: _minStockController.text.trim().isEmpty
            ? null
            : int.tryParse(_minStockController.text.trim()),
        reorderQuantity: _reorderQuantityController.text.trim().isEmpty
            ? null
            : int.tryParse(_reorderQuantityController.text.trim()),
        durationHours: _durationController.text.trim().isEmpty
            ? null
            : int.tryParse(_durationController.text.trim()),
        serviceType: _selectedServiceType,
        isActive: true,
        targetQuantity: _targetQuantityController.text.trim().isEmpty
            ? null
            : int.tryParse(_targetQuantityController.text.trim()),
        location: _locationController.text.trim().isEmpty
            ? null
            : _locationController.text.trim(),
        country: _countryController.text.trim().isEmpty
            ? null
            : _countryController.text.trim(),
        status: _selectedStatus!,
        createdAt: widget.item?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );

      if (widget.isEditMode) {
        controller.updateProductService(item);
      } else {
        controller.addProductService(item);
      }
      Get.back();
    }
  }

  Widget _buildProductFields() {
    if (_selectedType != 'PRODUCT') return const SizedBox();

    return Column(
      children: [
        const SectionTitle(
          title: 'Inventory Information',
          icon: Icons.inventory,
        ),
        const SizedBox(height: 16),
        ResponsiveGrid(
          columns: 3,
          children: [
            CustomTextFormField(
              label: 'Current Stock',
              controller: _currentStockController,
              keyboardType: TextInputType.number,
            ),
            CustomTextFormField(
              label: 'Min Stock Level',
              controller: _minStockController,
              keyboardType: TextInputType.number,
            ),
            CustomTextFormField(
              label: 'Reorder Quantity',
              controller: _reorderQuantityController,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildServiceFields() {
    if (_selectedType != 'SERVICE') return const SizedBox();

    return Column(
      children: [
        const SectionTitle(
          title: 'Service Information',
          icon: Icons.construction,
        ),
        const SizedBox(height: 16),
        ResponsiveGrid(
          columns: 2,
          children: [
            CustomDropdownField(
              label: 'Service Type',
              value: _selectedServiceType,
              items: ProductServiceConfig.serviceTypes,
              onChanged: (value) {
                setState(() {
                  _selectedServiceType = value;
                });
              },
            ),
            CustomTextFormField(
              label: 'Duration (Hours)',
              controller: _durationController,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCostBreakdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'Cost Breakdown',
          icon: Icons.attach_money,
        ),
        const SizedBox(height: 16),

        // Add Cost Component
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              ResponsiveGrid(
                columns: 2,
                children: [
                  CustomTextFormField(
                    label: 'Component Name',
                    controller: _costNameController,
                  ),
                  CustomDropdownField(
                    label: 'Cost Type',
                    value: _selectedCostType,
                    items: ProductServiceConfig.costComponentTypes,
                    onChanged: (value) {
                      setState(() {
                        _selectedCostType = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                label: 'Description',
                controller: _costDescController,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      label: 'Amount',
                      controller: _costAmountController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: _addCostComponent,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Component'),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Cost Components List
        if (_costComponents.isNotEmpty) ...[
          const SizedBox(height: 16),
          const Text(
            'Cost Components:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ..._costComponents.asMap().entries.map((entry) {
            final index = entry.key;
            final component = entry.value;
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: _getCostTypeColor(component.type),
                  child: Text(
                    component.type[0],
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                title: Text(component.componentName),
                subtitle: Text(component.description),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '\$${component.amount.toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon:
                          const Icon(Icons.delete, color: Colors.red, size: 20),
                      onPressed: () => _removeCostComponent(index),
                    ),
                  ],
                ),
              ),
            );
          }),

          // Total Cost
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Cost:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${_totalCost.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Color _getCostTypeColor(String type) {
    switch (type) {
      case 'FIXED':
        return Colors.green;
      case 'VARIABLE':
        return Colors.orange;
      case 'TAX':
        return Colors.red;
      case 'LABOR':
        return Colors.blue;
      case 'MATERIAL':
        return Colors.purple;
      case 'OVERHEAD':
        return Colors.brown;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade50,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.inventory_2,
                          color: Colors.purple, size: 24),
                      const SizedBox(width: 12),
                      Text(
                        widget.isEditMode ? 'Edit Item' : 'Add New Item',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Get.back(),
                      ),
                    ],
                  ),
                ),

                // Form Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Type & Category
                        Row(
                          children: [
                            Expanded(
                              child: CustomDropdownField(
                                label: 'Type *',
                                value: _selectedType,
                                items: ProductServiceConfig.types,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedType = value;
                                    _selectedSubCategory = null;
                                  });
                                },
                                isRequired: true,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: CustomDropdownField(
                                label: 'Category *',
                                value: _selectedCategory,
                                items: ProductServiceConfig.categories,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedCategory = value;
                                    _selectedSubCategory = null;
                                  });
                                },
                                isRequired: true,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Sub Category
                        if (_selectedCategory != null)
                          CustomDropdownField(
                            label: 'Sub Category',
                            value: _selectedSubCategory,
                            items: ProductServiceConfig.getSubCategories(
                                    _selectedCategory!)
                                .keys
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedSubCategory = value;
                              });
                            },
                          ),
                        const SizedBox(height: 20),

                        // Basic Information
                        const SectionTitle(
                          title: 'Basic Information',
                          icon: Icons.info,
                        ),
                        const SizedBox(height: 16),
                        ResponsiveGrid(
                          columns: 2,
                          children: [
                            CustomTextFormField(
                              label: 'Name *',
                              controller: _nameController,
                              isRequired: true,
                            ),
                            CustomTextFormField(
                              label: 'Brand *',
                              controller: _brandController,
                              isRequired: true,
                            ),
                            CustomTextFormField(
                              label: 'Model',
                              controller: _modelController,
                            ),
                            CustomTextFormField(
                              label: 'SKU',
                              controller: _skuController,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          label: 'Description *',
                          controller: _descriptionController,
                          maxLines: 3,
                          isRequired: true,
                        ),
                        const SizedBox(height: 20),

                        // Pricing Information
                        const SectionTitle(
                          title: 'Pricing Information',
                          icon: Icons.monetization_on,
                        ),
                        const SizedBox(height: 16),
                        ResponsiveGrid(
                          columns: 3,
                          children: [
                            CustomTextFormField(
                              label: 'Base Price *',
                              controller: _basePriceController,
                              keyboardType: TextInputType.number,
                              isRequired: true,
                              // onChanged: (value) => _calculateTaxes(),
                            ),
                            CustomTextFormField(
                              label: 'Selling Price *',
                              controller: _sellingPriceController,
                              keyboardType: TextInputType.number,
                              isRequired: true,
                            ),
                            CustomTextFormField(
                              label: 'GST % *',
                              controller: _gstPercentController,
                              keyboardType: TextInputType.number,
                              isRequired: true,
                              // onChanged: (value) => _calculateTaxes(),
                            ),
                          ],
                        ),

                        // Tax Calculation Display
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.green.shade200),
                          ),
                          child: ResponsiveGrid(
                            columns: 4,
                            children: [
                              _buildTaxDisplay('CGST', _cgst),
                              _buildTaxDisplay('SGST', _sgst),
                              _buildTaxDisplay('Total Tax', _cgst + _sgst),
                              _buildTaxDisplay('Final Price', _totalPrice),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Product/Service Specific Fields
                        _buildProductFields(),
                        _buildServiceFields(),
                        const SizedBox(height: 20),

                        // Target & Location
                        const SectionTitle(
                          title: 'Target & Location',
                          icon: Icons.location_on,
                        ),
                        const SizedBox(height: 16),
                        ResponsiveGrid(
                          columns: 3,
                          children: [
                            CustomTextFormField(
                              label: 'Target Quantity',
                              controller: _targetQuantityController,
                              keyboardType: TextInputType.number,
                            ),
                            CustomTextFormField(
                              label: 'Location',
                              controller: _locationController,
                            ),
                            CustomTextFormField(
                              label: 'Country',
                              controller: _countryController,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Cost Breakdown
                        _buildCostBreakdown(),
                        const SizedBox(height: 20),

                        // Status
                        CustomDropdownField(
                          label: 'Status *',
                          value: _selectedStatus,
                          items: const ['ACTIVE', 'INACTIVE', 'DISCONTINUED'],
                          onChanged: (value) {
                            setState(() {
                              _selectedStatus = value;
                            });
                          },
                          isRequired: true,
                        ),

                        // Action Buttons
                        const SizedBox(height: 32),
                        Row(
                          children: [
                            Expanded(
                              child: CustomActionButton(
                                text: 'Cancel',
                                icon: Icons.close,
                                textColor: Colors.grey,
                                onPressed: () => Get.back(),
                                borderColor: Colors.grey.shade300,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: CustomActionButton(
                                text: widget.isEditMode
                                    ? 'Update Item'
                                    : 'Create Item',
                                icon: Icons.save,
                                isFilled: true,
                                gradient: const LinearGradient(
                                  colors: [Colors.purple, Colors.deepPurple],
                                ),
                                onPressed: _saveItem,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTaxDisplay(String label, double value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        Text(
          '\$${value.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}

class ProductServiceController extends GetxController {
  var productsServices = <ProductService>[].obs;
  var isLoading = false.obs;
  var selectedType = 'ALL'.obs;
  var selectedCategory = 'ALL'.obs;
  var filterStatus = 'ALL'.obs;

  // Add new product/service
  Future<void> addProductService(ProductService item) async {
    try {
      isLoading.value = true;
      productsServices.add(item);
      Get.snackbar('Success', '${item.type} added successfully',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Failed to add ${item.type}: $e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  // Update product/service
  Future<void> updateProductService(ProductService item) async {
    try {
      isLoading.value = true;
      final index = productsServices.indexWhere((p) => p.id == item.id);
      if (index != -1) {
        productsServices[index] = item;
      }
      Get.snackbar('Success', '${item.type} updated successfully',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Failed to update ${item.type}: $e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  // Delete product/service
  Future<void> deleteProductService(String id) async {
    try {
      isLoading.value = true;
      productsServices.removeWhere((item) => item.id == id);
      Get.snackbar('Success', 'Item deleted successfully',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete item: $e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  // Get filtered items
  List<ProductService> get filteredItems {
    var filtered = productsServices.toList();

    if (selectedType.value != 'ALL') {
      filtered =
          filtered.where((item) => item.type == selectedType.value).toList();
    }

    if (selectedCategory.value != 'ALL') {
      filtered = filtered
          .where((item) => item.category == selectedCategory.value)
          .toList();
    }

    if (filterStatus.value != 'ALL') {
      filtered =
          filtered.where((item) => item.status == filterStatus.value).toList();
    }

    return filtered;
  }

  // Get items by type
  List<ProductService> getProducts() {
    return productsServices.where((item) => item.type == 'PRODUCT').toList();
  }

  List<ProductService> getServices() {
    return productsServices.where((item) => item.type == 'SERVICE').toList();
  }

  // Calculate total value
  double get totalInventoryValue {
    return getProducts().fold(
        0.0,
        (sum, product) =>
            sum + (product.totalCost * (product.currentStock ?? 0)));
  }

  // Get low stock items
  List<ProductService> get lowStockItems {
    return getProducts()
        .where((product) =>
            (product.currentStock ?? 0) <= (product.minStockLevel ?? 0))
        .toList();
  }
}

// product_service_model.dart

class ProductService {
  String? id;
  String name;
  String description;
  String type; // PRODUCT or SERVICE
  String category;
  String? subCategory;
  String brand;
  String? model;
  String? sku;

  // Pricing
  double basePrice;
  double sellingPrice;
  double gstPercent;
  double cgst;
  double sgst;
  double totalPrice;

  // Cost Breakdown
  List<CostComponent> costComponents;
  double totalCost;

  // Inventory (for products)
  int? currentStock;
  int? minStockLevel;
  int? reorderQuantity;

  // Service Specific
  int? durationHours;
  String? serviceType; // ONE_TIME, RECURRING, CONSULTATION
  bool? isActive;

  // Target & Location
  int? targetQuantity;
  String? location;
  String? country;

  // Metadata
  String status; // ACTIVE, INACTIVE, DISCONTINUED
  DateTime createdAt;
  DateTime updatedAt;

  ProductService({
    this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.category,
    this.subCategory,
    required this.brand,
    this.model,
    this.sku,
    required this.basePrice,
    required this.sellingPrice,
    required this.gstPercent,
    required this.cgst,
    required this.sgst,
    required this.totalPrice,
    required this.costComponents,
    required this.totalCost,
    this.currentStock,
    this.minStockLevel,
    this.reorderQuantity,
    this.durationHours,
    this.serviceType,
    this.isActive,
    this.targetQuantity,
    this.location,
    this.country,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductService.fromJson(Map<String, dynamic> json) {
    return ProductService(
      id: json['_id'] ?? json['id'],
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] ?? 'PRODUCT',
      category: json['category'] ?? '',
      subCategory: json['subCategory'],
      brand: json['brand'] ?? '',
      model: json['model'],
      sku: json['sku'],
      basePrice: (json['basePrice'] as num?)?.toDouble() ?? 0.0,
      sellingPrice: (json['sellingPrice'] as num?)?.toDouble() ?? 0.0,
      gstPercent: (json['gstPercent'] as num?)?.toDouble() ?? 0.0,
      cgst: (json['cgst'] as num?)?.toDouble() ?? 0.0,
      sgst: (json['sgst'] as num?)?.toDouble() ?? 0.0,
      totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0.0,
      costComponents: json['costComponents'] != null
          ? (json['costComponents'] as List)
              .map((i) => CostComponent.fromJson(i))
              .toList()
          : [],
      totalCost: (json['totalCost'] as num?)?.toDouble() ?? 0.0,
      currentStock: (json['currentStock'] as num?)?.toInt(),
      minStockLevel: (json['minStockLevel'] as num?)?.toInt(),
      reorderQuantity: (json['reorderQuantity'] as num?)?.toInt(),
      durationHours: (json['durationHours'] as num?)?.toInt(),
      serviceType: json['serviceType'],
      isActive: json['isActive'] ?? true,
      targetQuantity: (json['targetQuantity'] as num?)?.toInt(),
      location: json['location'],
      country: json['country'],
      status: json['status'] ?? 'ACTIVE',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      'name': name,
      'description': description,
      'type': type,
      'category': category,
      if (subCategory != null) 'subCategory': subCategory,
      'brand': brand,
      if (model != null) 'model': model,
      if (sku != null) 'sku': sku,
      'basePrice': basePrice,
      'sellingPrice': sellingPrice,
      'gstPercent': gstPercent,
      'cgst': cgst,
      'sgst': sgst,
      'totalPrice': totalPrice,
      'costComponents': costComponents.map((c) => c.toJson()).toList(),
      'totalCost': totalCost,
      if (currentStock != null) 'currentStock': currentStock,
      if (minStockLevel != null) 'minStockLevel': minStockLevel,
      if (reorderQuantity != null) 'reorderQuantity': reorderQuantity,
      if (durationHours != null) 'durationHours': durationHours,
      if (serviceType != null) 'serviceType': serviceType,
      if (isActive != null) 'isActive': isActive,
      if (targetQuantity != null) 'targetQuantity': targetQuantity,
      if (location != null) 'location': location,
      if (country != null) 'country': country,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class CostComponent {
  String componentName;
  String description;
  double amount;
  String type; // FIXED, VARIABLE, TAX, LABOR, MATERIAL, OVERHEAD
  double? percentage; // Optional percentage of base price

  CostComponent({
    required this.componentName,
    required this.description,
    required this.amount,
    required this.type,
    this.percentage,
  });

  factory CostComponent.fromJson(Map<String, dynamic> json) {
    return CostComponent(
      componentName: json['componentName'] ?? '',
      description: json['description'] ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      type: json['type'] ?? 'VARIABLE',
      percentage: (json['percentage'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'componentName': componentName,
      'description': description,
      'amount': amount,
      'type': type,
      if (percentage != null) 'percentage': percentage,
    };
  }
}

class ProductServiceConfig {
  static const List<String> types = ['PRODUCT', 'SERVICE'];

  static const List<String> categories = [
    'TRAVEL_PACKAGE',
    'VISA_SERVICE',
    'EDUCATION_COURSE',
    'VEHICLE',
    'INSURANCE',
    'CONSULTATION',
    'OTHER'
  ];

  static const List<String> serviceTypes = [
    'ONE_TIME',
    'RECURRING',
    'CONSULTATION',
    'SUBSCRIPTION'
  ];

  static const List<String> costComponentTypes = [
    'FIXED',
    'VARIABLE',
    'TAX',
    'LABOR',
    'MATERIAL',
    'OVERHEAD',
    'TRANSPORT',
    'ACCOMMODATION'
  ];

  static Map<String, List<String>> getSubCategories(String category) {
    switch (category) {
      case 'TRAVEL_PACKAGE':
        return {
          'Domestic': ['Weekend Getaway', 'Family Vacation', 'Business Trip'],
          'International': ['Europe Tour', 'Asia Package', 'USA Trip'],
          'Adventure': ['Trekking', 'Scuba Diving', 'Safari'],
        };
      case 'VISA_SERVICE':
        return {
          'Tourist': ['Single Entry', 'Multiple Entry'],
          'Business': ['Short Term', 'Long Term'],
          'Student': ['University', 'Language Course'],
        };
      case 'EDUCATION_COURSE':
        return {
          'Language': ['English', 'Spanish', 'French'],
          'Technical': ['Programming', 'Design', 'Data Science'],
          'Test Preparation': ['IELTS', 'TOEFL', 'GRE'],
        };
      case 'VEHICLE':
        return {
          'Cars': ['Sedan', 'SUV', 'Hatchback'],
          'Bikes': ['Sports', 'Cruiser', 'Adventure'],
        };
      default:
        return {
          'General': ['Standard']
        };
    }
  }
}

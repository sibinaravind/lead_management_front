// bill_model.dart

// bill_controller.dart
import 'package:get/get.dart';
// add_edit_bill.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/widgets.dart';
// bill_accounting_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../product/product_list_screen.dart';

class BillAccountingScreen extends StatelessWidget {
  final BillController controller = Get.find<BillController>();

  BillAccountingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Billing & Accounting'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Get.dialog(const AddEditBill(isEditMode: false));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filters
          _buildFilters(),

          // Accounting Dashboard
          _buildAccountingDashboard(),

          // Bills List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              final bills = controller.filteredBills;

              if (bills.isEmpty) {
                return const Center(
                  child: Text('No bills found'),
                );
              }

              return ListView.builder(
                itemCount: bills.length,
                itemBuilder: (context, index) {
                  final bill = bills[index];
                  return _buildBillCard(bill);
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.dialog(const AddEditBill(isEditMode: false));
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
                value: controller.selectedBillType.value,
                items: ['ALL', ...BillConfig.billTypes]
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (value) {
                  controller.selectedBillType.value = value!;
                },
                decoration: const InputDecoration(
                  labelText: 'Bill Type',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: controller.selectedStatus.value,
                items: ['ALL', ...BillConfig.statuses]
                    .map((status) => DropdownMenuItem(
                          value: status,
                          child: Text(status),
                        ))
                    .toList(),
                onChanged: (value) {
                  controller.selectedStatus.value = value!;
                },
                decoration: const InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: InkWell(
                onTap: () {
                  _showMonthPicker();
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        '${controller.selectedMonth.value.month}/${controller.selectedMonth.value.year}',
                      ),
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

  Widget _buildAccountingDashboard() {
    return Obx(() {
      final stats = controller.accountingStats;
      final overdue = controller.overdueBills;

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildStatCard('Total Revenue',
                '\$${stats['totalRevenue']!.toStringAsFixed(2)}', Colors.green),
            _buildStatCard('Amount Paid',
                '\$${stats['paidAmount']!.toStringAsFixed(2)}', Colors.blue),
            _buildStatCard(
                'Pending Amount',
                '\$${stats['pendingAmount']!.toStringAsFixed(2)}',
                Colors.orange),
            _buildStatCard(
                'Tax Collected',
                '\$${stats['taxCollected']!.toStringAsFixed(2)}',
                Colors.purple),
            _buildStatCard(
                'Overdue Bills', overdue.length.toString(), Colors.red),
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
              fontSize: 18,
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

  Widget _buildBillCard(Bill bill) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getStatusColor(bill.status),
          child: Icon(
            _getBillTypeIcon(bill.billType),
            color: Colors.white,
            size: 20,
          ),
        ),
        title: Text('${bill.billNumber} - ${bill.customerName}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(bill.customerEmail),
            Text('${bill.billType} • ${_formatDate(bill.billDate)}'),
            Text(
                'Amount: \$${bill.totalAmount.toStringAsFixed(2)} • Due: ${_formatDate(bill.dueDate)}'),
            if (bill.balanceDue > 0)
              Text('Balance Due: \$${bill.balanceDue.toStringAsFixed(2)}',
                  style: const TextStyle(color: Colors.red)),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Chip(
              label: Text(
                bill.status,
                style: TextStyle(
                  color: _getStatusColor(bill.status),
                  fontSize: 12,
                ),
              ),
              backgroundColor: _getStatusColor(bill.status).withOpacity(0.1),
            ),
            const SizedBox(width: 8),
            PopupMenuButton(
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'view',
                  child: Text('View Details'),
                ),
                const PopupMenuItem(
                  value: 'edit',
                  child: Text('Edit'),
                ),
                if (bill.balanceDue > 0)
                  const PopupMenuItem(
                    value: 'add_payment',
                    child: Text('Add Payment'),
                  ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Text('Delete'),
                ),
              ],
              onSelected: (value) {
                _handleBillAction(value, bill);
              },
            ),
          ],
        ),
        onTap: () {
          _showBillDetails(bill);
        },
      ),
    );
  }

  void _handleBillAction(String action, Bill bill) {
    switch (action) {
      case 'view':
        _showBillDetails(bill);
        break;
      case 'edit':
        Get.dialog(AddEditBill(bill: bill, isEditMode: true));
        break;
      case 'add_payment':
        _showAddPaymentDialog(bill);
        break;
      case 'delete':
        controller.deleteBill(bill.id!);
        break;
    }
  }

  void _showBillDetails(Bill bill) {
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
                    backgroundColor: _getStatusColor(bill.status),
                    child: Icon(
                      _getBillTypeIcon(bill.billType),
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '${bill.billNumber} - ${bill.billType}',
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
              _buildDetailRow('Customer', bill.customerName),
              _buildDetailRow('Email', bill.customerEmail),
              _buildDetailRow('Phone', bill.customerPhone),
              if (bill.customerGSTIN != null)
                _buildDetailRow('GSTIN', bill.customerGSTIN!),
              _buildDetailRow('Bill Date', _formatDate(bill.billDate)),
              _buildDetailRow('Due Date', _formatDate(bill.dueDate)),
              _buildDetailRow('Status', bill.status),
              _buildDetailRow('Payment Terms', bill.paymentTerms),
              const SizedBox(height: 16),
              const Text('Items:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              ...bill.items.map((item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                                '${item.name} (${item.quantity} × \$${item.unitPrice})')),
                        Text('\$${item.totalAmount.toStringAsFixed(2)}'),
                      ],
                    ),
                  )),
              const SizedBox(height: 16),
              const Text('Summary:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              _buildDetailRow(
                  'Sub Total', '\$${bill.subTotal.toStringAsFixed(2)}'),
              _buildDetailRow(
                  'Discount', '\$${bill.discountAmount.toStringAsFixed(2)}'),
              _buildDetailRow('Tax', '\$${bill.taxAmount.toStringAsFixed(2)}'),
              _buildDetailRow(
                  'Total Amount', '\$${bill.totalAmount.toStringAsFixed(2)}'),
              _buildDetailRow(
                  'Amount Paid', '\$${bill.amountPaid.toStringAsFixed(2)}'),
              _buildDetailRow(
                  'Balance Due', '\$${bill.balanceDue.toStringAsFixed(2)}'),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddPaymentDialog(Bill bill) {
    final amountController = TextEditingController();
    final referenceController = TextEditingController();
    String? selectedMethod;
    DateTime paymentDate = DateTime.now();

    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Add Payment',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedMethod,
                items: BillConfig.paymentMethods
                    .map((method) => DropdownMenuItem(
                          value: method,
                          child: Text(method),
                        ))
                    .toList(),
                onChanged: (value) {
                  selectedMethod = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Payment Method',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: referenceController,
                decoration: const InputDecoration(
                  labelText: 'Reference Number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final amount =
                            double.tryParse(amountController.text) ?? 0.0;
                        if (amount > 0 && selectedMethod != null) {
                          final payment = Payment(
                            paymentDate: paymentDate,
                            amount: amount,
                            paymentMethod: selectedMethod!,
                            referenceNumber: referenceController.text.isEmpty
                                ? null
                                : referenceController.text,
                            notes: 'Payment received',
                            status: 'COMPLETED',
                          );
                          controller.addPayment(bill.id!, payment);
                          Get.back();
                        }
                      },
                      child: const Text('Add Payment'),
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

  void _showMonthPicker() {
    // Get.dialog(
    //   Dialog(
    //     child: SizedBox(
    //       height: 300,
    //       child: SfDateRangePicker(
    //         view: DateRangePickerView.year,
    //         selectionMode: DateRangePickerSelectionMode.single,
    //         onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
    //           if (args.value is DateTime) {
    //             controller.selectedMonth.value = args.value;
    //             Get.back();
    //           }
    //         },
    //       ),
    //     ),
    //   ),
    // );
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

  Color _getStatusColor(String status) {
    switch (status) {
      case 'PAID':
        return Colors.green;
      case 'SENT':
        return Colors.blue;
      case 'DRAFT':
        return Colors.grey;
      case 'OVERDUE':
        return Colors.red;
      case 'CANCELLED':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData _getBillTypeIcon(String billType) {
    switch (billType) {
      case 'INVOICE':
        return Icons.receipt;
      case 'QUOTATION':
        return Icons.description;
      case 'RECEIPT':
        return Icons.assignment_turned_in;
      case 'CREDIT_NOTE':
        return Icons.credit_card;
      case 'DEBIT_NOTE':
        return Icons.money_off;
      default:
        return Icons.receipt;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

class AddEditBill extends StatefulWidget {
  final Bill? bill;
  final bool isEditMode;

  const AddEditBill({super.key, this.bill, required this.isEditMode});

  @override
  State<AddEditBill> createState() => _AddEditBillState();
}

class _AddEditBillState extends State<AddEditBill> {
  final _formKey = GlobalKey<FormState>();
  final billController = Get.find<BillController>();
  final productServiceController = Get.find<ProductServiceController>();

  // Bill Information
  final _billNumberController = TextEditingController();
  final _referenceController = TextEditingController();
  final _notesController = TextEditingController();

  // Customer Information
  final _customerNameController = TextEditingController();
  final _customerEmailController = TextEditingController();
  final _customerPhoneController = TextEditingController();
  final _customerAddressController = TextEditingController();
  final _customerGSTINController = TextEditingController();

  // Accounting
  final _shippingController = TextEditingController();
  final _adjustmentController = TextEditingController();
  final _discountPercentController = TextEditingController();

  // Dropdown Values
  String? _selectedBillType;
  String? _selectedStatus;
  String? _selectedPaymentTerms;
  String? _selectedAccountHead;
  String? _selectedCostCenter;
  String? _selectedProjectCode;

  // Dates
  DateTime _billDate = DateTime.now();
  DateTime _dueDate = DateTime.now();

  // Items
  List<BillItem> _items = [];
  final _itemQuantityController = TextEditingController();
  final _itemDiscountController = TextEditingController();
  ProductService? _selectedProductService;

  // Calculated Values
  double _subTotal = 0.0;
  double _discountAmount = 0.0;
  double _taxAmount = 0.0;
  double _totalAmount = 0.0;
  TaxBreakdown _taxBreakdown =
      TaxBreakdown(cgst: 0.0, sgst: 0.0, igst: 0.0, totalGST: 0.0);

  @override
  void initState() {
    _initializeForm();
    super.initState();
  }

  void _initializeForm() {
    if (widget.isEditMode && widget.bill != null) {
      final bill = widget.bill!;

      // Bill Information
      _billNumberController.text = bill.billNumber;
      _referenceController.text = bill.referenceNumber ?? '';
      _notesController.text = bill.notes ?? '';

      // Customer Information
      _customerNameController.text = bill.customerName;
      _customerEmailController.text = bill.customerEmail;
      _customerPhoneController.text = bill.customerPhone;
      _customerAddressController.text = bill.customerAddress ?? '';
      _customerGSTINController.text = bill.customerGSTIN ?? '';

      // Accounting
      _shippingController.text = bill.shippingCharges.toString();
      _adjustmentController.text = bill.adjustment.toString();
      _discountPercentController.text = bill.discountPercent.toString();

      // Dropdowns
      _selectedBillType = bill.billType;
      _selectedStatus = bill.status;
      _selectedPaymentTerms = bill.paymentTerms;
      _selectedAccountHead = bill.accountHead;
      _selectedCostCenter = bill.costCenter;
      _selectedProjectCode = bill.projectCode;

      // Dates
      _billDate = bill.billDate;
      _dueDate = bill.dueDate;

      // Items
      _items = List.from(bill.items);

      // Calculated Values
      _subTotal = bill.subTotal;
      _discountAmount = bill.discountAmount;
      _taxAmount = bill.taxAmount;
      _totalAmount = bill.totalAmount;
      _taxBreakdown = bill.taxBreakdown;
    } else {
      _selectedBillType = 'INVOICE';
      _selectedStatus = 'DRAFT';
      _selectedPaymentTerms = 'Due on Receipt';
      _billNumberController.text = billController.generateBillNumber();
      _dueDate = _billDate;
    }
  }

  void _calculateTotals() {
    // Calculate item totals
    for (var item in _items) {
      final itemTotal = item.quantity * item.unitPrice;
      final itemDiscount = itemTotal * (item.discountPercent / 100);
      final taxableAmount = itemTotal - itemDiscount;
      final itemTax = taxableAmount * (item.taxPercent / 100);

      item.discountAmount = itemDiscount;
      item.taxAmount = itemTax;
      item.totalAmount = taxableAmount + itemTax;
    }

    // Calculate bill totals
    _subTotal =
        _items.fold(0.0, (sum, item) => sum + (item.quantity * item.unitPrice));
    _discountAmount = _subTotal *
        (double.tryParse(_discountPercentController.text) ?? 0.0) /
        100;
    final taxableAmount = _subTotal - _discountAmount;

    // Calculate taxes (assuming 18% GST split equally for CGST/SGST)
    const gstRate = 18.0;
    _taxBreakdown.cgst = taxableAmount * (gstRate / 2) / 100;
    _taxBreakdown.sgst = taxableAmount * (gstRate / 2) / 100;
    _taxBreakdown.totalGST = _taxBreakdown.cgst + _taxBreakdown.sgst;
    _taxAmount = _taxBreakdown.totalGST;

    final shipping = double.tryParse(_shippingController.text) ?? 0.0;
    final adjustment = double.tryParse(_adjustmentController.text) ?? 0.0;

    _totalAmount = taxableAmount + _taxAmount + shipping + adjustment;

    setState(() {});
  }

  void _addItem() {
    if (_selectedProductService != null) {
      final quantity = double.tryParse(_itemQuantityController.text) ?? 1.0;
      final discountPercent =
          double.tryParse(_itemDiscountController.text) ?? 0.0;

      final item = BillItem(
        productServiceId: _selectedProductService!.id!,
        name: _selectedProductService!.name,
        description: _selectedProductService!.description,
        quantity: quantity,
        unit: 'pcs',
        unitPrice: _selectedProductService!.sellingPrice,
        discountPercent: discountPercent,
        discountAmount: 0.0,
        taxPercent: _selectedProductService!.gstPercent,
        taxAmount: 0.0,
        totalAmount: 0.0,
      );

      setState(() {
        _items.add(item);
      });

      _selectedProductService = null;
      _itemQuantityController.clear();
      _itemDiscountController.clear();
      _calculateTotals();
    }
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
    _calculateTotals();
  }

  void _saveBill() {
    if (_formKey.currentState!.validate() && _items.isNotEmpty) {
      final bill = Bill(
        id: widget.bill?.id,
        billNumber: _billNumberController.text.trim(),
        billType: _selectedBillType!,
        status: _selectedStatus!,
        customerName: _customerNameController.text.trim(),
        customerEmail: _customerEmailController.text.trim(),
        customerPhone: _customerPhoneController.text.trim(),
        customerAddress: _customerAddressController.text.trim().isEmpty
            ? null
            : _customerAddressController.text.trim(),
        customerGSTIN: _customerGSTINController.text.trim().isEmpty
            ? null
            : _customerGSTINController.text.trim(),
        billDate: _billDate,
        dueDate: _dueDate,
        paymentTerms: _selectedPaymentTerms!,
        referenceNumber: _referenceController.text.trim().isEmpty
            ? null
            : _referenceController.text.trim(),
        notes: _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
        items: _items,
        subTotal: _subTotal,
        discountAmount: _discountAmount,
        discountPercent:
            double.tryParse(_discountPercentController.text) ?? 0.0,
        taxAmount: _taxAmount,
        shippingCharges: double.tryParse(_shippingController.text) ?? 0.0,
        adjustment: double.tryParse(_adjustmentController.text) ?? 0.0,
        totalAmount: _totalAmount,
        amountPaid: widget.bill?.amountPaid ?? 0.0,
        balanceDue: _totalAmount - (widget.bill?.amountPaid ?? 0.0),
        taxBreakdown: _taxBreakdown,
        payments: widget.bill?.payments ?? [],
        paymentMethod: widget.bill?.paymentMethod,
        bankName: widget.bill?.bankName,
        transactionId: widget.bill?.transactionId,
        accountHead: _selectedAccountHead,
        costCenter: _selectedCostCenter,
        projectCode: _selectedProjectCode,
        createdAt: widget.bill?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
        createdBy: 'current_user', // Replace with actual user
      );

      if (widget.isEditMode) {
        billController.updateBill(bill);
      } else {
        billController.addBill(bill);
      }
      Get.back();
    } else if (_items.isEmpty) {
      Get.snackbar('Error', 'Please add at least one item',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Widget _buildItemsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'Items & Services',
          icon: Icons.list,
        ),
        const SizedBox(height: 16),

        // Add Item Form
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
                    flex: 3,
                    child: DropdownButtonFormField<ProductService>(
                      value: _selectedProductService,
                      items: productServiceController.productsServices
                          .where((item) => item.status == 'ACTIVE')
                          .map((item) => DropdownMenuItem(
                                value: item,
                                child: Text(
                                    '${item.name} - \$${item.sellingPrice}'),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedProductService = value;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Select Product/Service',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _itemQuantityController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Qty',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _itemDiscountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Disc %',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: _addItem,
                    icon: const Icon(Icons.add),
                    label: const Text('Add'),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Items List
        if (_items.isNotEmpty) ...[
          const SizedBox(height: 16),
          const Text(
            'Items:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ..._items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue.shade50,
                  child: Text(
                    (index + 1).toString(),
                    style: const TextStyle(color: Colors.blue),
                  ),
                ),
                title: Text(item.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.description),
                    Text(
                        'Qty: ${item.quantity} × \$${item.unitPrice.toStringAsFixed(2)}'),
                    if (item.discountPercent > 0)
                      Text(
                          'Discount: ${item.discountPercent}% (- \$${item.discountAmount.toStringAsFixed(2)})'),
                    Text('Tax: \$${item.taxAmount.toStringAsFixed(2)}'),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '\$${item.totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeItem(index),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ],
    );
  }

  Widget _buildSummarySection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildSummaryRow('Sub Total', _subTotal),
          _buildSummaryRow('Discount (-)', _discountAmount),
          _buildSummaryRow('CGST (9%)', _taxBreakdown.cgst),
          _buildSummaryRow('SGST (9%)', _taxBreakdown.sgst),
          _buildSummaryRow(
              'Shipping', double.tryParse(_shippingController.text) ?? 0.0),
          _buildSummaryRow(
              'Adjustment', double.tryParse(_adjustmentController.text) ?? 0.0),
          const Divider(),
          _buildSummaryRow('Total Amount', _totalAmount, isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 16 : 14,
            ),
          ),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 18 : 14,
              color: isTotal ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
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
                    color: Colors.green.shade50,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.receipt, color: Colors.green, size: 24),
                      const SizedBox(width: 12),
                      Text(
                        widget.isEditMode ? 'Edit Bill' : 'Create New Bill',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
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
                        // Bill Information
                        const SectionTitle(
                          title: 'Bill Information',
                          icon: Icons.description,
                        ),
                        const SizedBox(height: 16),
                        ResponsiveGrid(
                          columns: 3,
                          children: [
                            CustomTextFormField(
                              label: 'Bill Number *',
                              controller: _billNumberController,
                              isRequired: true,
                              readOnly: true,
                            ),
                            CustomDropdownField(
                              label: 'Bill Type *',
                              value: _selectedBillType,
                              items: BillConfig.billTypes,
                              onChanged: (value) {
                                setState(() {
                                  _selectedBillType = value;
                                });
                              },
                              isRequired: true,
                            ),
                            CustomDropdownField(
                              label: 'Status *',
                              value: _selectedStatus,
                              items: BillConfig.statuses,
                              onChanged: (value) {
                                setState(() {
                                  _selectedStatus = value;
                                });
                              },
                              isRequired: true,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ResponsiveGrid(
                          columns: 2,
                          children: [
                            InkWell(
                              onTap: () async {
                                final date = await showDatePicker(
                                  context: context,
                                  initialDate: _billDate,
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2100),
                                );
                                if (date != null) {
                                  setState(() {
                                    _billDate = date;
                                    _dueDate = billController.calculateDueDate(
                                        date, _selectedPaymentTerms!);
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.calendar_today, size: 16),
                                    const SizedBox(width: 8),
                                    Text(
                                        'Bill Date: ${_billDate.day}/${_billDate.month}/${_billDate.year}'),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                final date = await showDatePicker(
                                  context: context,
                                  initialDate: _dueDate,
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2100),
                                );
                                if (date != null) {
                                  setState(() {
                                    _dueDate = date;
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.calendar_today, size: 16),
                                    const SizedBox(width: 8),
                                    Text(
                                        'Due Date: ${_dueDate.day}/${_dueDate.month}/${_dueDate.year}'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ResponsiveGrid(
                          columns: 2,
                          children: [
                            CustomDropdownField(
                              label: 'Payment Terms *',
                              value: _selectedPaymentTerms,
                              items: BillConfig.paymentTerms,
                              onChanged: (value) {
                                setState(() {
                                  _selectedPaymentTerms = value;
                                  _dueDate = billController.calculateDueDate(
                                      _billDate, value!);
                                });
                              },
                              isRequired: true,
                            ),
                            CustomTextFormField(
                              label: 'Reference Number',
                              controller: _referenceController,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Customer Information
                        const SectionTitle(
                          title: 'Customer Information',
                          icon: Icons.person,
                        ),
                        const SizedBox(height: 16),
                        ResponsiveGrid(
                          columns: 2,
                          children: [
                            CustomTextFormField(
                              label: 'Customer Name *',
                              controller: _customerNameController,
                              isRequired: true,
                            ),
                            CustomTextFormField(
                              label: 'Email *',
                              controller: _customerEmailController,
                              keyboardType: TextInputType.emailAddress,
                              isRequired: true,
                            ),
                            CustomTextFormField(
                              label: 'Phone *',
                              controller: _customerPhoneController,
                              keyboardType: TextInputType.phone,
                              isRequired: true,
                            ),
                            CustomTextFormField(
                              label: 'GSTIN',
                              controller: _customerGSTINController,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          label: 'Address',
                          controller: _customerAddressController,
                          maxLines: 2,
                        ),
                        const SizedBox(height: 20),

                        // Items Section
                        _buildItemsSection(),
                        const SizedBox(height: 20),

                        // Pricing & Summary
                        const SectionTitle(
                          title: 'Pricing & Summary',
                          icon: Icons.calculate,
                        ),
                        const SizedBox(height: 16),
                        ResponsiveGrid(
                          columns: 3,
                          children: [
                            CustomTextFormField(
                              label: 'Discount %',
                              controller: _discountPercentController,
                              keyboardType: TextInputType.number,
                              // onChanged: (value) => _calculateTotals(),
                            ),
                            CustomTextFormField(
                              label: 'Shipping Charges',
                              controller: _shippingController,
                              keyboardType: TextInputType.number,
                              // onChanged: (value) => _calculateTotals(),
                            ),
                            CustomTextFormField(
                              label: 'Adjustment',
                              controller: _adjustmentController,
                              keyboardType: TextInputType.number,
                              // onChanged: (value) => _calculateTotals(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildSummarySection(),
                        const SizedBox(height: 20),

                        // Accounting Information
                        const SectionTitle(
                          title: 'Accounting Information',
                          icon: Icons.account_balance,
                        ),
                        const SizedBox(height: 16),
                        ResponsiveGrid(
                          columns: 3,
                          children: [
                            CustomDropdownField(
                              label: 'Account Head',
                              value: _selectedAccountHead,
                              items: BillConfig.accountHeads,
                              onChanged: (value) {
                                setState(() {
                                  _selectedAccountHead = value;
                                });
                              },
                            ),
                            CustomTextFormField(
                              label: 'Cost Center',
                              controller: TextEditingController(
                                  text: _selectedCostCenter),
                              // onChanged: (value) {
                              //   _selectedCostCenter = value;
                              // },
                            ),
                            CustomTextFormField(
                              label: 'Project Code',
                              controller: TextEditingController(
                                  text: _selectedProjectCode),
                              // onChanged: (value) {
                              //   _selectedProjectCode = value;
                              // },
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          label: 'Notes',
                          controller: _notesController,
                          maxLines: 3,
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
                                    ? 'Update Bill'
                                    : 'Create Bill',
                                icon: Icons.save,
                                isFilled: true,
                                gradient: const LinearGradient(
                                  colors: [Colors.green, Colors.lightGreen],
                                ),
                                onPressed: _saveBill,
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
}

class BillController extends GetxController {
  var bills = <Bill>[].obs;
  var isLoading = false.obs;
  var selectedBillType = 'ALL'.obs;
  var selectedStatus = 'ALL'.obs;
  var selectedMonth = DateTime.now().obs;

  // Generate bill number
  String generateBillNumber() {
    final now = DateTime.now();
    final year = now.year.toString();
    final month = now.month.toString().padLeft(2, '0');
    final count = bills
            .where((bill) =>
                bill.billDate.year == now.year &&
                bill.billDate.month == now.month)
            .length +
        1;
    return 'INV-$year$month-${count.toString().padLeft(4, '0')}';
  }

  // Add new bill
  Future<void> addBill(Bill bill) async {
    try {
      isLoading.value = true;
      bills.add(bill);
      Get.snackbar('Success', 'Bill created successfully',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Failed to create bill: $e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  // Update bill
  Future<void> updateBill(Bill bill) async {
    try {
      isLoading.value = true;
      final index = bills.indexWhere((b) => b.id == bill.id);
      if (index != -1) {
        bills[index] = bill;
      }
      Get.snackbar('Success', 'Bill updated successfully',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Failed to update bill: $e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  // Delete bill
  Future<void> deleteBill(String id) async {
    try {
      isLoading.value = true;
      bills.removeWhere((bill) => bill.id == id);
      Get.snackbar('Success', 'Bill deleted successfully',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete bill: $e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  // Add payment to bill
  void addPayment(String billId, Payment payment) {
    final bill = bills.firstWhereOrNull((b) => b.id == billId);
    if (bill != null) {
      bill.payments.add(payment);
      bill.amountPaid += payment.amount;
      bill.balanceDue = bill.totalAmount - bill.amountPaid;
      if (bill.balanceDue <= 0) {
        bill.status = 'PAID';
      }
      updateBill(bill);
    }
  }

  // Get filtered bills
  List<Bill> get filteredBills {
    var filtered = bills.toList();

    if (selectedBillType.value != 'ALL') {
      filtered = filtered
          .where((bill) => bill.billType == selectedBillType.value)
          .toList();
    }

    if (selectedStatus.value != 'ALL') {
      filtered = filtered
          .where((bill) => bill.status == selectedStatus.value)
          .toList();
    }

    filtered = filtered
        .where((bill) =>
            bill.billDate.year == selectedMonth.value.year &&
            bill.billDate.month == selectedMonth.value.month)
        .toList();

    return filtered;
  }

  // Get bills by status
  List<Bill> getBillsByStatus(String status) {
    return bills.where((bill) => bill.status == status).toList();
  }

  // Get accounting statistics
  Map<String, double> get accountingStats {
    final monthBills = bills.where((bill) =>
        bill.billDate.year == selectedMonth.value.year &&
        bill.billDate.month == selectedMonth.value.month);

    return {
      'totalRevenue':
          monthBills.fold(0.0, (sum, bill) => sum + bill.totalAmount),
      'paidAmount': monthBills.fold(0.0, (sum, bill) => sum + bill.amountPaid),
      'pendingAmount':
          monthBills.fold(0.0, (sum, bill) => sum + bill.balanceDue),
      'taxCollected': monthBills.fold(0.0, (sum, bill) => sum + bill.taxAmount),
    };
  }

  // Get overdue bills
  List<Bill> get overdueBills {
    return bills
        .where((bill) =>
            bill.status == 'SENT' && bill.dueDate.isBefore(DateTime.now()))
        .toList();
  }

  // Calculate due date based on payment terms
  DateTime calculateDueDate(DateTime billDate, String paymentTerms) {
    switch (paymentTerms) {
      case 'Net 15':
        return billDate.add(const Duration(days: 15));
      case 'Net 30':
        return billDate.add(const Duration(days: 30));
      case 'Net 45':
        return billDate.add(const Duration(days: 45));
      case 'Net 60':
        return billDate.add(const Duration(days: 60));
      default:
        return billDate; // Due on Receipt
    }
  }
}

class Bill {
  String? id;
  String billNumber;
  String billType; // INVOICE, QUOTATION, RECEIPT, CREDIT_NOTE, DEBIT_NOTE
  String status; // DRAFT, SENT, PAID, OVERDUE, CANCELLED

  // Customer Information
  String customerName;
  String customerEmail;
  String customerPhone;
  String? customerAddress;
  String? customerGSTIN;

  // Bill Details
  DateTime billDate;
  DateTime dueDate;
  String paymentTerms; // Due on Receipt, Net 15, Net 30, Net 45
  String? referenceNumber;
  String? notes;

  // Items
  List<BillItem> items;

  // Pricing
  double subTotal;
  double discountAmount;
  double discountPercent;
  double taxAmount;
  double shippingCharges;
  double adjustment;
  double totalAmount;
  double amountPaid;
  double balanceDue;

  // Tax Breakdown
  TaxBreakdown taxBreakdown;

  // Payment Information
  List<Payment> payments;
  String? paymentMethod; // CASH, CARD, BANK_TRANSFER, CHEQUE, ONLINE
  String? bankName;
  String? transactionId;

  // Accounting
  String? accountHead;
  String? costCenter;
  String? projectCode;

  // Metadata
  DateTime createdAt;
  DateTime updatedAt;
  String createdBy;

  Bill({
    this.id,
    required this.billNumber,
    required this.billType,
    required this.status,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    this.customerAddress,
    this.customerGSTIN,
    required this.billDate,
    required this.dueDate,
    required this.paymentTerms,
    this.referenceNumber,
    this.notes,
    required this.items,
    required this.subTotal,
    required this.discountAmount,
    required this.discountPercent,
    required this.taxAmount,
    required this.shippingCharges,
    required this.adjustment,
    required this.totalAmount,
    required this.amountPaid,
    required this.balanceDue,
    required this.taxBreakdown,
    required this.payments,
    this.paymentMethod,
    this.bankName,
    this.transactionId,
    this.accountHead,
    this.costCenter,
    this.projectCode,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
  });

  factory Bill.fromJson(Map<String, dynamic> json) {
    return Bill(
      id: json['_id'] ?? json['id'],
      billNumber: json['billNumber'] ?? '',
      billType: json['billType'] ?? 'INVOICE',
      status: json['status'] ?? 'DRAFT',
      customerName: json['customerName'] ?? '',
      customerEmail: json['customerEmail'] ?? '',
      customerPhone: json['customerPhone'] ?? '',
      customerAddress: json['customerAddress'],
      customerGSTIN: json['customerGSTIN'],
      billDate: DateTime.parse(json['billDate']),
      dueDate: DateTime.parse(json['dueDate']),
      paymentTerms: json['paymentTerms'] ?? 'Due on Receipt',
      referenceNumber: json['referenceNumber'],
      notes: json['notes'],
      items:
          (json['items'] as List?)?.map((i) => BillItem.fromJson(i)).toList() ??
              [],
      subTotal: (json['subTotal'] as num?)?.toDouble() ?? 0.0,
      discountAmount: (json['discountAmount'] as num?)?.toDouble() ?? 0.0,
      discountPercent: (json['discountPercent'] as num?)?.toDouble() ?? 0.0,
      taxAmount: (json['taxAmount'] as num?)?.toDouble() ?? 0.0,
      shippingCharges: (json['shippingCharges'] as num?)?.toDouble() ?? 0.0,
      adjustment: (json['adjustment'] as num?)?.toDouble() ?? 0.0,
      totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0.0,
      amountPaid: (json['amountPaid'] as num?)?.toDouble() ?? 0.0,
      balanceDue: (json['balanceDue'] as num?)?.toDouble() ?? 0.0,
      taxBreakdown: TaxBreakdown.fromJson(json['taxBreakdown'] ?? {}),
      payments: (json['payments'] as List?)
              ?.map((i) => Payment.fromJson(i))
              .toList() ??
          [],
      paymentMethod: json['paymentMethod'],
      bankName: json['bankName'],
      transactionId: json['transactionId'],
      accountHead: json['accountHead'],
      costCenter: json['costCenter'],
      projectCode: json['projectCode'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      createdBy: json['createdBy'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      'billNumber': billNumber,
      'billType': billType,
      'status': status,
      'customerName': customerName,
      'customerEmail': customerEmail,
      'customerPhone': customerPhone,
      if (customerAddress != null) 'customerAddress': customerAddress,
      if (customerGSTIN != null) 'customerGSTIN': customerGSTIN,
      'billDate': billDate.toIso8601String(),
      'dueDate': dueDate.toIso8601String(),
      'paymentTerms': paymentTerms,
      if (referenceNumber != null) 'referenceNumber': referenceNumber,
      if (notes != null) 'notes': notes,
      'items': items.map((i) => i.toJson()).toList(),
      'subTotal': subTotal,
      'discountAmount': discountAmount,
      'discountPercent': discountPercent,
      'taxAmount': taxAmount,
      'shippingCharges': shippingCharges,
      'adjustment': adjustment,
      'totalAmount': totalAmount,
      'amountPaid': amountPaid,
      'balanceDue': balanceDue,
      'taxBreakdown': taxBreakdown.toJson(),
      'payments': payments.map((p) => p.toJson()).toList(),
      if (paymentMethod != null) 'paymentMethod': paymentMethod,
      if (bankName != null) 'bankName': bankName,
      if (transactionId != null) 'transactionId': transactionId,
      if (accountHead != null) 'accountHead': accountHead,
      if (costCenter != null) 'costCenter': costCenter,
      if (projectCode != null) 'projectCode': projectCode,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'createdBy': createdBy,
    };
  }
}

class BillItem {
  String productServiceId;
  String name;
  String description;
  double quantity;
  String unit;
  double unitPrice;
  double discountPercent;
  double discountAmount;
  double taxPercent;
  double taxAmount;
  double totalAmount;

  BillItem({
    required this.productServiceId,
    required this.name,
    required this.description,
    required this.quantity,
    required this.unit,
    required this.unitPrice,
    required this.discountPercent,
    required this.discountAmount,
    required this.taxPercent,
    required this.taxAmount,
    required this.totalAmount,
  });

  factory BillItem.fromJson(Map<String, dynamic> json) {
    return BillItem(
      productServiceId: json['productServiceId'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      quantity: (json['quantity'] as num?)?.toDouble() ?? 0.0,
      unit: json['unit'] ?? '',
      unitPrice: (json['unitPrice'] as num?)?.toDouble() ?? 0.0,
      discountPercent: (json['discountPercent'] as num?)?.toDouble() ?? 0.0,
      discountAmount: (json['discountAmount'] as num?)?.toDouble() ?? 0.0,
      taxPercent: (json['taxPercent'] as num?)?.toDouble() ?? 0.0,
      taxAmount: (json['taxAmount'] as num?)?.toDouble() ?? 0.0,
      totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productServiceId': productServiceId,
      'name': name,
      'description': description,
      'quantity': quantity,
      'unit': unit,
      'unitPrice': unitPrice,
      'discountPercent': discountPercent,
      'discountAmount': discountAmount,
      'taxPercent': taxPercent,
      'taxAmount': taxAmount,
      'totalAmount': totalAmount,
    };
  }
}

class TaxBreakdown {
  double cgst;
  double sgst;
  double igst;
  double totalGST;

  TaxBreakdown({
    required this.cgst,
    required this.sgst,
    required this.igst,
    required this.totalGST,
  });

  factory TaxBreakdown.fromJson(Map<String, dynamic> json) {
    return TaxBreakdown(
      cgst: (json['cgst'] as num?)?.toDouble() ?? 0.0,
      sgst: (json['sgst'] as num?)?.toDouble() ?? 0.0,
      igst: (json['igst'] as num?)?.toDouble() ?? 0.0,
      totalGST: (json['totalGST'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cgst': cgst,
      'sgst': sgst,
      'igst': igst,
      'totalGST': totalGST,
    };
  }
}

class Payment {
  DateTime paymentDate;
  double amount;
  String paymentMethod;
  String? referenceNumber;
  String? notes;
  String status; // PENDING, COMPLETED, FAILED

  Payment({
    required this.paymentDate,
    required this.amount,
    required this.paymentMethod,
    this.referenceNumber,
    this.notes,
    required this.status,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      paymentDate: DateTime.parse(json['paymentDate']),
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      paymentMethod: json['paymentMethod'] ?? '',
      referenceNumber: json['referenceNumber'],
      notes: json['notes'],
      status: json['status'] ?? 'COMPLETED',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'paymentDate': paymentDate.toIso8601String(),
      'amount': amount,
      'paymentMethod': paymentMethod,
      if (referenceNumber != null) 'referenceNumber': referenceNumber,
      if (notes != null) 'notes': notes,
      'status': status,
    };
  }
}

class BillConfig {
  static const List<String> billTypes = [
    'INVOICE',
    'QUOTATION',
    'RECEIPT',
    'CREDIT_NOTE',
    'DEBIT_NOTE'
  ];

  static const List<String> statuses = [
    'DRAFT',
    'SENT',
    'PAID',
    'OVERDUE',
    'CANCELLED'
  ];

  static const List<String> paymentTerms = [
    'Due on Receipt',
    'Net 15',
    'Net 30',
    'Net 45',
    'Net 60'
  ];

  static const List<String> paymentMethods = [
    'CASH',
    'CARD',
    'BANK_TRANSFER',
    'CHEQUE',
    'ONLINE',
    'UPI',
    'WALLET'
  ];

  static const List<String> accountHeads = [
    'SALES',
    'SERVICE_REVENUE',
    'CONSULTING_FEES',
    'TRAVEL_INCOME',
    'EDUCATION_FEES',
    'OTHER_INCOME'
  ];
}

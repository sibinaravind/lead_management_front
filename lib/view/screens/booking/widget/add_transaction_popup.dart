// widgets/add_transaction_popup.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/controller/auth/login_controller.dart';
import 'package:overseas_front_end/utils/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';

import '../../../../controller/booking/booking_controller.dart';

class AddTransactionPopup extends StatefulWidget {
  final String bookingId;

  const AddTransactionPopup({
    super.key,
    required this.bookingId,
  });

  @override
  State<AddTransactionPopup> createState() => _AddTransactionPopupState();
}

class _AddTransactionPopupState extends State<AddTransactionPopup> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _transactionIdController = TextEditingController();
  final _remarksController = TextEditingController();

  String _selectedPaymentMethod = 'Cash';

  final List<String> _paymentMethods = [
    'Cash',
    'UPI',
    'Credit Card',
    'Debit Card',
    'Net Banking',
    'Cheque',
    'Bank Transfer',
  ];

  @override
  void dispose() {
    _amountController.dispose();
    _transactionIdController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width > 600 ? 500 : double.infinity,
        // constraints: const BoxConstraints(maxHeight: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryColor,
                    AppColors.primaryColor.withOpacity(0.8),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.payments,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: CustomText(
                      text: 'Add Transaction',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),

            // Form Content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Amount
                      CustomTextFormField(
                        controller: _amountController,
                        label: 'Amount *',
                        hintText: 'Enter amount',
                        keyboardType: TextInputType.number,
                        prefixIcon: Icons.currency_rupee,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter amount';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter valid amount';
                          }
                          if (double.parse(value) <= 0) {
                            return 'Amount must be greater than 0';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      CustomDropdownField(
                        label: 'Payment Method',
                        isRequired: true,
                        value: _selectedPaymentMethod,
                        items: _paymentMethods,
                        onChanged: (value) {
                          setState(() {
                            _selectedPaymentMethod = value!;
                          });
                        },
                      ),

                      const SizedBox(height: 16),

                      // Transaction ID
                      CustomTextFormField(
                        controller: _transactionIdController,
                        label: 'Transaction ID ',
                        isRequired: true,
                        hintText: 'Enter transaction ID',
                        prefixIcon: Icons.tag,
                      ),
                      const SizedBox(height: 16),

                      // Remarks
                      CustomTextFormField(
                        controller: _remarksController,
                        label: 'Remarks',
                        hintText: 'Enter remarks (optional)',
                        maxLines: 3,
                        prefixIcon: Icons.notes,
                      ),

                      // Info card
                    ],
                  ),
                ),
              ),
            ),

            // Footer Buttons
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                border: Border(
                  top: BorderSide(color: Colors.grey.shade300),
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: Colors.grey.shade400),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const CustomText(
                        text: 'Cancel',
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) return;

                        try {
                          final transactionData = {
                            "booking_id": widget.bookingId,
                            "amount": double.parse(_amountController.text),
                            "payment_method": _selectedPaymentMethod,
                            "transaction_id": _transactionIdController.text,
                            "remarks": _remarksController.text,
                            "officer_id": Get.find<LoginController>()
                                .officer
                                .value
                                ?.officerId,
                          };
                          showLoaderDialog(context);
                          Get.find<BookingController>()
                              .addPayment(transactionData, context);

                          // Call the callback with transaction data
                        } catch (e) {}
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const CustomText(
                        text: 'Add Transaction',
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

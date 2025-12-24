// widget/booking_payments_tab.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:overseas_front_end/model/booking_model/booking_model.dart';
import 'package:overseas_front_end/utils/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/responsive_grid.dart';
import 'package:overseas_front_end/view/widgets/section_title.dart';

import '../../cutsomer_profile/widgets/info_item.dart';

class BookingPaymentsTab extends StatelessWidget {
  final BookingModel booking;

  const BookingPaymentsTab({super.key, required this.booking});

  String _formatCurrency(double? amount) {
    if (amount == null) return '₹0.00';
    return '₹${amount.toStringAsFixed(2)}';
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return DateFormat('dd MMM yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    // Calculate payment summary
    double totalPaid = 0;
    if (booking.paymentSchedule != null) {
      for (var payment in booking.paymentSchedule!) {
        totalPaid += payment.paidAmount ?? 0;
      }
    }
    final grandTotal = booking.grandTotal ?? 0;
    final balance = grandTotal - totalPaid;

    return Align(
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth > 1000 ? 2 : 1;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Payment Summary Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.blue.shade50, Colors.purple.shade50],
                    ),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.blue.shade200, width: 1.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.account_balance_wallet,
                              color: Colors.blue.shade700),
                          const SizedBox(width: 12),
                          const Text(
                            'Payment Summary',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 24),
                      _buildSummaryRow('Grand Total', grandTotal, isBold: true),
                      const SizedBox(height: 8),
                      _buildSummaryRow('Total Paid', totalPaid,
                          color: Colors.blue.shade700),
                      const Divider(height: 16),
                      _buildSummaryRow('Balance Due', balance,
                          isBold: true,
                          color: balance > 0
                              ? Colors.orange.shade700
                              : Colors.green.shade700),
                    ],
                  ),
                ),
                // Initial Transaction

                const SizedBox(height: 24),

                // Payment Schedule
                if (booking.paymentSchedule != null &&
                    booking.paymentSchedule!.isNotEmpty) ...[
                  const SectionTitle(
                    title: "Payment Schedule",
                    icon: Icons.schedule_outlined,
                  ),
                  const SizedBox(height: 12),
                  ...booking.paymentSchedule!.asMap().entries.map((entry) {
                    final index = entry.key;
                    final payment = entry.value;
                    final isPaid = (payment.status?.toLowerCase() == 'paid');

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isPaid
                              ? Colors.green.shade300
                              : Colors.grey.shade300,
                          width: isPaid ? 1.5 : 0.8,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: isPaid
                                          ? Colors.green.shade50
                                          : AppColors.blueSecondaryColor
                                              .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      isPaid
                                          ? Icons.check_circle
                                          : Icons.schedule,
                                      color: isPaid
                                          ? Colors.green.shade700
                                          : AppColors.blueSecondaryColor,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    'Payment ${index + 1}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: isPaid
                                      ? Colors.green.shade50
                                      : Colors.orange.shade50,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: isPaid
                                        ? Colors.green.shade300
                                        : Colors.orange.shade300,
                                  ),
                                ),
                                child: Text(
                                  payment.status?.toUpperCase() ?? 'PENDING',
                                  style: TextStyle(
                                    color: isPaid
                                        ? Colors.green.shade700
                                        : Colors.orange.shade700,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 24),
                          ResponsiveGrid(
                            columns: columns,
                            children: [
                              InfoItem(
                                label: 'Payment Type',
                                value: payment.paymentType ?? 'N/A',
                                icon: Icons.category,
                                iconColor: AppColors.blueSecondaryColor,
                              ),
                              InfoItem(
                                label: 'Due Date',
                                value: _formatDate(payment.dueDate),
                                icon: Icons.event,
                                iconColor: AppColors.orangeSecondaryColor,
                              ),
                              InfoItem(
                                label: 'Amount',
                                value: _formatCurrency(payment.amount),
                                icon: Icons.monetization_on,
                                iconColor: AppColors.greenSecondaryColor,
                              ),
                              InfoItem(
                                label: 'Paid Amount',
                                value: _formatCurrency(payment.paidAmount),
                                icon: Icons.monetization_on,
                                iconColor: AppColors.greenSecondaryColor,
                              ),
                              InfoItem(
                                label: 'Paid At',
                                value: payment.paidAt ?? 'N/A',
                                icon: Icons.monetization_on,
                                iconColor: AppColors.greenSecondaryColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],

                const SizedBox(height: 24),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount,
      {bool isBold = false, Color? color}) {
    final textColor = color ?? Colors.grey.shade800;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: isBold ? 16 : 14,
            color: textColor,
          ),
        ),
        Text(
          _formatCurrency(amount),
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            fontSize: isBold ? 18 : 15,
            color: textColor,
          ),
        ),
      ],
    );
  }
}

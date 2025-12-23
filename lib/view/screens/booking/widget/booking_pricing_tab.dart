import 'package:flutter/material.dart';
import 'package:overseas_front_end/model/booking_model/booking_model.dart';
import 'package:overseas_front_end/utils/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/responsive_grid.dart';
import 'package:overseas_front_end/view/widgets/section_title.dart';
import '../../cutsomer_profile/widgets/info_item.dart';

class BookingPricingTab extends StatelessWidget {
  final BookingModel booking;

  const BookingPricingTab({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth > 1000 ? 2 : 1;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(
                  title: "Price Breakdown",
                  icon: Icons.receipt_long,
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.grey.shade300, width: 0.8),
                  ),
                  child: ResponsiveGrid(
                    columns: columns,
                    children: [
                      InfoItem(
                        label: 'Total Amount',
                        value:
                            '₹${booking.totalAmount?.toStringAsFixed(2) ?? '0.00'}',
                        icon: Icons.attach_money,
                        iconColor: AppColors.blueSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Discount Amount',
                        value:
                            '₹${booking.discountAmount?.toStringAsFixed(2) ?? '0.00'}',
                        icon: Icons.discount,
                        iconColor: AppColors.orangeSecondaryColor,
                      ),
                      InfoItem(
                        label: 'GST (${booking.gstPercentage ?? 0}%)',
                        value:
                            '₹${booking.gstAmount?.toStringAsFixed(2) ?? '0.00'}',
                        icon: Icons.percent,
                        iconColor: AppColors.greenSecondaryColor,
                      ),
                      InfoItem(
                        label: 'CGST (${booking.cgstPercentage ?? 0}%)',
                        value:
                            '₹${booking.cgstAmount?.toStringAsFixed(2) ?? '0.00'}',
                        icon: Icons.account_balance,
                        iconColor: AppColors.viloletSecondaryColor,
                      ),
                      InfoItem(
                        label: 'SGST (${booking.sgstPercentage ?? 0}%)',
                        value:
                            '₹${booking.sgstAmount?.toStringAsFixed(2) ?? '0.00'}',
                        icon: Icons.account_balance_wallet,
                        iconColor: AppColors.skyBlueSecondaryColor,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.green.shade50,
                        Colors.blue.shade50,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.green.shade200,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.account_balance_wallet,
                              color: Colors.green.shade700,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Grand Total',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '₹${booking.grandTotal?.toStringAsFixed(2) ?? '0.00'}',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green.shade700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (booking.priceComponents != null &&
                    booking.priceComponents!.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  const SectionTitle(
                    title: "Price Components",
                    icon: Icons.category,
                  ),
                  const SizedBox(height: 12),
                  ...booking.priceComponents!.asMap().entries.map((entry) {
                    final index = entry.key;
                    final component = entry.value;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: AppColors.primaryColor.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color:
                                      AppColors.primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.receipt,
                                  color: AppColors.primaryColor,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  component.title ?? 'Component ${index + 1}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                '₹${component.amount?.toStringAsFixed(2) ?? '0.00'}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 24),
                          ResponsiveGrid(
                            columns: columns,
                            children: [
                              InfoItem(
                                label: 'GST',
                                value: '${component.gstPercent ?? 0}%',
                                icon: Icons.percent,
                                iconColor: AppColors.greenSecondaryColor,
                              ),
                              InfoItem(
                                label: 'CGST',
                                value: '${component.cgstPercent ?? 0}%',
                                icon: Icons.account_balance,
                                iconColor: AppColors.viloletSecondaryColor,
                              ),
                              InfoItem(
                                label: 'SGST',
                                value: '${component.sgstPercent ?? 0}%',
                                icon: Icons.account_balance_wallet,
                                iconColor: AppColors.skyBlueSecondaryColor,
                              ),
                            ],
                          ),

                          // Show offers if any
                          if (component.offersApplied != null &&
                              component.offersApplied!.isNotEmpty) ...[
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.orange.shade50,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.orange.shade200,
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.local_offer,
                                        size: 16,
                                        color: Colors.orange.shade700,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Offers Applied',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange.shade900,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  ...component.offersApplied!.map((offer) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            offer.offerName ?? 'Offer',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            '-₹${offer.discountAmount?.toStringAsFixed(2) ?? '0.00'}',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green.shade700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  }).toList(),
                ],
                if (booking.loanAmountRequested != null &&
                    booking.loanAmountRequested! > 0) ...[
                  const SizedBox(height: 24),
                  const SectionTitle(
                    title: "Loan Information",
                    icon: Icons.account_balance,
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border:
                          Border.all(color: Colors.grey.shade300, width: 0.8),
                    ),
                    child: InfoItem(
                      label: 'Loan Amount Requested',
                      value:
                          '₹${booking.loanAmountRequested?.toStringAsFixed(2) ?? '0.00'}',
                      icon: Icons.monetization_on,
                      iconColor: AppColors.orangeSecondaryColor,
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

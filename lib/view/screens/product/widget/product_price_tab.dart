import 'package:flutter/material.dart';
import '../../../../model/product/product_model.dart';
import '../../../../utils/style/colors/colors.dart';
import '../../../widgets/responsive_grid.dart';
import '../../../widgets/section_title.dart';
import '../../cutsomer_profile/widgets/info_item.dart';
import '../../cutsomer_profile/widgets/info_section.dart';

class ProductPricingTab extends StatelessWidget {
  final ProductModel product;
  const ProductPricingTab({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
        child: LayoutBuilder(builder: (context, constraints) {
          final columns = constraints.maxWidth > 1000 ? 2 : 1;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(
                title: "Pricing & Payment",
                icon: Icons.currency_rupee,
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
                      label: 'Base Price',
                      value: product.basePrice?.toString() ?? 'N/A',
                      icon: Icons.money,
                      iconColor: AppColors.greenSecondaryColor,
                    ),
                    InfoItem(
                      label: 'Selling Price',
                      value: product.sellingPrice?.toString() ?? 'N/A',
                      icon: Icons.sell,
                      iconColor: AppColors.orangeSecondaryColor,
                    ),
                    InfoItem(
                      label: 'Cost Price',
                      value: product.costPrice?.toString() ?? 'N/A',
                      icon: Icons.price_check,
                      iconColor: AppColors.blueSecondaryColor,
                    ),
                    InfoItem(
                      label: 'Advance Required (%)',
                      value:
                          product.advanceRequiredPercent?.toString() ?? 'N/A',
                      icon: Icons.percent,
                      iconColor: AppColors.redSecondaryColor,
                    ),
                    InfoItem(
                      label: 'Down Payment',
                      value: product.downpayment?.toString() ?? 'N/A',
                      icon: Icons.account_balance_wallet,
                      iconColor: AppColors.viloletSecondaryColor,
                    ),
                    InfoItem(
                      label: 'Loan Eligibility',
                      value: product.loanEligibility?.toString() ?? 'N/A',
                      icon: Icons.school,
                      iconColor: AppColors.viloletSecondaryColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              if (product.priceComponents != null &&
                  product.priceComponents!.isNotEmpty)
                InfoSection(
                  title: 'Price Components',
                  icon: Icons.work_outline,
                  padding: const EdgeInsets.only(top: 2),
                  items: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        double width = constraints.maxWidth;
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth:
                                  width, // Ensures table expands to full width
                            ),
                            child: DataTable(
                              headingRowColor:
                                  MaterialStateProperty.all(Color(0xFFEFF3F6)),
                              // Use minimal column spacing & responsive layout
                              columnSpacing: 20,
                              horizontalMargin: 12,
                              // 👇 Makes table clean & mobile-friendly
                              dataRowMinHeight: 40,
                              dataRowMaxHeight: 70,

                              columns: const [
                                DataColumn(label: Text("Title")),
                                DataColumn(label: Text("Amount")),
                                DataColumn(label: Text("Gst %")),
                                DataColumn(label: Text("Cgst %")),
                                DataColumn(label: Text("Sgst %")),
                              ],

                              rows: product.priceComponents!.map((component) {
                                return DataRow(
                                  cells: [
                                    DataCell(
                                      ConstrainedBox(
                                        constraints:
                                            BoxConstraints(maxWidth: 160),
                                        child: Text(component.title ?? 'N/A'),
                                      ),
                                    ),
                                    DataCell(
                                      ConstrainedBox(
                                        constraints:
                                            BoxConstraints(maxWidth: 140),
                                        child: Text(
                                            component.amount?.toString() ??
                                                'N/A'),
                                      ),
                                    ),
                                    DataCell(Text(
                                        component.gstPercent?.toString() ??
                                            'N/A')),
                                    DataCell(Text(
                                        component.cgstPercent?.toString() ??
                                            'N/A')),
                                    DataCell(
                                      ConstrainedBox(
                                        constraints:
                                            BoxConstraints(maxWidth: 220),
                                        child: Text(
                                          component.sgstPercent?.toString() ??
                                              'N/A ',
                                          softWrap: true,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
            ],
          );
        }),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../model/product/product_model.dart';
import '../../../../utils/style/colors/colors.dart';
import '../../../widgets/responsive_grid.dart';
import '../../../widgets/section_title.dart';
import '../../cutsomer_profile/widgets/info_item.dart';

class ProductBasicInfoTab extends StatelessWidget {
  final ProductModel product;
  const ProductBasicInfoTab({super.key, required this.product});

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
                title: "Basic Information",
                icon: Icons.assignment_outlined,
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
                        label: 'Product Name',
                        value: product.name ?? 'N/A',
                        icon: Icons.badge,
                        iconColor: AppColors.orangeSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Product ID',
                        value: product.productId ?? 'N/A',
                        icon: Icons.fingerprint,
                        iconColor: AppColors.skyBlueSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Product Code',
                        value: product.code ?? 'N/A',
                        icon: Icons.confirmation_number,
                        iconColor: AppColors.blueSecondaryColor,
                      ),
                      // InfoItem(
                      //   label: 'Category',
                      //   value: product.category ?? 'N/A',
                      //   icon: Icons.category,
                      //   iconColor: AppColors.greenSecondaryColor,
                      // ),

                      InfoItem(
                        label: 'Sub Category',
                        value: product.subCategory ?? 'N/A',
                        icon: Icons.layers,
                        iconColor: AppColors.viloletSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Service Mode',
                        value: product.serviceMode ?? 'N/A',
                        icon: Icons.help_outline_sharp,
                        iconColor: AppColors.redSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Status',
                        value: product.status ?? 'N/A',
                        icon: Icons.toggle_on,
                        iconColor: AppColors.greenSecondaryColor,
                      ),
                    ],
                  )),
              const SizedBox(height: 28),
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
              const SizedBox(height: 24),
              const SectionTitle(
                title: 'Process Steps',
                icon: Icons.timeline_rounded,
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade300, width: 0.8),
                ),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: (product.stepList ?? []).isNotEmpty
                      ? product.stepList!
                          .map(
                            (step) => Chip(
                              label: Text(step),
                              backgroundColor: AppColors.blueSecondaryColor
                                  .withOpacity(0.12),
                              labelStyle: const TextStyle(fontSize: 13),
                            ),
                          )
                          .toList()
                      : [],
                ),
              ),
              const SizedBox(height: 24),
              const SectionTitle(
                title: 'Notes',
                icon: Icons.gavel_rounded,
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade300, width: 0.8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoItem(
                      label: 'Additional Notes',
                      value: product.notes?.isNotEmpty == true
                          ? product.notes!
                          : 'N/A',
                      icon: Icons.notes_rounded,
                      iconColor: AppColors.viloletSecondaryColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const SectionTitle(
                title: "Descriptions",
                icon: Icons.description_outlined,
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
                    columns: 1,
                    children: [
                      InfoItem(
                        label: 'Short Description',
                        value: product.shortDescription ?? 'N/A',
                        icon: Icons.description_outlined,
                        iconColor: AppColors.orangeSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Long Description',
                        value: product.description ?? 'N/A',
                        icon: Icons.description,
                        iconColor: AppColors.blueSecondaryColor,
                      ),
                    ],
                  )),
              SizedBox(height: 24),
              const SectionTitle(
                title: 'Terms & Conditions',
                icon: Icons.gavel_rounded,
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade300, width: 0.8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoItem(
                      label: 'Terms',
                      value: product.termsAndConditions?.isNotEmpty == true
                          ? product.termsAndConditions!
                          : 'N/A',
                      icon: Icons.rule_rounded,
                      iconColor: AppColors.orangeSecondaryColor,
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

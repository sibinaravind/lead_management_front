import 'package:flutter/material.dart';

import '../../../../model/product/product_model.dart';
import '../../../../utils/style/colors/colors.dart';
import '../../../widgets/responsive_grid.dart';
import '../../../widgets/section_title.dart';
import '../../cutsomer_profile/widgets/info_item.dart';
import '../../cutsomer_profile/widgets/info_section.dart';

class ProductEligibilityDisplayTab extends StatelessWidget {
  final ProductModel product;
  const ProductEligibilityDisplayTab({super.key, required this.product});

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
                title: "Eligibility & Criteria",
                icon: Icons.verified_user,
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
                      label: 'Age Limit',
                      value: product.ageLimit ?? 'N/A',
                      icon: Icons.cake_rounded,
                      iconColor: AppColors.orangeSecondaryColor,
                    ),
                    InfoItem(
                      label: 'Minimum Income',
                      value: product.minIncomeRequired ?? 'N/A',
                      icon: Icons.account_balance_rounded,
                      iconColor: AppColors.greenSecondaryColor,
                    ),
                    InfoItem(
                      label: 'Qualification Required',
                      value: product.qualificationRequired ?? 'N/A',
                      icon: Icons.school_rounded,
                      iconColor: AppColors.blueSecondaryColor,
                    ),
                    InfoItem(
                      label: 'Experience Required',
                      value: product.experienceRequired ?? 'N/A',
                      icon: Icons.work_outline_rounded,
                      iconColor: AppColors.viloletSecondaryColor,
                    ),
                    InfoItem(
                      label: 'Loan Eligibility',
                      value: product.loanEligibility?.toString() ?? 'N/A',
                      icon: Icons.credit_score_rounded,
                      iconColor: AppColors.redSecondaryColor,
                    ),
                    InfoItem(
                      label: 'Is Refundable',
                      value: product.isRefundable == true ? 'Yes' : 'No',
                      icon: Icons.refresh_rounded,
                      iconColor: AppColors.blueSecondaryColor,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // ---------------- DOCUMENTS ----------------
              if (product.documentsRequired != null &&
                  product.documentsRequired!.isNotEmpty)
                InfoSection(
                  title: 'Required Documents',
                  icon: Icons.description_rounded,
                  padding: const EdgeInsets.all(15),
                  items: product.documentsRequired!.map((doc) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      child: InfoItem(
                        label: doc.docName ?? 'Document',
                        value: doc.mandatory == true ? 'Mandatory' : 'Optional',
                        icon: Icons.file_present_rounded,
                        iconColor: doc.mandatory == true
                            ? AppColors.redSecondaryColor
                            : AppColors.greenSecondaryColor,
                      ),
                    );
                  }).toList(),
                ),
            ],
          );
        }),
      ),
    );
  }
}

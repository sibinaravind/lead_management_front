import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/controller/customer_profile/customer_profile_controller.dart';
import 'package:overseas_front_end/model/lead/lead_model.dart';
import '../../../../utils/style/colors/colors.dart';
import '../../../widgets/responsive_grid.dart';
import 'info_item.dart';
import '../../../widgets/section_title.dart';

class ProfessionalTab extends StatelessWidget {
  final LeadModel lead;
  const ProfessionalTab({super.key, required this.lead});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: GetBuilder<CustomerProfileController>(
        builder: (controller) {
          final lead = controller.leadDetails.value;

          return LayoutBuilder(builder: (context, constraints) {
            final availableWidth = constraints.maxWidth;
            int columnsCount = availableWidth > 1000 ? 2 : 1;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ------------------------------------------------------------------
                // PROFESSIONAL INFORMATION
                // ------------------------------------------------------------------
                const SectionTitle(
                  title: "Professional Information",
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
                    columns: columnsCount,
                    // gap: 12,
                    children: [
                      InfoItem(
                        label: 'Profession',
                        value: lead.profession ?? 'N/A',
                        icon: Icons.work_outline,
                        iconColor: AppColors.orangeSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Annual Income',
                        value: lead.annualIncome?.toString() ?? 'N/A',
                        icon: Icons.currency_rupee_rounded,
                        iconColor: AppColors.blueSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Expected Salary',
                        value: lead.expectedSalary?.toString() ?? 'N/A',
                        icon: Icons.currency_exchange_rounded,
                        iconColor: AppColors.greenSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Employment Status',
                        value: lead.employmentStatus ?? 'N/A',
                        icon: Icons.badge_outlined,
                        iconColor: AppColors.viloletSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Experience (years)',
                        value: lead.experience?.toString() ?? 'N/A',
                        icon: Icons.history_edu_rounded,
                        iconColor: AppColors.redSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Job Gap (months)',
                        value: lead.jobGapMonths?.toString() ?? 'N/A',
                        icon: Icons.pause_circle_filled_rounded,
                        iconColor: AppColors.blueSecondaryColor,
                      ),
                      if (lead.firstJobDate != null)
                        InfoItem(
                          label: 'First Job Date',
                          value: lead.firstJobDate ?? 'N/A',
                          icon: Icons.date_range_rounded,
                          iconColor: AppColors.darkOrangeColour,
                        ),
                      if (lead.skills != null)
                        InfoItem(
                          label: 'Skills',
                          value: lead.skills ?? 'N/A',
                          icon: Icons.build_circle_rounded,
                          iconColor: AppColors.greenSecondaryColor,
                        ),
                      if (lead.specializedIn != null)
                        InfoItem(
                          label: 'Specialized In',
                          value: lead.specializedIn ?? 'N/A',
                          icon: Icons.engineering_rounded,
                          iconColor: AppColors.orangeSecondaryColor,
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // ------------------------------------------------------------------
                // FINANCIAL INFORMATION
                // ------------------------------------------------------------------
                const SectionTitle(
                  title: "Financial Information",
                  icon: Icons.account_balance_wallet_outlined,
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
                    columns: columnsCount,
                    //  gap: 12,
                    children: [
                      if (lead.budget != null && lead.budget! > 0)
                        InfoItem(
                          label: 'Budget',
                          value: '₹${lead.budget!.toStringAsFixed(0)}',
                          icon: Icons.savings_rounded,
                          iconColor: AppColors.greenSecondaryColor,
                        ),
                      InfoItem(
                        label: 'Loan Required',
                        value: lead.loanAmountRequired?.toString() ?? 'N/A',
                        icon: Icons.request_quote_rounded,
                        iconColor: AppColors.blueSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Loan Amount Required',
                        value: lead.loanAmountRequired?.toString() ?? 'N/A',
                        icon: Icons.currency_rupee_rounded,
                        iconColor: AppColors.orangeSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Has Existing Loans',
                        value: lead.hasExistingLoans?.toString() ?? 'N/A',
                        icon: Icons.credit_card_rounded,
                        iconColor: AppColors.viloletSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Credit Score',
                        value: lead.creditScore?.toString() ?? 'N/A',
                        icon: Icons.score_rounded,
                        iconColor: AppColors.redSecondaryColor,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
              ],
            );
          });
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:overseas_front_end/model/lead/lead_model.dart';
import '../../../../utils/style/colors/colors.dart';
import '../../../widgets/responsive_grid.dart';
import '../../../widgets/section_title.dart';
import 'info_item.dart';

class RealEstateTab extends StatelessWidget {
  final LeadModel lead;
  const RealEstateTab({super.key, required this.lead});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            int columns = width > 1000
                ? 3
                : width > 600
                    ? 2
                    : 1;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(
                  title: 'Real Estate Preferences',
                  icon: Icons.home_work_rounded,
                ),
                const SizedBox(height: 16),
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
                        label: 'Property Type',
                        value: lead.propertyType ?? 'N/A',
                        icon: Icons.apartment_rounded,
                        iconColor: AppColors.blueSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Property Use',
                        value: lead.propertyUse ?? 'N/A',
                        icon: Icons.business_center_rounded,
                        iconColor: AppColors.darkOrangeColour,
                      ),
                      InfoItem(
                        label: 'Furnishing Preference',
                        value: lead.furnishingPreference ?? 'N/A',
                        icon: Icons.chair_rounded,
                        iconColor: AppColors.redSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Group Type',
                        value: lead.groupType ?? 'N/A',
                        icon: Icons.group_rounded,
                        iconColor: AppColors.orangeSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Total Peoples',
                        value: lead.totalPeoples?.toString() ?? 'N/A',
                        icon: Icons.people_alt_rounded,
                        iconColor: AppColors.blueSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Loan Required',
                        value: lead.loanRequired == true ? 'Yes' : 'No',
                        icon: Icons.money_rounded,
                        iconColor: AppColors.greenSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Loan Amount Required',
                        value: lead.loanAmountRequired?.toString() ?? 'N/A',
                        icon: Icons.currency_rupee_rounded,
                        iconColor: AppColors.orangeSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Has Existing Loans',
                        value: lead.hasExistingLoans == true ? 'Yes' : 'No',
                        icon: Icons.credit_card_off_rounded,
                        iconColor: AppColors.redSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Credit Score',
                        value: lead.creditScore?.toString() ?? 'N/A',
                        icon: Icons.score_rounded,
                        iconColor: AppColors.greenSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Possession Timeline',
                        value: lead.possessionTimeline ?? 'N/A',
                        icon: Icons.date_range_rounded,
                        iconColor: AppColors.skyBlueSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Requires Legal Assistance',
                        value:
                            lead.requiresLegalAssistance == true ? 'Yes' : 'No',
                        icon: Icons.gavel_rounded,
                        iconColor: AppColors.orangeSecondaryColor,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
            );
          },
        ),
      ),
    );
  }
}

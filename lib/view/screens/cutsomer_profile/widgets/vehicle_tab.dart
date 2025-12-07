import 'package:flutter/material.dart';
import 'package:overseas_front_end/model/lead/lead_model.dart';
import '../../../../utils/style/colors/colors.dart';
import '../../../widgets/responsive_grid.dart';
import '../../../widgets/section_title.dart';
import 'info_item.dart';

class VehicleTab extends StatelessWidget {
  final LeadModel lead;
  const VehicleTab({super.key, required this.lead});

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
                  title: 'Vehicle Preferences',
                  icon: Icons.directions_car_rounded,
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
                        label: 'Vehicle Type',
                        value: lead.vehicleType ?? 'N/A',
                        icon: Icons.directions_car_filled,
                        iconColor: AppColors.blueSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Brand Preference',
                        value: lead.brandPreference ?? 'N/A',
                        icon: Icons.branding_watermark_rounded,
                        iconColor: AppColors.orangeSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Model Preference',
                        value: lead.modelPreference ?? 'N/A',
                        icon: Icons.car_repair_rounded,
                        iconColor: AppColors.greenSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Fuel Type',
                        value: lead.fuelType ?? 'N/A',
                        icon: Icons.local_gas_station_rounded,
                        iconColor: AppColors.darkOrangeColour,
                      ),
                      InfoItem(
                        label: 'Transmission',
                        value: lead.transmission ?? 'N/A',
                        icon: Icons.settings_rounded,
                        iconColor: AppColors.redSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Insurance Type',
                        value: lead.insuranceType ?? 'N/A',
                        icon: Icons.verified_rounded,
                        iconColor: AppColors.skyBlueSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Down Payment Available',
                        value: lead.downPaymentAvailable?.toString() ?? 'N/A',
                        icon: Icons.currency_rupee_rounded,
                        iconColor: AppColors.orangeSecondaryColor,
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
                        iconColor: AppColors.blueSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Has Existing Loans',
                        value: lead.hasExistingLoans == true ? 'Yes' : 'No',
                        icon: Icons.money_off_rounded,
                        iconColor: AppColors.redSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Credit Score',
                        value: lead.creditScore?.toString() ?? 'N/A',
                        icon: Icons.score_rounded,
                        iconColor: AppColors.greenSecondaryColor,
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

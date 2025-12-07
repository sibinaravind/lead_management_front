import 'package:flutter/material.dart';
import 'package:overseas_front_end/model/lead/lead_model.dart';
import '../../../../utils/style/colors/colors.dart';
import '../../../widgets/responsive_grid.dart';
import '../../../widgets/section_title.dart';
import 'info_item.dart';

class TravelTab extends StatelessWidget {
  final LeadModel lead;
  const TravelTab({super.key, required this.lead});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final availableWidth = constraints.maxWidth;
            int columnsCount = availableWidth > 1000
                ? 3
                : availableWidth > 600
                    ? 2
                    : 1;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ---------------------- TRAVEL PREFERENCES ----------------------
                const SectionTitle(
                  title: 'Travel Preferences',
                  icon: Icons.flight_rounded,
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
                    columns: columnsCount,
                    children: [
                      InfoItem(
                        label: 'Travel Purpose',
                        value: lead.travelPurpose ?? 'N/A',
                        icon: Icons.flight,
                        iconColor: AppColors.blueSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Visa Type Required',
                        value: lead.visaTypeRequired ?? 'N/A',
                        icon: Icons.account_balance_rounded,
                        iconColor: AppColors.orangeSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Number of Travelers',
                        value: lead.numberOfTravelers?.toString() ?? 'N/A',
                        icon: Icons.people_alt_rounded,
                        iconColor: AppColors.greenSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Travel Duration (days)',
                        value: lead.travelDuration?.toString() ?? 'N/A',
                        icon: Icons.timer_rounded,
                        iconColor: AppColors.orangeSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Accommodation Preference',
                        value: lead.accommodationPreference ?? 'N/A',
                        icon: Icons.hotel_rounded,
                        iconColor: AppColors.blueSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Countries Interested',
                        value: (lead.countryInterested?.isNotEmpty ?? false)
                            ? lead.countryInterested!.join(', ')
                            : 'N/A',
                        icon: Icons.public_rounded,
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
                        icon: Icons.groups_rounded,
                        iconColor: AppColors.blueSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Preferred Location',
                        value: lead.preferredLocation ?? 'N/A',
                        icon: Icons.location_on_rounded,
                        iconColor: AppColors.greenSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Preferred Date',
                        value: lead.preferredDate ?? 'N/A',
                        icon: Icons.date_range_rounded,
                        iconColor: AppColors.redSecondaryColor,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // ---------------------- TRAVEL SERVICES ----------------------
                const SectionTitle(
                  title: 'Travel Services',
                  icon: Icons.confirmation_number_rounded,
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
                    columns: columnsCount,
                    children: [
                      InfoItem(
                        label: 'Requires Travel Insurance',
                        value:
                            lead.requiresTravelInsurance == true ? 'Yes' : 'No',
                        icon: Icons.security_rounded,
                        iconColor: AppColors.orangeSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Requires Hotel Booking',
                        value: lead.requiresHotelBooking == true ? 'Yes' : 'No',
                        icon: Icons.hotel_rounded,
                        iconColor: AppColors.blueSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Requires Flight Booking',
                        value:
                            lead.requiresFlightBooking == true ? 'Yes' : 'No',
                        icon: Icons.flight_takeoff_rounded,
                        iconColor: AppColors.redSecondaryColor,
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

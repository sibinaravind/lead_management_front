import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:overseas_front_end/model/booking_model/booking_model.dart';
import 'package:overseas_front_end/utils/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/responsive_grid.dart';
import 'package:overseas_front_end/view/widgets/section_title.dart';
import '../../cutsomer_profile/widgets/info_item.dart';

class BookingCustomerTab extends StatelessWidget {
  final BookingModel booking;

  const BookingCustomerTab({super.key, required this.booking});

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return DateFormat('dd MMM yyyy').format(date);
  }

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
                  title: "Customer Information",
                  icon: Icons.person,
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
                        label: 'Customer ID',
                        value: booking.customerId ?? 'N/A',
                        icon: Icons.badge,
                        iconColor: AppColors.blueSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Customer Name',
                        value: booking.customerName ?? 'N/A',
                        icon: Icons.person_outline,
                        iconColor: AppColors.greenSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Phone Number',
                        value: booking.customerPhone ?? 'N/A',
                        icon: Icons.phone,
                        iconColor: AppColors.orangeSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Address',
                        value: booking.customerAddress ?? 'N/A',
                        icon: Icons.location_on,
                        iconColor: AppColors.redSecondaryColor,
                      ),
                    ],
                  ),
                ),
                if (booking.coApplicantList != null &&
                    booking.coApplicantList!.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  const SectionTitle(
                    title: "Co-Applicants",
                    icon: Icons.group,
                  ),
                  const SizedBox(height: 12),
                  ...booking.coApplicantList!.asMap().entries.map((entry) {
                    final index = entry.key;
                    final applicant = entry.value;
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
                                  Icons.person_add,
                                  color: AppColors.primaryColor,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Co-Applicant ${index + 1}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 24),
                          ResponsiveGrid(
                            columns: columns,
                            children: [
                              InfoItem(
                                label: 'Name',
                                value: applicant.name ?? 'N/A',
                                icon: Icons.person_outline,
                                iconColor: AppColors.blueSecondaryColor,
                              ),
                              InfoItem(
                                label: 'Phone',
                                value: applicant.phone ?? 'N/A',
                                icon: Icons.phone,
                                iconColor: AppColors.greenSecondaryColor,
                              ),
                              InfoItem(
                                label: 'Email',
                                value: applicant.email ?? 'N/A',
                                icon: Icons.email,
                                iconColor: AppColors.orangeSecondaryColor,
                              ),
                              InfoItem(
                                label: 'Date of Birth',
                                value: _formatDate(applicant.dob),
                                icon: Icons.cake,
                                iconColor: AppColors.viloletSecondaryColor,
                              ),
                            ],
                          ),
                          if (applicant.address != null &&
                              applicant.address!.isNotEmpty) ...[
                            const SizedBox(height: 12),
                            InfoItem(
                              label: 'Address',
                              value: applicant.address!,
                              icon: Icons.location_on,
                              iconColor: AppColors.redSecondaryColor,
                            ),
                          ],
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

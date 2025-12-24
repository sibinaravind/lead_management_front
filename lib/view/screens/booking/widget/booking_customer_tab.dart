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
                  title: "Booking Details",
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
                      if (booking.courseName != null &&
                          (booking.courseName?.isNotEmpty ?? false))
                        InfoItem(
                          label: 'Course Name',
                          value: booking.courseName ?? 'N/A',
                          icon: Icons.school,
                          iconColor: AppColors.blueSecondaryColor,
                        ),
                      if (booking.institutionName != null &&
                          (booking.institutionName?.isNotEmpty ?? false))
                        InfoItem(
                          label: 'Institution Name',
                          value: booking.institutionName ?? 'N/A',
                          icon: Icons.account_balance,
                          iconColor: AppColors.greenSecondaryColor,
                        ),
                      if (booking.countryApplyingFor != null &&
                          (booking.countryApplyingFor?.isNotEmpty ?? false))
                        InfoItem(
                          label: 'Country Applying For',
                          value: booking.countryApplyingFor ?? 'N/A',
                          icon: Icons.flag,
                          iconColor: AppColors.viloletSecondaryColor,
                        ),
                      if (booking.visaType != null &&
                          (booking.visaType?.isNotEmpty ?? false))
                        InfoItem(
                          label: 'Visa Type',
                          value: booking.visaType ?? 'N/A',
                          icon: Icons.assignment_turned_in,
                          iconColor: AppColors.blueSecondaryColor,
                        ),
                      if (booking.origin != null &&
                          (booking.origin?.isNotEmpty ?? false))
                        InfoItem(
                          label: 'Origin',
                          value: booking.origin ?? 'N/A',
                          icon: Icons.flight_takeoff,
                          iconColor: AppColors.greenSecondaryColor,
                        ),
                      if (booking.destination != null &&
                          (booking.destination?.isNotEmpty ?? false))
                        InfoItem(
                          label: 'Destination',
                          value: booking.destination ?? 'N/A',
                          icon: Icons.flight_land,
                          iconColor: AppColors.orangeSecondaryColor,
                        ),
                      if (booking.returnDate != null)
                        InfoItem(
                          label: 'Return Date',
                          value: _formatDate(booking.returnDate),
                          icon: Icons.calendar_today,
                          iconColor: AppColors.redSecondaryColor,
                        ),
                      if (booking.noOfTravellers != null &&
                          (booking.noOfTravellers ?? 0) > 0)
                        InfoItem(
                          label: 'Number of Travellers',
                          value: booking.noOfTravellers?.toString() ?? 'N/A',
                          icon: Icons.people,
                          iconColor: AppColors.viloletSecondaryColor,
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
                              if (applicant.address != null &&
                                  applicant.address!.isNotEmpty) ...[
                                InfoItem(
                                  label: 'Address',
                                  value: applicant.address!,
                                  icon: Icons.location_on,
                                  iconColor: AppColors.redSecondaryColor,
                                ),
                              ],
                              if (applicant.idCardType != null &&
                                  (applicant.idCardType?.isNotEmpty ??
                                      false)) ...[
                                InfoItem(
                                  label: ' ID Card Type',
                                  value: applicant.idCardType ?? 'N/A',
                                  icon: Icons.badge,
                                  iconColor: AppColors.offWhiteColour,
                                ),
                              ],
                              if (applicant.idCardNumber != null &&
                                  (applicant.idCardNumber?.isNotEmpty ??
                                      false)) ...[
                                InfoItem(
                                  label: ' ID Card Number',
                                  value: applicant.idCardNumber ?? 'N/A',
                                  icon: Icons.confirmation_number,
                                  iconColor: AppColors.blueSecondaryColor,
                                ),
                              ],
                            ],
                          ),
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

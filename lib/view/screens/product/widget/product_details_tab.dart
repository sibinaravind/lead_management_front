import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../model/product/product_model.dart';
import '../../../../utils/style/colors/colors.dart';
import '../../../widgets/responsive_grid.dart';
import '../../../widgets/section_title.dart';
import '../../cutsomer_profile/widgets/info_item.dart';
import '../../cutsomer_profile/widgets/info_section.dart';

class ProductCategoryDetailsDisplayTab extends StatelessWidget {
  final ProductModel product;
  const ProductCategoryDetailsDisplayTab({super.key, required this.product});

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
              // ---------------- TRAVEL ----------------
              // if (product.category == 'TRAVEL') ...[
              const SectionTitle(
                title: 'Travel Details',
                icon: Icons.flight_rounded,
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
                      label: 'Travel Type',
                      value: product.travelType ?? 'N/A',
                      icon: Icons.airplane_ticket_rounded,
                      iconColor: AppColors.orangeSecondaryColor,
                    ),
                    InfoItem(
                      label: 'Duration',
                      value: product.duration ?? 'N/A',
                      icon: Icons.timelapse_rounded,
                      iconColor: AppColors.blueSecondaryColor,
                    ),
                    InfoItem(
                      label: 'Visa Type',
                      value: product.visaType ?? 'N/A',
                      icon: Icons.assignment_rounded,
                      iconColor: AppColors.greenSecondaryColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // ],
              // if (product.category == 'EDUCATION') ...[
              const SectionTitle(
                title: 'Education Details',
                icon: Icons.school_rounded,
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
                      label: 'Course Duration',
                      value: product.courseDuration ?? 'N/A',
                      icon: Icons.schedule_rounded,
                      iconColor: AppColors.orangeSecondaryColor,
                    ),
                    InfoItem(
                      label: 'Course Level',
                      value: product.courseLevel ?? 'N/A',
                      icon: Icons.grade_rounded,
                      iconColor: AppColors.blueSecondaryColor,
                    ),
                    InfoItem(
                      label: 'Institution Name',
                      value: product.institutionName ?? 'N/A',
                      icon: Icons.account_balance_rounded,
                      iconColor: AppColors.greenSecondaryColor,
                    ),
                    // InfoItem(
                    //   label: 'Intake',
                    //   value: product.in ?? 'N/A',
                    //   icon: Icons.calendar_month_rounded,
                    //   iconColor: AppColors.viloletSecondaryColor,
                    // ),
                    InfoItem(
                      label: 'Mode of Study',
                      value: product.serviceMode ?? 'N/A',
                      icon: Icons.laptop_mac_rounded,
                      iconColor: AppColors.redSecondaryColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // ],

              // if (product.category == 'VEHICLE') ...[
              const SectionTitle(
                title: 'Vehicle Details',
                icon: Icons.directions_car_rounded,
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
                      label: 'Brand',
                      value: product.brand ?? 'N/A',
                      icon: Icons.car_rental_rounded,
                      iconColor: AppColors.orangeSecondaryColor,
                    ),
                    InfoItem(
                      label: 'Model',
                      value: product.model ?? 'N/A',
                      icon: Icons.directions_car_filled_rounded,
                      iconColor: AppColors.blueSecondaryColor,
                    ),
                    InfoItem(
                      label: 'Fuel Type',
                      value: product.fuelType ?? 'N/A',
                      icon: Icons.local_gas_station_rounded,
                      iconColor: AppColors.greenSecondaryColor,
                    ),
                    InfoItem(
                      label: 'Transmission',
                      value: product.transmission ?? 'N/A',
                      icon: Icons.settings_rounded,
                      iconColor: AppColors.viloletSecondaryColor,
                    ),
                    InfoItem(
                      label: 'Registration Year',
                      value: product.registrationYear ?? 'N/A',
                      icon: Icons.event_rounded,
                      iconColor: AppColors.redSecondaryColor,
                    ),
                    InfoItem(
                      label: 'KMs Driven',
                      value: product.kmsDriven?.toString() ?? 'N/A',
                      icon: Icons.speed_rounded,
                      iconColor: AppColors.blueSecondaryColor,
                    ),
                    InfoItem(
                      label: 'Insurance Valid Till',
                      value: product.insuranceValidTill ?? 'N/A',
                      icon: Icons.security_rounded,
                      iconColor: AppColors.greenSecondaryColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
// ],
// if (product.category == 'REAL_ESTATE') ...[
              const SectionTitle(
                title: 'Property Details',
                icon: Icons.home_work_rounded,
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
                      label: 'Property Type',
                      value: product.propertyType ?? 'N/A',
                      icon: Icons.apartment_rounded,
                      iconColor: AppColors.orangeSecondaryColor,
                    ),
                    InfoItem(
                      label: 'Size',
                      value: product.size ?? 'N/A',
                      icon: Icons.square_foot_rounded,
                      iconColor: AppColors.blueSecondaryColor,
                    ),
                    InfoItem(
                      label: 'BHK',
                      value: product.bhk ?? 'N/A',
                      icon: Icons.meeting_room_rounded,
                      iconColor: AppColors.greenSecondaryColor,
                    ),
                    InfoItem(
                      label: 'Location',
                      value: product.location ?? 'N/A',
                      icon: Icons.location_on_rounded,
                      iconColor: AppColors.viloletSecondaryColor,
                    ),
                    InfoItem(
                      label: 'Possession Time',
                      value: product.possessionTime ?? 'N/A',
                      icon: Icons.event_available_rounded,
                      iconColor: AppColors.redSecondaryColor,
                    ),
                    InfoItem(
                      label: 'Furnishing Status',
                      value: product.furnishingStatus ?? 'N/A',
                      icon: Icons.chair_rounded,
                      iconColor: AppColors.blueSecondaryColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
// ],

              // ---------------- LOCATION ----------------
              const SectionTitle(
                title: 'Location',
                icon: Icons.location_on_rounded,
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
                      label: 'Country',
                      value: product.country ?? 'N/A',
                      icon: Icons.flag_rounded,
                      iconColor: AppColors.orangeSecondaryColor,
                    ),
                    InfoItem(
                      label: 'State',
                      value: product.state ?? 'N/A',
                      icon: Icons.map_rounded,
                      iconColor: AppColors.blueSecondaryColor,
                    ),
                    InfoItem(
                      label: 'City',
                      value: product.city ?? 'N/A',
                      icon: Icons.location_city_rounded,
                      iconColor: AppColors.greenSecondaryColor,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ---------------- VALIDITY ----------------
              const SectionTitle(
                title: 'Validity & Processing Time',
                icon: Icons.list_alt_rounded,
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
                      label: 'Validity',
                      value: product.validity ?? 'N/A',
                      icon: Icons.event_available_rounded,
                      iconColor: AppColors.orangeSecondaryColor,
                    ),
                    InfoItem(
                      label: 'Processing Time',
                      value: product.processingTime ?? 'N/A',
                      icon: Icons.hourglass_bottom_rounded,
                      iconColor: AppColors.blueSecondaryColor,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ---------------- INCLUSIONS / EXCLUSIONS ----------------
              if ((product.inclusions?.isNotEmpty ?? false) ||
                  (product.exclusions?.isNotEmpty ?? false))
                InfoSection(
                  title: 'Inclusions & Exclusions',
                  icon: Icons.list_alt_rounded,
                  items: [
                    if (product.inclusions?.isNotEmpty ?? false)
                      InfoItem(
                        label: 'Inclusions',
                        value: product.inclusions!.join(', '),
                        icon: Icons.check_circle_rounded,
                        iconColor: AppColors.greenSecondaryColor,
                      ),
                    if (product.exclusions?.isNotEmpty ?? false)
                      InfoItem(
                        label: 'Exclusions',
                        value: product.exclusions!.join(', '),
                        icon: Icons.cancel_rounded,
                        iconColor: AppColors.redSecondaryColor,
                      ),
                  ],
                ),

              const SizedBox(height: 20),
              const SectionTitle(
                title: "Support & Warranty",
                icon: Icons.store,
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
                      label: 'Support Available',
                      value: product.supportAvailable?.toString() ?? 'N/A',
                      icon: Icons.person,
                      iconColor: AppColors.orangeSecondaryColor,
                    ),
                    InfoItem(
                      label: 'Support Duration',
                      value: product.supportDuration?.toString() ?? 'N/A',
                      icon: Icons.phone,
                      iconColor: AppColors.greenSecondaryColor,
                    ),
                    InfoItem(
                      label: 'Warranty Information',
                      value: product.warrantyInfo?.toString() ?? 'N/A',
                      icon: Icons.email,
                      iconColor: AppColors.blueSecondaryColor,
                    ),
                  ],
                ),
              ),

              if (product.isRefundable == true &&
                  product.refundPolicy != null) ...[
                const SizedBox(height: 20),
                InfoSection(
                  title: 'Refund Policy',
                  icon: Icons.policy_rounded,
                  items: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        product.refundPolicy!,
                        style: const TextStyle(height: 1.5),
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 28),

                /// TAGS & CLASSIFICATION
                const SectionTitle(
                  title: 'Tags & Classification',
                  icon: Icons.sell_rounded,
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
                    children: (product.tags ?? []).isNotEmpty
                        ? product.tags!
                            .map(
                              (tag) => Chip(
                                label: Text(tag),
                                backgroundColor: AppColors.greenSecondaryColor
                                    .withOpacity(0.12),
                                labelStyle: const TextStyle(fontSize: 13),
                              ),
                            )
                            .toList()
                        : [],
                  ),
                ),
                const SizedBox(height: 28),

                /// TERMS & CONDITIONS
              ],
            ],
          );
        }),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:overseas_front_end/model/booking_model/booking_model.dart';
import 'package:overseas_front_end/utils/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/responsive_grid.dart';
import 'package:overseas_front_end/view/widgets/section_title.dart';
import '../../cutsomer_profile/widgets/info_item.dart';

class BookingBasicInfoTab extends StatelessWidget {
  final BookingModel booking;

  const BookingBasicInfoTab({super.key, required this.booking});

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
                  title: "Product Information",
                  icon: Icons.shopping_bag,
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
                        label: 'Product ID',
                        value: booking.productAppId ?? 'N/A',
                        icon: Icons.qr_code,
                        iconColor: AppColors.blueSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Product Name',
                        value: booking.productName ?? 'N/A',
                        icon: Icons.card_giftcard,
                        iconColor: AppColors.orangeSecondaryColor,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const SectionTitle(
                  title: "Booking Information",
                  icon: Icons.book_online,
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
                        label: 'Booking Date',
                        value: _formatDate(booking.bookingDate),
                        icon: Icons.calendar_today,
                        iconColor: AppColors.greenSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Status',
                        value: booking.status ?? 'Active',
                        icon: Icons.toggle_on,
                        iconColor: AppColors.greenSecondaryColor,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Column(
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
                        border:
                            Border.all(color: Colors.grey.shade300, width: 0.8),
                      ),
                      child: ResponsiveGrid(
                        columns: columns,
                        children: [
                          InfoItem(
                            label: 'Customer ID',
                            value: booking.customerAppId ?? 'N/A',
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
                  ],
                ),
                if (booking.notes != null && booking.notes!.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  const SectionTitle(
                    title: "Notes",
                    icon: Icons.note_outlined,
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border:
                          Border.all(color: Colors.grey.shade300, width: 0.8),
                    ),
                    child: InfoItem(
                      label: 'Additional Notes',
                      value: booking.notes!,
                      icon: Icons.notes,
                      iconColor: AppColors.viloletSecondaryColor,
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

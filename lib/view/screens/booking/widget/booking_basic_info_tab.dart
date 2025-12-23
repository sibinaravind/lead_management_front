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
                        label: 'Booking ID',
                        value: booking.id ?? 'N/A',
                        icon: Icons.fingerprint,
                        iconColor: AppColors.blueSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Booking Date',
                        value: _formatDate(booking.bookingDate),
                        icon: Icons.calendar_today,
                        iconColor: AppColors.greenSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Expected Closure',
                        value: _formatDate(booking.expectedClosureDate),
                        icon: Icons.event_available,
                        iconColor: AppColors.orangeSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Status',
                        value: booking.status ?? 'Active',
                        icon: Icons.toggle_on,
                        iconColor: AppColors.greenSecondaryColor,
                      ),
                      InfoItem(
                        label: 'Officer ID',
                        value: booking.officerId ?? 'N/A',
                        icon: Icons.person_pin,
                        iconColor: AppColors.viloletSecondaryColor,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
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
                        value: booking.productId ?? 'N/A',
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

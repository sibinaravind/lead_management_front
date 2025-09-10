import 'package:flutter/material.dart';
import 'package:overseas_front_end/model/lead/travel_record_model.dart';
import 'package:overseas_front_end/utils/functions/format_date.dart';

import '../../../widgets/custom_text.dart';
import 'info_item_card.dart';

class TravelRecordsTab extends StatelessWidget {
  final List<TravelRecordModel> records;

  const TravelRecordsTab({super.key, required this.records});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: 'Travel History',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF202124),
          ),
          const SizedBox(height: 16),
          ...records.map((record) => _buildTravelCard(record)).toList(),
        ],
      ),
    );
  }

  Widget _buildTravelCard(TravelRecordModel record) {
    final isActive = record.returnDate == null ||
        (record.returnDate != null &&
            record.returnDate!.isAfter(DateTime.now()));

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isActive
              ? const Color(0xFF34A853).withOpacity(0.3)
              : Colors.transparent,
          width: isActive ? 2 : 0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF9C27B0).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.flight_takeoff,
                  color: Color(0xFF9C27B0),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomText(
                  text: record.country ?? 'N/A',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF202124),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(0xFF34A853).withOpacity(0.1)
                      : const Color(0xFF5F6368).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isActive
                        ? const Color(0xFF34A853).withOpacity(0.3)
                        : const Color(0xFF5F6368).withOpacity(0.3),
                  ),
                ),
                child: CustomText(
                  text: isActive ? 'Active' : 'Completed',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isActive
                      ? const Color(0xFF34A853)
                      : const Color(0xFF5F6368),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 20,
            runSpacing: 12,
            children: [
              InfoItemCard(
                label: 'Visa Type',
                value: record.visaType ?? 'N/A',
                icon: Icons.card_travel,
                accentColor: const Color(0xFF3B82F6),
              ),
              InfoItemCard(
                label: 'Departure',
                value: formatDatetoString(record.departureDate),
                icon: Icons.flight_takeoff,
                accentColor: const Color(0xFF3B82F6),
              ),
              InfoItemCard(
                label: 'Return',
                value: record.returnDate != null
                    ? formatDatetoString(record.returnDate)
                    : 'Currently there',
                icon: Icons.flight_land,
                accentColor: const Color(0xFF3B82F6),
              ),
              InfoItemCard(
                label: 'Visa Valid Until',
                value: formatDatetoString(record.visaValidDate),
                icon: Icons.event_available,
                accentColor: const Color(0xFF3B82F6),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

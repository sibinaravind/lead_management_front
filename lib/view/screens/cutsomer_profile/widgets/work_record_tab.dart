import 'package:flutter/material.dart';
import 'package:overseas_front_end/model/lead/work_record_model.dart';
import 'package:overseas_front_end/utils/functions/format_date.dart';
import 'package:overseas_front_end/view/screens/cutsomer_profile/widgets/info_item_card.dart';
import 'package:overseas_front_end/view/screens/registration/tabs/work_experience_tab.dart';

import '../../../widgets/custom_text.dart';

class WorkRecordsTab extends StatelessWidget {
  final List<WorkRecordModel> records;
  final String? firstJobDate;
  final int? jobGapMonths;

  const WorkRecordsTab({
    super.key,
    required this.records,
    this.firstJobDate,
    this.jobGapMonths,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(
                text: 'Work Experience',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF202124),
              ),
              if (jobGapMonths != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF9800).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: const Color(0xFFFF9800).withOpacity(0.3)),
                  ),
                  child: CustomText(
                    text: 'Gap: ${jobGapMonths!} months',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFFF9800),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          if (firstJobDate != null) ...[
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF1976D2).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border:
                    Border.all(color: const Color(0xFF1976D2).withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.work_history,
                      color: Color(0xFF1976D2), size: 20),
                  const SizedBox(width: 8),
                  CustomText(
                    text: 'First Job Date: $firstJobDate',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1976D2),
                  ),
                ],
              ),
            ),
          ],
          ...records.map((record) => _buildWorkCard(record)).toList(),
        ],
      ),
    );
  }

  Widget _buildWorkCard(WorkRecordModel record) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
                  color: const Color(0xFF34A853).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.work,
                  color: Color(0xFF34A853),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: record.position ?? 'N/A',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF202124),
                    ),
                    CustomText(
                      text: record.organization ?? 'N/A',
                      fontSize: 14,
                      color: const Color(0xFF5F6368),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF1976D2).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomText(
                  text: record.country ?? 'N/A',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1976D2),
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
                label: 'Department',
                value: record.department ?? 'N/A',
                icon: Icons.apartment,
                accentColor: const Color(0xFF3B82F6),
              ),
              InfoItemCard(
                label: 'Duration',
                value:
                    '${formatDatetoString(record.fromDate)} - ${formatDatetoString(record.toDate)}',
                icon: Icons.access_time,
                accentColor: const Color(0xFF3B82F6),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

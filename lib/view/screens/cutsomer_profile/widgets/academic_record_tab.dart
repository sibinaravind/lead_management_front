import 'package:flutter/material.dart';

import '../../../../model/lead/academic_record_model.dart';
import '../../../widgets/custom_text.dart';
import 'info_item_card.dart';

class AcademicRecordsTab extends StatelessWidget {
  final List<AcademicRecordModel> records;

  const AcademicRecordsTab({super.key, required this.records});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: 'Academic Records',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF202124),
            ),
            const SizedBox(height: 16),
            ...records.map((record) => _buildAcademicCard(record)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildAcademicCard(AcademicRecordModel record) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16, left: 10, right: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
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
                  color: const Color(0xFF1976D2).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.school,
                  color: Color(0xFF1976D2),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomText(
                  text: record.qualification ?? 'N/A',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF202124),
                ),
              ),
              if (record.grade != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF34A853).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: const Color(0xFF34A853).withOpacity(0.3)),
                  ),
                  child: CustomText(
                    text: 'Grade ${record.grade}',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF34A853),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(spacing: 20, runSpacing: 12, children: [
            InfoItemCard(
              label: 'Institution',
              value: record.institution ?? 'N/A',
              icon: Icons.account_balance,
              accentColor: const Color(0xFF3B82F6),
            ),
            InfoItemCard(
              label: 'University',
              value: record.university ?? 'N/A',
              icon: Icons.school,
              accentColor: const Color(0xFF3B82F6),
            ),
            InfoItemCard(
              label: 'Duration',
              value:
                  '${record.startYear ?? 'N/A'} - ${record.endYear ?? 'N/A'}',
              icon: Icons.access_time,
              accentColor: const Color(0xFF3B82F6),
            ),
            InfoItemCard(
              label: 'Percentage',
              value:
                  record.percentage != null ? '${record.percentage}%' : 'N/A',
              icon: Icons.pie_chart,
              accentColor: const Color(0xFF3B82F6),
            ),
          ]),
        ],
      ),
    );
  }
}

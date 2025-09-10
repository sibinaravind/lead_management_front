import 'package:flutter/material.dart';
import 'package:overseas_front_end/model/lead/exam_record_model.dart';
import 'package:overseas_front_end/utils/functions/format_date.dart';
import 'package:overseas_front_end/view/screens/cutsomer_profile/widgets/info_item_card.dart';

import '../../../widgets/custom_text.dart';

class ExamRecordsTab extends StatelessWidget {
  final List<ExamRecordModel> records;

  const ExamRecordsTab({super.key, required this.records});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: 'Exam Records',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF202124),
            ),
            const SizedBox(height: 16),
            ...records.map((record) => _buildExamCard(record)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildExamCard(ExamRecordModel record) {
    final isPassed = record.status?.toString().toUpperCase() == 'PASS';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isPassed
              ? const Color(0xFF34A853).withOpacity(0.3)
              : const Color(0xFFEA4335).withOpacity(0.3),
          width: 1,
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
                  color: const Color(0xFFFF9800).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.quiz,
                  color: Color(0xFFFF9800),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomText(
                  text: record.exam ?? 'N/A',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF202124),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: isPassed
                      ? const Color(0xFF34A853).withOpacity(0.1)
                      : const Color(0xFFEA4335).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CustomText(
                  text: record.status ?? 'N/A',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isPassed
                      ? const Color(0xFF34A853)
                      : const Color(0xFFEA4335),
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
                label: 'Exam Type',
                value: record.exam ?? 'N/A',
                icon: Icons.pie_chart,
                accentColor: const Color(0xFF3B82F6),
              ),
              InfoItemCard(
                label: 'Grade',
                value: record.grade ?? 'N/A',
                icon: Icons.grade,
                accentColor: const Color(0xFF3B82F6),
              ),
              InfoItemCard(
                label: 'Score',
                value: record.score?.toString() ?? 'N/A',
                icon: Icons.score,
                accentColor: const Color(0xFF3B82F6),
              ),
              InfoItemCard(
                label: 'Exam Date',
                value: formatDatetoString(record.examDate),
                icon: Icons.calendar_today,
                accentColor: const Color(0xFF3B82F6),
              ),
              InfoItemCard(
                label: 'Valid Until',
                value: formatDatetoString(record.validityDate),
                icon: Icons.event_available,
                accentColor: const Color(0xFF3B82F6),
              ),
            ],
          )
        ],
      ),
    );
  }
}

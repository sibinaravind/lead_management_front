import 'package:flutter/material.dart';

import '../../../widgets/custom_text.dart';

class ExamRecordsTab extends StatelessWidget {
  final List<dynamic> records;

  const ExamRecordsTab({super.key, required this.records});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
    );
  }

  Widget _buildExamCard(dynamic record) {
    final isPassed = record['status']?.toString().toUpperCase() == 'PASS';

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
                  text: record['exam'] ?? 'N/A',
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
                  text: record['status'] ?? 'N/A',
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
          _buildInfoGrid([
            {'label': 'Grade', 'value': record['grade'] ?? 'N/A'},
            {'label': 'Score', 'value': record['score']?.toString() ?? 'N/A'},
            {'label': 'Exam Date', 'value': _formatDate(record['exam_date'])},
            {
              'label': 'Valid Until',
              'value': _formatDate(record['validity_date'])
            },
          ]),
        ],
      ),
    );
  }

  Widget _buildInfoGrid(List<Map<String, String>> items) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 2.5,
      crossAxisSpacing: 16,
      mainAxisSpacing: 8,
      children: items
          .map((item) => _buildInfoItem(item['label']!, item['value']!))
          .toList(),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: label,
          fontSize: 12,
          color: const Color(0xFF5F6368),
        ),
        const SizedBox(height: 4),
        CustomText(
          text: value,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF202124),
          maxLines: 1,
        ),
      ],
    );
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return 'N/A';
    try {
      final date = DateTime.parse(dateStr);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateStr;
    }
  }
}

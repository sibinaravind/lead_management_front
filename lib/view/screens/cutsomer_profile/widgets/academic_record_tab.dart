import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../widgets/custom_text.dart';

class AcademicRecordsTab extends StatelessWidget {
  final List<dynamic> records;

  const AcademicRecordsTab({super.key, required this.records});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
    );
  }

  Widget _buildAcademicCard(dynamic record) {
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
                  text: record['qualification'] ?? 'N/A',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF202124),
                ),
              ),
              if (record['grade'] != null)
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
                    text: 'Grade ${record['grade']}',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF34A853),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoGrid([
            {'label': 'Institution', 'value': record['institution'] ?? 'N/A'},
            {'label': 'University', 'value': record['university'] ?? 'N/A'},
            {
              'label': 'Duration',
              'value':
                  '${record['start_year'] ?? 'N/A'} - ${record['end_year'] ?? 'N/A'}'
            },
            {
              'label': 'Percentage',
              'value': record['percentage'] != null
                  ? '${record['percentage']}%'
                  : 'N/A'
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
      childAspectRatio: 3,
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
}

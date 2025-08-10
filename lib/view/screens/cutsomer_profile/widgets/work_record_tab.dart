import 'package:flutter/material.dart';

import '../../../widgets/custom_text.dart';

class WorkRecordsTab extends StatelessWidget {
  final List<dynamic> records;
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
                    text: 'First Job Date: ${_formatDate(firstJobDate!)}',
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

  Widget _buildWorkCard(dynamic record) {
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
                      text: record['position'] ?? 'N/A',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF202124),
                    ),
                    CustomText(
                      text: record['organization'] ?? 'N/A',
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
                  text: record['country'] ?? 'N/A',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1976D2),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoGrid([
            {'label': 'Department', 'value': record['department'] ?? 'N/A'},
            {
              'label': 'Duration',
              'value':
                  '${_formatDate(record['from_date'])} - ${_formatDate(record['to_date'])}'
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
      crossAxisCount: 1,
      childAspectRatio: 6,
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

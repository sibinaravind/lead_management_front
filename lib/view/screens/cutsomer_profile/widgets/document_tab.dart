import 'package:flutter/material.dart';

import '../../../widgets/custom_text.dart';

class DocumentsTab extends StatelessWidget {
  final List<dynamic> documents;

  const DocumentsTab({super.key, required this.documents});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: 'Documents',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF202124),
          ),
          const SizedBox(height: 16),
          ...documents.map((doc) => _buildDocumentCard(doc)).toList(),
        ],
      ),
    );
  }

  Widget _buildDocumentCard(dynamic document) {
    final hasFile = document['file_path'] != null;
    final isRequired = document['required'] == true;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: hasFile
              ? const Color(0xFF34A853).withOpacity(0.3)
              : isRequired
                  ? const Color(0xFFEA4335).withOpacity(0.3)
                  : const Color(0xFF5F6368).withOpacity(0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: hasFile
                  ? const Color(0xFF34A853).withOpacity(0.1)
                  : isRequired
                      ? const Color(0xFFEA4335).withOpacity(0.1)
                      : const Color(0xFF5F6368).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              hasFile ? Icons.check_circle : Icons.description,
              color: hasFile
                  ? const Color(0xFF34A853)
                  : isRequired
                      ? const Color(0xFFEA4335)
                      : const Color(0xFF5F6368),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: document['doc_type']?.toString().toUpperCase() ?? 'N/A',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF202124),
                ),
                if (document['uploaded_at'] != null)
                  CustomText(
                    text: 'Uploaded: ${_formatDate(document['uploaded_at'])}',
                    fontSize: 12,
                    color: const Color(0xFF5F6368),
                  ),
              ],
            ),
          ),
          Row(
            children: [
              if (isRequired)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEA4335).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const CustomText(
                    text: 'Required',
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFEA4335),
                  ),
                ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: hasFile
                      ? const Color(0xFF34A853).withOpacity(0.1)
                      : const Color(0xFF5F6368).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomText(
                  text: hasFile ? 'Uploaded' : 'Missing',
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: hasFile
                      ? const Color(0xFF34A853)
                      : const Color(0xFF5F6368),
                ),
              ),
            ],
          ),
        ],
      ),
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

import 'package:flutter/material.dart';
import 'package:overseas_front_end/utils/functions/format_date.dart';

import '../../../../core/shared/constants.dart';
import '../../../../model/lead/document_record_model.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/view_doc_widget.dart';

class DocumentsTab extends StatelessWidget {
  final List<DocumentRecordModel> documents;

  const DocumentsTab({super.key, required this.documents});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
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
            ...documents
                .map((doc) => _buildDocumentCard(doc, context))
                .toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentCard(
      DocumentRecordModel document, BuildContext context) {
    final hasFile = document.filePath != null;
    final isRequired = document.required == true;

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
                  text: document.docType?.toString().toUpperCase() ?? 'N/A',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF202124),
                ),
                if (document.uploadedAt != null)
                  CustomText(
                    text:
                        'Uploaded: ${formatDatetoString(document.uploadedAt)}',
                    fontSize: 12,
                    color: const Color(0xFF5F6368),
                  ),
              ],
            ),
          ),
          Row(
            children: [
              // if (isRequired)
              //   Container(
              //     padding:
              //         const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              //     decoration: BoxDecoration(
              //       color: const Color(0xFFEA4335).withOpacity(0.1),
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //     child: const CustomText(
              //       text: 'Required',
              //       fontSize: 10,
              //       fontWeight: FontWeight.w500,
              //       color: Color(0xFFEA4335),
              //     ),
              //   ),
              // const SizedBox(width: 8),
              GestureDetector(
                onTap: hasFile
                    ? () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            contentPadding: const EdgeInsets.all(0),
                            content: ViewDocWidget(
                              fileUrl: Constant().featureBaseUrl +
                                  document.filePath!,
                              fileName: document.docType ?? 'Unknown',
                            ),
                          ),
                        );
                      }
                    : null,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: hasFile
                        ? const Color(0xFF34A853).withOpacity(0.1)
                        : const Color(0xFF5F6368).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CustomText(
                    text: 'view',
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: hasFile
                        ? const Color(0xFF34A853)
                        : const Color(0xFF5F6368),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

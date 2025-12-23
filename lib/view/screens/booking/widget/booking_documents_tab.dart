// widget/booking_documents_tab.dart
import 'package:flutter/material.dart';
import 'package:overseas_front_end/model/booking_model/booking_model.dart';
import 'package:overseas_front_end/utils/style/colors/colors.dart';
import 'package:overseas_front_end/view/widgets/section_title.dart';

class BookingDocumentsTab extends StatelessWidget {
  final BookingModel booking;

  const BookingDocumentsTab({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    // Mock document data - Replace with actual document list from your model
    final documents = <Map<String, dynamic>>[
      {
        'name': 'Passport Copy',
        'status': 'Uploaded',
        'uploadedDate': DateTime(2025, 1, 15),
        'type': 'PDF',
        'size': '2.5 MB',
      },
      {
        'name': 'Visa Application',
        'status': 'Pending',
        'uploadedDate': null,
        'type': 'PDF',
        'size': null,
      },
      {
        'name': 'Travel Insurance',
        'status': 'Uploaded',
        'uploadedDate': DateTime(2025, 1, 18),
        'type': 'PDF',
        'size': '1.8 MB',
      },
      {
        'name': 'Flight Tickets',
        'status': 'Pending',
        'uploadedDate': null,
        'type': 'PDF',
        'size': null,
      },
    ];

    return Align(
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Document Status Overview
            Row(
              children: [
                Expanded(
                  child: _buildStatusCard(
                    'Total Documents',
                    documents.length.toString(),
                    Icons.folder,
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatusCard(
                    'Uploaded',
                    documents
                        .where((doc) => doc['status'] == 'Uploaded')
                        .length
                        .toString(),
                    Icons.check_circle,
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatusCard(
                    'Pending',
                    documents
                        .where((doc) => doc['status'] == 'Pending')
                        .length
                        .toString(),
                    Icons.pending,
                    Colors.orange,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Documents List
            const SectionTitle(
              title: "Required Documents",
              icon: Icons.description_outlined,
            ),
            const SizedBox(height: 12),

            ...documents
                .map((doc) => _buildDocumentCard(context, doc))
                .toList(),

            const SizedBox(height: 24),

            // Upload Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.blue.shade200, width: 1),
              ),
              child: Column(
                children: [
                  Icon(Icons.cloud_upload,
                      size: 48, color: Colors.blue.shade700),
                  const SizedBox(height: 12),
                  Text(
                    'Upload New Document',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Click below to upload additional documents',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.blue.shade700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Implement file upload
                    },
                    icon: const Icon(Icons.upload_file),
                    label: const Text('Choose File'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Notes Section
            const SectionTitle(
              title: "Document Notes",
              icon: Icons.note_outlined,
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey.shade300, width: 0.8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline,
                          color: AppColors.blueSecondaryColor, size: 20),
                      const SizedBox(width: 8),
                      const Text(
                        'Important Information',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '• All documents must be in PDF format\n'
                    '• Maximum file size: 5MB per document\n'
                    '• Documents should be clear and legible\n'
                    '• Ensure all information is visible',
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.8,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(
      String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3), width: 1.5),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentCard(BuildContext context, Map<String, dynamic> doc) {
    final isUploaded = doc['status'] == 'Uploaded';
    final statusColor = isUploaded ? Colors.green : Colors.orange;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isUploaded ? Colors.green.shade200 : Colors.orange.shade200,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              isUploaded ? Icons.description : Icons.upload_file,
              color: statusColor,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doc['name'],
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        doc['status'],
                        style: TextStyle(
                          fontSize: 11,
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (doc['size'] != null) ...[
                      const SizedBox(width: 8),
                      Text(
                        '${doc['type']} • ${doc['size']}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ],
                ),
                if (doc['uploadedDate'] != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'Uploaded: ${_formatDate(doc['uploadedDate'])}',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (isUploaded)
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.visibility,
                      color: Colors.blue.shade700, size: 20),
                  onPressed: () {
                    // TODO: View document
                  },
                  tooltip: 'View',
                ),
                IconButton(
                  icon: Icon(Icons.download,
                      color: Colors.green.shade700, size: 20),
                  onPressed: () {
                    // TODO: Download document
                  },
                  tooltip: 'Download',
                ),
              ],
            )
          else
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Upload document
              },
              icon: const Icon(Icons.upload, size: 16),
              label: const Text('Upload'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

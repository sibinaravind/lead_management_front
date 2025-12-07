import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:overseas_front_end/utils/style/colors/colors.dart';

import '../../../widgets/widgets.dart';

class UploadDocumentsPopup extends StatefulWidget {
  final List<Map<String, dynamic>>? initialDocuments;
  final Function(List<Map<String, dynamic>>) onSave;
  final bool allowMultipleFiles;

  const UploadDocumentsPopup({
    super.key,
    this.initialDocuments,
    required this.onSave,
    this.allowMultipleFiles = true,
  });

  @override
  State<UploadDocumentsPopup> createState() => _UploadDocumentsPopupState();
}

class _UploadDocumentsPopupState extends State<UploadDocumentsPopup> {
  List<DocumentItem> _documents = [];
  final List<File> _selectedFiles = [];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _initializeDocuments();
  }

  void _initializeDocuments() {
    if (widget.initialDocuments != null) {
      _documents = widget.initialDocuments!.map((doc) {
        return DocumentItem(
          docType: doc['doc_type'] ?? '',
          filePath: doc['file_path'] ?? '',
          updatedAt: doc['updated_at'] ?? '',
          fileName: doc['file_name'] ?? '',
          fileSize: doc['file_size'] ?? '',
        );
      }).toList();
    }
    if (_documents.isEmpty) {
      _addDocument();
    }
  }

  void _addDocument() {
    setState(() {
      _documents.add(DocumentItem(
        docType: '',
        filePath: '',
        updatedAt: DateTime.now().toIso8601String(),
        fileName: '',
        fileSize: '',
      ));
    });
  }

  void _removeDocument(int index) {
    if (_documents.length > 1) {
      setState(() {
        _documents.removeAt(index);
      });
    }
  }

  Future<void> _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: widget.allowMultipleFiles,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png', 'txt'],
    );

    if (result != null) {
      setState(() {
        _selectedFiles.addAll(result.paths.map((path) => File(path!)).toList());
      });
      _showFileSelectionSuccess(result.files.length);
    }
  }

  void _showFileSelectionSuccess(int count) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$count file(s) selected successfully'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> _saveDocuments() async {
    if (_formKey.currentState!.validate()) {
      // Process uploaded files
      final List<Map<String, dynamic>> documentsList = [];

      // Add existing documents
      for (var doc in _documents) {
        if (doc.docType.isNotEmpty) {
          documentsList.add({
            'doc_type': doc.docType,
            'file_path': doc.filePath,
            'updated_at': doc.updatedAt,
            'file_name': doc.fileName,
            'file_size': doc.fileSize,
          });
        }
      }

      // Add new uploaded files
      for (var file in _selectedFiles) {
        documentsList.add({
          'doc_type': _getDocumentType(file.path),
          'file_path': file.path,
          'updated_at': DateTime.now().toIso8601String(),
          'file_name': file.path.split('/').last,
          'file_size': '${(file.lengthSync() / 1024).toStringAsFixed(2)} KB',
        });
      }

      widget.onSave(documentsList);
      Navigator.of(context).pop();
    }
  }

  String _getDocumentType(String filePath) {
    final ext = filePath.split('.').last.toLowerCase();
    switch (ext) {
      case 'pdf':
        return 'pdf';
      case 'doc':
      case 'docx':
        return 'word';
      case 'jpg':
      case 'jpeg':
      case 'png':
        return 'image';
      case 'txt':
        return 'text';
      default:
        return 'other';
    }
  }

  IconData _getDocumentIcon(String docType) {
    switch (docType.toLowerCase()) {
      case 'passport':
        return Icons.book_online;
      case 'aadhaar':
      case 'pan':
        return Icons.badge;
      case 'degree':
      case 'certificate':
        return Icons.school;
      case 'photo':
        return Icons.photo;
      case 'resume':
        return Icons.description;
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'word':
        return Icons.description;
      case 'image':
        return Icons.image;
      default:
        return Icons.insert_drive_file;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 700,
        constraints: const BoxConstraints(maxHeight: 600),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.cloud_upload_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Upload Documents',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // File Upload Section
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.blue.shade100),
                        ),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.cloud_upload,
                              size: 48,
                              color: Colors.blue,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Upload Documents',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.allowMultipleFiles
                                  ? 'Select multiple files (PDF, Word, Images, Text)'
                                  : 'Select a file (PDF, Word, Images, Text)',
                              style: TextStyle(color: Colors.grey.shade600),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            CustomActionButton(
                              text: 'Browse Files',
                              icon: Icons.folder_open,
                              onPressed: _pickFiles,
                              backgroundColor: Colors.white,
                              textColor: Colors.blue,
                              borderColor: Colors.blue,
                            ),
                          ],
                        ),
                      ),

                      // Selected Files List
                      if (_selectedFiles.isNotEmpty) ...[
                        const SizedBox(height: 20),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Selected Files:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        ..._selectedFiles.asMap().entries.map((entry) {
                          final index = entry.key;
                          final file = entry.value;
                          return _buildFileItem(index, file);
                        }).toList(),
                      ],

                      const SizedBox(height: 24),

                      // Existing Documents
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Document Details',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Document List
                      ..._documents.asMap().entries.map((entry) {
                        final index = entry.key;
                        final document = entry.value;
                        return _buildDocumentCard(index, document);
                      }).toList(),

                      // Add Document Button
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        child: CustomActionButton(
                          text: 'Add Another Document',
                          icon: Icons.add,
                          onPressed: _addDocument,
                          backgroundColor:
                              AppColors.primaryColor.withOpacity(0.1),
                          textColor: AppColors.primaryColor,
                          borderColor: AppColors.primaryColor.withOpacity(0.3),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Save Button
                      Row(
                        children: [
                          Expanded(
                            child: CustomActionButton(
                              text: 'Cancel',
                              icon: Icons.close,
                              onPressed: () => Navigator.of(context).pop(),
                              textColor: Colors.grey,
                              borderColor: Colors.grey.shade300,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CustomActionButton(
                              text: 'Upload Documents',
                              icon: Icons.cloud_upload,
                              isFilled: true,
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF7F00FF),
                                  Color(0xFFE100FF),
                                ],
                              ),
                              onPressed: _saveDocuments,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFileItem(int index, File file) {
    final fileName = file.path.split('/').last;
    final fileSize = '${(file.lengthSync() / 1024).toStringAsFixed(2)} KB';

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(
            _getDocumentIcon(fileName.split('.').last),
            color: AppColors.primaryColor,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  fileSize,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.red, size: 18),
            onPressed: () {
              setState(() {
                _selectedFiles.removeAt(index);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentCard(int index, DocumentItem document) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Document Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      _getDocumentIcon(document.docType),
                      color: AppColors.primaryColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Document ${index + 1}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
                if (_documents.length > 1)
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _removeDocument(index),
                    tooltip: 'Remove Document',
                  ),
              ],
            ),

            const SizedBox(height: 16),

            // Document Details
            CustomDropdownField(
              label: 'Document Type *',
              value: document.docType,
              items: const [
                'passport',
                'aadhaar',
                'pan',
                'degree',
                'certificate',
                'photo',
                'resume',
                'offer_letter',
                'salary_slip',
                'bank_statement',
                'visa',
                'ticket',
                'hotel_voucher',
                'insurance',
                'other',
              ],
              onChanged: (value) {
                setState(() {
                  _documents[index].docType = value ?? '';
                });
              },
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Please select document type';
              //   }
              //   return null;
              // },
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    label: 'File URL/Path',
                    controller: TextEditingController(text: document.filePath),
                    onChanged: (value) {
                      setState(() {
                        _documents[index].filePath = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter file URL or path';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomTextFormField(
                    label: 'File Name',
                    controller: TextEditingController(text: document.fileName),
                    onChanged: (value) {
                      setState(() {
                        _documents[index].fileName = value;
                      });
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    label: 'File Size',
                    controller: TextEditingController(text: document.fileSize),
                    onChanged: (value) {
                      setState(() {
                        _documents[index].fileSize = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomTextFormField(
                    label: 'Updated At',
                    controller: TextEditingController(text: document.updatedAt),
                    readOnly: true,
                    // suffixIcon: Icons.calendar_today,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Data Model
class DocumentItem {
  String docType;
  String filePath;
  String updatedAt;
  String fileName;
  String fileSize;

  DocumentItem({
    required this.docType,
    required this.filePath,
    required this.updatedAt,
    required this.fileName,
    required this.fileSize,
  });
}

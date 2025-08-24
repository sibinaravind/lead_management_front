// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';

// import '../../../model/lead/document_record_model.dart';

// class DocumentRetrievalPopup extends StatefulWidget {
//   final DocumentRecordModel document;
//   final String clientName;
//   final Function(DocumentRecordModel)? onDocumentDeleted;
//   final Function(DocumentRecordModel)? onDocumentUpdated;

//   const DocumentRetrievalPopup({
//     Key? key,
//     required this.document,
//     required this.clientName,
//     this.onDocumentDeleted,
//     this.onDocumentUpdated,
//   }) : super(key: key);

//   @override
//   State<DocumentRetrievalPopup> createState() => _DocumentRetrievalPopupState();
// }

// class _DocumentRetrievalPopupState extends State<DocumentRetrievalPopup> {
//   bool isLoading = false;
//   String? previewImageBase64;
//   Uint8List? documentData;

//   @override
//   void initState() {
//     super.initState();
//     if (widget.document.isUploaded && _isImageFile()) {
//       _loadPreview();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Container(
//         padding: const EdgeInsets.all(20),
//         constraints: const BoxConstraints(maxWidth: 400, maxHeight: 600),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Header
//             Row(
//               children: [
//                 Icon(
//                   _getDocumentIcon(),
//                   color: widget.document.required ? Colors.red : Colors.blue,
//                   size: 28,
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         _formatDocumentType(widget.document.docType),
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       if (widget.document.required)
//                         const Text(
//                           'Required Document',
//                           style: TextStyle(
//                             color: Colors.red,
//                             fontSize: 12,
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () => Navigator.pop(context),
//                   icon: const Icon(Icons.close),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),

//             // Document Status
//             if (!widget.document.isUploaded)
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.orange.shade50,
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(color: Colors.orange.shade200),
//                 ),
//                 child: Column(
//                   children: [
//                     Icon(
//                       Icons.cloud_off,
//                       color: Colors.orange.shade600,
//                       size: 48,
//                     ),
//                     const SizedBox(height: 8),
//                     const Text(
//                       'Document Not Uploaded',
//                       style: TextStyle(
//                         fontWeight: FontWeight.w500,
//                         fontSize: 16,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       'This document has not been uploaded yet.',
//                       style: TextStyle(
//                         color: Colors.grey.shade600,
//                         fontSize: 12,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ],
//                 ),
//               )
//             else ...[
//               // Document Info
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.green.shade50,
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(color: Colors.green.shade200),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Icon(Icons.check_circle, color: Colors.green.shade600),
//                         const SizedBox(width: 8),
//                         const Text(
//                           'Document Available',
//                           style: TextStyle(fontWeight: FontWeight.w500),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       'File: ${widget.document.fileName}',
//                       style: const TextStyle(
//                         fontWeight: FontWeight.w500,
//                         fontSize: 14,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       'Uploaded: ${_formatDate(widget.document.uploadedAt!)}',
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.grey.shade600,
//                       ),
//                     ),
//                     Text(
//                       'Type: ${widget.document.fileExtension.toUpperCase()}',
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.grey.shade600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 16),

//               // Preview Section (for images)
//               if (_isImageFile() && previewImageBase64 != null) ...[
//                 const Text(
//                   'Preview',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w500,
//                     fontSize: 16,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Container(
//                   height: 200,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey.shade300),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(8),
//                     child: Image.memory(
//                       base64Decode(previewImageBase64!.split(',').last),
//                       fit: BoxFit.contain,
//                       errorBuilder: (context, error, stackTrace) {
//                         return const Center(
//                           child: Icon(
//                             Icons.broken_image,
//                             size: 48,
//                             color: Colors.grey,
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//               ],

//               // Action Buttons
//               if (isLoading)
//                 const Center(child: CircularProgressIndicator())
//               else
//                 Column(
//                   children: [
//                     // View/Open Button
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton.icon(
//                         onPressed: _openDocument,
//                         icon: const Icon(Icons.open_in_new),
//                         label: const Text('Open Document'),
//                         style: ElevatedButton.styleFrom(
//                           padding: const EdgeInsets.all(16),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 12),

//                     // Download Button
//                     SizedBox(
//                       width: double.infinity,
//                       child: OutlinedButton.icon(
//                         onPressed: _downloadDocument,
//                         icon: const Icon(Icons.download),
//                         label: const Text('Download'),
//                         style: OutlinedButton.styleFrom(
//                           padding: const EdgeInsets.all(16),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 12),

//                     // Share Button
//                     SizedBox(
//                       width: double.infinity,
//                       child: OutlinedButton.icon(
//                         onPressed: _shareDocument,
//                         icon: const Icon(Icons.share),
//                         label: const Text('Share'),
//                         style: OutlinedButton.styleFrom(
//                           padding: const EdgeInsets.all(16),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),

//               const SizedBox(height: 16),

//               // Delete Button
//               TextButton.icon(
//                 onPressed: _showDeleteConfirmation,
//                 icon: const Icon(Icons.delete, color: Colors.red),
//                 label: const Text(
//                   'Delete Document',
//                   style: TextStyle(color: Colors.red),
//                 ),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }

//   bool _isImageFile() {
//     final ext = widget.document.fileExtension;
//     return ['jpg', 'jpeg', 'png', 'webp'].contains(ext);
//   }

//   IconData _getDocumentIcon() {
//     final ext = widget.document.fileExtension;

//     if (['jpg', 'jpeg', 'png', 'webp'].contains(ext)) {
//       return Icons.image;
//     } else if (ext == 'pdf') {
//       return Icons.picture_as_pdf;
//     } else if (['doc', 'docx'].contains(ext)) {
//       return Icons.description;
//     } else if (['txt'].contains(ext)) {
//       return Icons.text_snippet;
//     } else {
//       return Icons.insert_drive_file;
//     }
//   }

//   String _formatDocumentType(String docType) {
//     switch (docType.toLowerCase()) {
//       case 'passport':
//         return 'Passport';
//       case '12th':
//         return '12th Grade Certificate';
//       case 'aadhar':
//         return 'Aadhar Card';
//       case 'pan':
//         return 'PAN Card';
//       case 'driving_license':
//         return 'Driving License';
//       default:
//         return docType.toUpperCase();
//     }
//   }

//   String _formatDate(DateTime date) {
//     return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
//   }

//   Future<void> _loadPreview() async {
//     if (!widget.document.isUploaded || !_isImageFile()) return;

//     setState(() {
//       isLoading = true;
//     });

//     try {
//       final base64Data = await DocumentRetrievalService.getDocumentBase64(
//         widget.document.filePath!,
//       );

//       if (base64Data != null) {
//         setState(() {
//           previewImageBase64 = base64Data;
//         });
//       }
//     } catch (e) {
//       _showErrorSnackBar('Failed to load preview: $e');
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   Future<void> _openDocument() async {
//     setState(() {
//       isLoading = true;
//     });

//     try {
//       final data = await DocumentRetrievalService.getDocumentFile(
//         widget.document.filePath!,
//       );

//       if (data != null) {
//         // Save to temporary directory
//         final tempDir = await getTemporaryDirectory();
//         final fileName = widget.document.fileName;
//         final file = File('${tempDir.path}/$fileName');
//         await file.writeAsBytes(data);

//         // Open file with default app
//         final result = await OpenFile.open(file.path);

//         if (result.type != ResultType.done) {
//           _showErrorSnackBar('Unable to open file: ${result.message}');
//         }
//       } else {
//         _showErrorSnackBar('Failed to retrieve document');
//       }
//     } catch (e) {
//       _showErrorSnackBar('Error opening document: $e');
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   // Future<void> _downloadDocument() async {
//   //   setState(() {
//   //     isLoading = true;
//   //   });

//   //   try {
//   //     // Request storage permission
//   //     final status = await Permission.storage.request();
//   //     if (!status.isGranted) {
//   //       _showErrorSnackBar('Storage permission required for download');
//   //       return;
//   //     }

//   //     final data = await DocumentRetrievalService.getDocumentFile(
//   //       widget.document.filePath!,
//   //     );

//   //     if (data != null) {
//   //       final downloadsDir = Directory('/storage/emulated/0/Download');
//   //       if (!await downloadsDir.exists()) {
//   //         await downloadsDir.create(recursive: true);
//   //       }

//   //       final fileName = '${widget.clientName}_${widget.document.fileName}';
//   //       final file = File('${downloadsDir.path}/$fileName');
//   //       await file.writeAsBytes(data);

//   //       _showSuccessSnackBar('Document downloaded to Downloads folder');
//   //     } else {
//   //       _showErrorSnackBar('Failed to download document');
//   //     }
//   //   } catch (e) {
//   //     _showErrorSnackBar('Error downloading document: $e');
//   //   } finally {
//   //     setState(() {
//   //       isLoading = false;
//   //     });
//   //   }
//   // }

//   // Future<void> _shareDocument() async {
//   //   setState(() {
//   //     isLoading = true;
//   //   });

//   //   try {
//   //     final data = await DocumentRetrievalService.getDocumentFile(
//   //       widget.document.filePath!,
//   //     );

//   //     if (data != null) {
//   //       final tempDir = await getTemporaryDirectory();
//   //       final fileName = widget.document.fileName;
//   //       final file = File('${tempDir.path}/$fileName');
//   //       await file.writeAsBytes(data);

//   //       await Share.shareXFiles(
//   //         [XFile(file.path)],
//   //         text: 'Sharing ${_formatDocumentType(widget.document.docType)} for ${widget.clientName}',
//   //       );
//   //     } else {
//   //       _showErrorSnackBar('Failed to share document');
//   //     }
//   //   } catch (e) {
//   //     _showErrorSnackBar('Error sharing document: $e');
//   //   } finally {
//   //     setState(() {
//   //       isLoading = false;
//   //     });
//   //   }
//   // }

//   // void _showDeleteConfirmation() {
//   //   showDialog(
//   //     context: context,
//   //     builder: (BuildContext context) {
//   //       return AlertDialog(
//   //         title: const Text('Delete Document'),
//   //         content: Text(
//   //           'Are you sure you want to delete this ${_formatDocumentType(widget.document.docType)}? This action cannot be undone.',
//   //         ),
//   //         actions: [
//   //           TextButton(
//   //             onPressed: () => Navigator.pop(context),
//   //             child: const Text('Cancel'),
//   //           ),
//   //           TextButton(
//   //             onPressed: () {
//   //               Navigator.pop(context);
//   //               _deleteDocument();
//   //             },
//   //             style: TextButton.styleFrom(
//   //               foregroundColor: Colors.red,
//   //             ),
//   //             child: const Text('Delete'),
//   //           ),
//   //         ],
//   //       );
//   //     },
//   //   );
//   // }

//   // Future<void> _deleteDocument() async {
//   //   setState(() {
//   //     isLoading = true;
//   //   });

//   //   try {
//   //     final success = await DocumentRetrievalService.deleteDocument(
//   //       widget.document.filePath!,
//   //     );

//   //     if (success) {
//   //       _showSuccessSnackBar('Document deleted successfully');

//   //       // Create updated document model (mark as not uploaded)
//   //       final updatedDocument = DocumentRecordModel(
//   //         docType: widget.document.docType,
//   //         required: widget.document.required,
//   //         filePath: null,
//   //         uploadedAt: null,
//   //       );

//   //       widget.onDocumentDeleted?.call(updatedDocument);
//   //       Navigator.pop(context);
//   //     } else {
//   //       _showErrorSnackBar('Failed to delete document');
//   //     }
//   //   } catch (e) {
//   //     _showErrorSnackBar('Error deleting document: $e');
//   //   } finally {
//   //     setState(() {
//   //       isLoading = false;
//   //     });
//   //   }
//   // }

//   // void _showErrorSnackBar(String message) {
//   //   if (mounted) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(
//   //         content: Text(message),
//   //         backgroundColor: Colors.red,
//   //       ),
//   //     );
//   //   }
//   // }

//   // void _showSuccessSnackBar(String message) {
//   //   if (mounted) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(
//   //         content: Text(message),
//   //         backgroundColor: Colors.green,
//   //       ),
//   //     );
//   //   }
//   // }
// }

// // Usage Example Widget
// class DocumentListWidget extends StatefulWidget {
//   final String clientName;

//   const DocumentListWidget({
//     Key? key,
//     required this.clientName,
//   }) : super(key: key);

//   @override
//   State<DocumentListWidget> createState() => _DocumentListWidgetState();
// }

// class _DocumentListWidgetState extends State<DocumentListWidget> {
//   List<DocumentRecordModel> documents = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadDocuments();
//   }

//   void _loadDocuments() {
//     // Sample data - replace with your API call
//     documents = [
//       DocumentRecordModel(
//         docType: 'passport',
//         required: false,
//         filePath:
//             'uploads/client_documents/passport_client_6878fe2a3e1c829a55bcebec_1754909201628_pw5nr.pdf',
//         uploadedAt: DateTime.parse('2025-08-11T10:46:48.265Z'),
//       ),
//       DocumentRecordModel(
//         docType: '12th',
//         required: true,
//         filePath: null,
//         uploadedAt: null,
//       ),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: documents.length,
//       itemBuilder: (context, index) {
//         final document = documents[index];
//         return Card(
//           margin: const EdgeInsets.all(8),
//           child: ListTile(
//             leading: Icon(
//               document.isUploaded ? Icons.check_circle : Icons.cloud_off,
//               color: document.isUploaded ? Colors.green : Colors.orange,
//             ),
//             title: Text(document.docType.toUpperCase()),
//             subtitle: Text(
//               document.isUploaded
//                   ? 'Uploaded on ${document.uploadedAt?.day}/${document.uploadedAt?.month}/${document.uploadedAt?.year}'
//                   : 'Not uploaded',
//             ),
//             trailing: document.required
//                 ? const Icon(Icons.star, color: Colors.red)
//                 : null,
//             onTap: () => _showDocumentPopup(document),
//           ),
//         );
//       },
//     );
//   }

//   void _showDocumentPopup(DocumentRecordModel document) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return DocumentRetrievalPopup(
//           document: document,
//           clientName: widget.clientName,
//           onDocumentDeleted: (updatedDoc) {
//             setState(() {
//               final index =
//                   documents.indexWhere((d) => d.docType == updatedDoc.docType);
//               if (index != -1) {
//                 documents[index] = updatedDoc;
//               }
//             });
//           },
//         );
//       },
//     );
//   }
// }

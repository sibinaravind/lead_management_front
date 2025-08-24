import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';
import 'package:overseas_front_end/view/widgets/custom_toast.dart';
import 'dart:convert';
import 'dart:typed_data';
// Web imports
// ignore: deprecated_member_use, avoid_web_libraries_in_flutter
import 'dart:html' as html show FileUploadInputElement, FileReader;

import '../../../../controller/registration/registration_controller.dart';
import '../../../../core/shared/constants.dart';
import '../../../../model/lead/document_record_model.dart';
import '../../../../model/lead/lead_model.dart';
import '../../../../utils/functions/format_date.dart';
import '../../../../utils/style/colors/colors.dart';
import '../../../widgets/loading_dialog.dart';
import '../../../widgets/view_doc_widget.dart';

class DocumentTab extends StatefulWidget {
  final LeadModel? leadModel;
  const DocumentTab({super.key, this.leadModel});

  @override
  State<DocumentTab> createState() => _DocumentTabState();
}

class _DocumentTabState extends State<DocumentTab> {
  List<DocumentRecordModel> _documents = [];
  final _registerationController = Get.find<RegistrationController>();
  final List<String> _defaultDocTypes = [
    'Passport',
    'SSLC',
    '12th/Plus Two',
    'Degree Certificate',
    'Work Experience',
    'IELTS/TOEFL',
    'Visa Copy',
    'Other'
  ];

  @override
  void initState() {
    super.initState();
    _initializeDocuments();
  }

  void _initializeDocuments() {
    if (widget.leadModel?.documents != null) {
      _documents = List.from(widget.leadModel!.documents!);
    }
    // Add missing default types
    for (String docType in _defaultDocTypes) {
      bool exists = _documents
          .any((doc) => doc.docType?.toLowerCase() == docType.toLowerCase());

      if (!exists) {
        _documents.add(DocumentRecordModel(
          docType: docType,
          required: docType == 'Passport' || docType == 'SSLC',
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Documents',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${_documents.where((d) => d.filePath != null).length}/${_documents.length} Uploaded',
                  style: TextStyle(
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
              child: ListView.builder(
            itemCount: _documents.length,
            itemBuilder: (context, index) {
              final doc = _documents[index];
              return _buildDocumentCard(doc, index);
            },
          )),
        ],
      ),
    );
  }

  Widget _buildDocumentCard(DocumentRecordModel doc, int index) {
    final hasFile = doc.filePath != null;
    final isRequired = doc.required == true;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: hasFile
            ? Colors.green.shade50
            : (isRequired ? Colors.purple.shade50 : Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Document Icon
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: hasFile ? Colors.green.shade100 : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                hasFile ? Icons.check_circle : Icons.description,
                color: hasFile ? Colors.green : Colors.grey,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),

            // Document Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        doc.docType ?? 'Unknown',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    hasFile
                        ? 'Uploaded ${formatDatetoString(doc.uploadedAt)}'
                        : isRequired
                            ? 'Tap to upload document'
                            : 'Check to make it required',
                    style: TextStyle(
                      fontSize: 12,
                      color: hasFile
                          ? Colors.green.shade600
                          : Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                // Required Switch
                Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: isRequired,
                    onChanged: (value) => setState(() {
                      _registerationController.setRequiredDocuments(
                        data: [
                          DocumentRecordModel(
                            docType: _documents[index].docType,
                            required: !(_documents[index].required ?? false),
                          )
                        ],
                      );
                      _documents[index] = DocumentRecordModel(
                        docType: _documents[index].docType,
                        required: !(_documents[index].required ?? false),
                        filePath: _documents[index].filePath,
                        uploadedAt: _documents[index].uploadedAt,
                      );
                    }),
                    activeColor: Colors.white,
                    activeTrackColor: Colors.purple.shade400,
                    inactiveThumbColor: Colors.grey.shade400,
                    inactiveTrackColor: Colors.grey.shade200,
                  ),
                ),
                const SizedBox(height: 4),

                // Upload/View Button
                InkWell(
                  onTap: () => hasFile
                      ? showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            contentPadding: const EdgeInsets.all(0),
                            content: ViewDocWidget(
                              fileUrl: Constant().featureBaseUrl +
                                  (_documents[index].filePath ?? ''),
                              fileName: _documents[index].docType ?? 'Unknown',
                            ),
                          ),
                        )
                      : _showUploadDialog(
                          _documents[index].docType ?? '',
                          index,
                        ),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color:
                          hasFile ? Colors.blue.shade50 : Colors.green.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          hasFile ? Icons.visibility : Icons.upload_file,
                          size: 16,
                          color: hasFile
                              ? Colors.blue.shade600
                              : Colors.green.shade600,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          hasFile ? 'View' : 'Upload',
                          style: TextStyle(
                            fontSize: 12,
                            color: hasFile
                                ? Colors.blue.shade600
                                : Colors.green.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showUploadDialog(String docType, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Text(
              'Upload Document',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            content: Container(
              width: kIsWeb ? 400 : double.maxFinite,
              child: DocumentUploadWidget(
                docType: docType,
                onFileSelected: (base64String) async {
                  // Navigator.pop(context); // Close dialog
                  await _uploadDocument(docType, base64String, index);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _uploadDocument(
      String docType, String base64String, int index) async {
    try {
      showLoaderDialog(context);

      dynamic result =
          await _registerationController.updateClientRequiredDocuments(
        docType: docType,
        base64String: base64String,
      );
      // print(result);
      // print(result['file_path']);
      if (mounted) Navigator.pop(context); // Close loader
      if (result != "false") {
        print(result);
        setState(() {
          _documents[index] = DocumentRecordModel(
            docType: docType,
            required: _documents[index].required,
            filePath: result,
            uploadedAt: DateTime.now(),
          );
        });
        if (mounted) {
          Navigator.pop(context);
          CustomToast.showToast(
              context: context, message: 'File uploaded successfully');
        }
      } else {
        if (mounted) {
          CustomToast.showToast(
              context: context, message: 'Failed to upload file');
        }
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to upload file'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}

class DocumentUploadWidget extends StatefulWidget {
  final String docType;
  final Function(String) onFileSelected;

  const DocumentUploadWidget({
    super.key,
    required this.docType,
    required this.onFileSelected,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DocumentUploadWidgetState createState() => _DocumentUploadWidgetState();
}

class _DocumentUploadWidgetState extends State<DocumentUploadWidget> {
  String? _selectedFileName;
  String? _base64String;
  bool _isLoading = false;

  Future<void> _pickFile() async {
    if (kIsWeb) {
      await _pickFileWeb();
    } else {
      await _pickFileMobile();
    }
  }

  Future<void> _pickFileWeb() async {
    try {
      setState(() {
        _isLoading = true;
      });

      html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
      uploadInput.accept = '.pdf,.jpg,.jpeg,.png';
      uploadInput.click();

      uploadInput.onChange.listen((e) async {
        final files = uploadInput.files;
        if (files!.isEmpty) {
          setState(() {
            _isLoading = false;
          });
          return;
        }

        final file = files[0];
        final fileName = file.name;

        String extension = fileName.split('.').last.toLowerCase();
        if (!['pdf', 'jpg', 'jpeg', 'png'].contains(extension)) {
          setState(() {
            _isLoading = false;
          });
          _showError('Please select a PDF, JPG, JPEG, or PNG file');
          return;
        }

        final reader = html.FileReader();
        reader.readAsArrayBuffer(file);

        reader.onLoadEnd.listen((e) async {
          try {
            final Uint8List fileBytes = reader.result as Uint8List;
            await _processFileBytes(fileBytes, fileName);
          } catch (e) {
            setState(() {
              _isLoading = false;
            });
            _showError('Error processing file: $e');
          }
        });
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showError('Error: $e');
    }
  }

  Future<void> _pickFileMobile() async {
    // For mobile, you would implement file_picker or image_picker here
    setState(() {
      _isLoading = false;
    });
    _showError(
        'Mobile file picker not implemented. Add file_picker package for mobile support.');
  }

  Future<void> _processFileBytes(Uint8List fileBytes, String fileName) async {
    try {
      String mimeType;
      String extension = fileName.split('.').last.toLowerCase();

      switch (extension) {
        case 'pdf':
          mimeType = 'application/pdf';
          break;
        case 'jpg':
        case 'jpeg':
          mimeType = 'image/jpeg';
          break;
        case 'png':
          mimeType = 'image/png';
          break;
        default:
          mimeType = 'application/octet-stream';
      }

      String base64 = base64Encode(fileBytes);
      String fullBase64 = 'data:$mimeType;base64,$base64';

      setState(() {
        _selectedFileName = fileName;
        _base64String = fullBase64;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showError('Error processing file: $e');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Select an image or PDF file to upload for ${widget.docType}.',
          style: TextStyle(color: Colors.grey[600]),
        ),
        const SizedBox(height: 20),

        // File Selection Area
        GestureDetector(
          onTap: _isLoading ? null : _pickFile,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.shade100,
            ),
            child: Row(
              children: [
                const Icon(Icons.attach_file, color: AppColors.primaryColor),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _selectedFileName ?? 'Choose file',
                    style: TextStyle(
                      color: _selectedFileName != null
                          ? AppColors.textColor
                          : Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Icon(Icons.folder_open, color: AppColors.primaryColor),
              ],
            ),
          ),
        ),

        if (_selectedFileName != null) ...[
          const SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green[50],
              border: Border.all(color: Colors.green),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                const Icon(Icons.insert_drive_file,
                    color: AppColors.primaryColor),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _selectedFileName!,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                Icon(Icons.check_circle, color: Colors.green, size: 20),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: _base64String != null
                    ? () => widget.onFileSelected(_base64String!)
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Upload'),
              ),
            ],
          ),
        ] else ...[
          const SizedBox(height: 20),
          // Info text
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  border: Border.all(color: Colors.blue[200]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info, color: Colors.blue, size: 16),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Supported formats: PDF, JPG, JPEG, PNG',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue[700],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart' show kIsWeb, compute;
// import 'package:get/get.dart';
// import 'dart:convert';
// import 'dart:typed_data';
// import 'dart:html' as html;
// import 'dart:io' as io show File;
// import '../../../../controller/registration/registration_controller.dart';

// class DocumentUploadPage extends StatefulWidget {
//   @override
//   _DocumentUploadPageState createState() => _DocumentUploadPageState();
// }

// class _DocumentUploadPageState extends State<DocumentUploadPage> {
//   String? _selectedFileName;
//   String? _docType = "12th";
//   String? _base64String;
//   bool _isLoading = false;
//   bool _isUploading = false;
//   double _uploadProgress = 0.0;
//   String _uploadStatus = '';

//   final List<String> _docTypes = [
//     "10th",
//     "12th",
//     "graduation",
//     "diploma",
//     "certificate",
//     "other"
//   ];

//   // Maximum file size (5MB)
//   static const int MAX_FILE_SIZE = 5 * 1024 * 1024;

//   Future<void> _pickFile() async {
//     if (kIsWeb) {
//       await _pickFileWeb();
//     } else {
//       await _pickFileMobile();
//     }
//   }

//   Future<void> _pickFileWeb() async {
//     try {
//       setState(() {
//         _isLoading = true;
//         _uploadStatus = 'Opening file picker...';
//       });

//       html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
//       uploadInput.accept = '.pdf,.jpg,.jpeg,.png';
//       uploadInput.click();

//       uploadInput.onChange.listen((e) async {
//         final files = uploadInput.files;
//         if (files!.isEmpty) {
//           setState(() {
//             _isLoading = false;
//             _uploadStatus = '';
//           });
//           return;
//         }

//         final file = files[0];
//         final fileName = file.name;

//         // Check file size
//         if (file.size > MAX_FILE_SIZE) {
//           setState(() {
//             _isLoading = false;
//             _uploadStatus = '';
//           });
//           _showError(
//               'File size exceeds 5MB limit. Please choose a smaller file.');
//           return;
//         }

//         // Validate file type
//         String extension = fileName.split('.').last.toLowerCase();
//         if (!['pdf', 'jpg', 'jpeg', 'png'].contains(extension)) {
//           setState(() {
//             _isLoading = false;
//             _uploadStatus = '';
//           });
//           _showError('Please select a PDF, JPG, JPEG, or PNG file');
//           return;
//         }

//         setState(() {
//           _uploadStatus = 'Reading file...';
//         });

//         final reader = html.FileReader();
//         reader.readAsArrayBuffer(file);

//         reader.onLoadEnd.listen((e) async {
//           try {
//             final Uint8List fileBytes = reader.result as Uint8List;
//             await _processFileBytes(fileBytes, fileName);
//           } catch (e) {
//             setState(() {
//               _isLoading = false;
//               _uploadStatus = '';
//             });
//             _showError('Error processing file: $e');
//           }
//         });

//         reader.onError.listen((e) {
//           setState(() {
//             _isLoading = false;
//             _uploadStatus = '';
//           });
//           _showError('Error reading file');
//         });
//       });
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//         _uploadStatus = '';
//       });
//       _showError('Error: $e');
//     }
//   }

//   Future<void> _pickFileMobile() async {
//     try {
//       setState(() {
//         _isLoading = true;
//       });

//       showModalBottomSheet(
//         context: context,
//         builder: (BuildContext context) {
//           return SafeArea(
//             child: Wrap(
//               children: [
//                 ListTile(
//                   leading: Icon(Icons.photo_library),
//                   title: Text('Choose from Gallery'),
//                   onTap: () {
//                     Navigator.of(context).pop();
//                     _pickFromGallery();
//                   },
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.camera_alt),
//                   title: Text('Take Photo'),
//                   onTap: () {
//                     Navigator.of(context).pop();
//                     _pickFromCamera();
//                   },
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.description),
//                   title: Text('Choose PDF/Document'),
//                   onTap: () {
//                     Navigator.of(context).pop();
//                     _pickDocument();
//                   },
//                 ),
//               ],
//             ),
//           );
//         },
//       );
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//       });
//       _showError('Error: $e');
//     }
//   }

//   Future<void> _pickFromGallery() async {
//     setState(() {
//       _isLoading = false;
//     });
//     _showError(
//         'Image picker not implemented. Add image_picker package for mobile support.');
//   }

//   Future<void> _pickFromCamera() async {
//     setState(() {
//       _isLoading = false;
//     });
//     _showError(
//         'Camera picker not implemented. Add image_picker package for mobile support.');
//   }

//   Future<void> _pickDocument() async {
//     setState(() {
//       _isLoading = false;
//     });
//     _showError(
//         'Document picker not implemented. Add file_picker package for mobile support.');
//   }

//   // Process file in isolate to prevent UI blocking
//   Future<void> _processFileBytes(Uint8List fileBytes, String fileName) async {
//     try {
//       setState(() {
//         _uploadStatus = 'Processing file...';
//       });

//       // Use compute for heavy base64 encoding to prevent UI blocking
//       final Map<String, String> result = await compute(_processFileInIsolate, {
//         'fileBytes': fileBytes,
//         'fileName': fileName,
//       });

//       setState(() {
//         _selectedFileName = fileName;
//         _base64String = result['base64'];
//         _isLoading = false;
//         _uploadStatus = 'File processed successfully';
//       });

//       // Clear status after a delay
//       Future.delayed(Duration(seconds: 2), () {
//         if (mounted) {
//           setState(() {
//             _uploadStatus = '';
//           });
//         }
//       });

//       _showResult();
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//         _uploadStatus = '';
//       });
//       _showError('Error processing file: $e');
//     }
//   }

//   // Static method to run in isolate
//   static Map<String, String> _processFileInIsolate(
//       Map<String, dynamic> params) {
//     final Uint8List fileBytes = params['fileBytes'];
//     final String fileName = params['fileName'];

//     // Determine MIME type
//     String mimeType;
//     String extension = fileName.split('.').last.toLowerCase();

//     switch (extension) {
//       case 'pdf':
//         mimeType = 'application/pdf';
//         break;
//       case 'jpg':
//       case 'jpeg':
//         mimeType = 'image/jpeg';
//         break;
//       case 'png':
//         mimeType = 'image/png';
//         break;
//       default:
//         mimeType = 'application/octet-stream';
//     }

//     String base64 = base64Encode(fileBytes);
//     String fullBase64 = 'data:$mimeType;base64,$base64';

//     return {
//       'base64': fullBase64,
//       'mimeType': mimeType,
//     };
//   }

//   // Upload with progress tracking
//   Future<void> _uploadDocument() async {
//     if (_base64String == null || _docType == null) {
//       _showError('Please select a file and document type');
//       return;
//     }

//     setState(() {
//       _isUploading = true;
//       _uploadProgress = 0.0;
//       _uploadStatus = 'Preparing upload...';
//     });

//     try {
//       // Simulate progress updates
//       for (int i = 1; i <= 3; i++) {
//         setState(() {
//           _uploadProgress = i * 0.25;
//           _uploadStatus = i == 1
//               ? 'Validating data...'
//               : i == 2
//                   ? 'Sending to server...'
//                   : 'Processing...';
//         });
//         await Future.delayed(Duration(milliseconds: 300));
//       }

//       // Actual upload using GetX controller
//       final result = await Get.find<RegistrationController>()
//           .updateClientRequiredDocuments(
//         docType: _docType!,
//         base64String: _base64String!,
//       );

//       setState(() {
//         _uploadProgress = 1.0;
//         _uploadStatus = 'Upload completed successfully!';
//       });

//       await Future.delayed(Duration(seconds: 1));

//       setState(() {
//         _isUploading = false;
//         _uploadProgress = 0.0;
//         _uploadStatus = '';
//       });

//       _showSuccess('Document uploaded successfully!');
//     } catch (e) {
//       setState(() {
//         _isUploading = false;
//         _uploadProgress = 0.0;
//         _uploadStatus = '';
//       });
//       _showError('Upload failed: ${e.toString()}');
//     }
//   }

//   void _showResult() {
//     if (_base64String != null) {
//       Map<String, String> result = {
//         "doc_type": _docType!,
//         "base64": _base64String!,
//       };

//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Generated JSON'),
//             content: Container(
//               width: double.maxFinite,
//               height: kIsWeb ? 400 : 300,
//               child: SingleChildScrollView(
//                 child: SelectableText(
//                   JsonEncoder.withIndent('  ').convert(result),
//                   style: TextStyle(
//                     fontFamily: 'monospace',
//                     fontSize: kIsWeb ? 12 : 10,
//                   ),
//                 ),
//               ),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 child: Text('Close'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                   _uploadDocument();
//                 },
//                 child: Text('Upload Document'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }

//   void _showError(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.red,
//         duration: Duration(seconds: 4),
//       ),
//     );
//   }

//   void _showSuccess(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.green,
//         duration: Duration(seconds: 3),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Document Upload'),
//         backgroundColor: Colors.blue,
//         foregroundColor: Colors.white,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Platform indicator
//             Container(
//               padding: EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: kIsWeb ? Colors.orange[50] : Colors.green[50],
//                 border: Border.all(
//                     color: kIsWeb ? Colors.orange[200]! : Colors.green[200]!),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     kIsWeb ? Icons.web : Icons.phone_android,
//                     size: 16,
//                     color: kIsWeb ? Colors.orange[700] : Colors.green[700],
//                   ),
//                   SizedBox(width: 8),
//                   Text(
//                     'Running on: ${kIsWeb ? 'Web' : 'Mobile'}',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: kIsWeb ? Colors.orange[700] : Colors.green[700],
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16),

//             Card(
//               elevation: 2,
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Document Type',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     DropdownButtonFormField<String>(
//                       value: _docType,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         contentPadding: EdgeInsets.symmetric(
//                           horizontal: 12,
//                           vertical: 8,
//                         ),
//                       ),
//                       items: _docTypes.map((String type) {
//                         return DropdownMenuItem<String>(
//                           value: type,
//                           child: Text(type),
//                         );
//                       }).toList(),
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           _docType = newValue;
//                         });
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),

//             Card(
//               elevation: 2,
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Select File',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       kIsWeb
//                           ? 'Supported formats: PDF, JPG, JPEG, PNG (Max 5MB)'
//                           : 'Choose from gallery, camera, or documents (Max 5MB)',
//                       style: TextStyle(
//                         color: Colors.grey[600],
//                         fontSize: 12,
//                       ),
//                     ),
//                     SizedBox(height: 16),

//                     // Status indicator
//                     if (_uploadStatus.isNotEmpty) ...[
//                       Container(
//                         padding: EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           color: Colors.blue[50],
//                           border: Border.all(color: Colors.blue[200]!),
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                         child: Row(
//                           children: [
//                             SizedBox(
//                               width: 16,
//                               height: 16,
//                               child: CircularProgressIndicator(
//                                 strokeWidth: 2,
//                                 valueColor: AlwaysStoppedAnimation<Color>(
//                                   Colors.blue,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(width: 8),
//                             Expanded(
//                               child: Text(
//                                 _uploadStatus,
//                                 style: TextStyle(
//                                   color: Colors.blue[700],
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 12),
//                     ],

//                     // Upload progress
//                     if (_isUploading) ...[
//                       LinearProgressIndicator(
//                         value: _uploadProgress,
//                         backgroundColor: Colors.grey[300],
//                         valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         '${(_uploadProgress * 100).toInt()}% Complete',
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.grey[600],
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       SizedBox(height: 12),
//                     ],

//                     ElevatedButton.icon(
//                       onPressed:
//                           (_isLoading || _isUploading) ? null : _pickFile,
//                       icon: (_isLoading || _isUploading)
//                           ? SizedBox(
//                               width: 16,
//                               height: 16,
//                               child: CircularProgressIndicator(
//                                 strokeWidth: 2,
//                                 valueColor: AlwaysStoppedAnimation<Color>(
//                                   Colors.white,
//                                 ),
//                               ),
//                             )
//                           : Icon(kIsWeb
//                               ? Icons.file_upload
//                               : Icons.add_photo_alternate),
//                       label: Text((_isLoading || _isUploading)
//                           ? 'Processing...'
//                           : kIsWeb
//                               ? 'Choose File'
//                               : 'Select File'),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue,
//                         foregroundColor: Colors.white,
//                         minimumSize: Size(double.infinity, 48),
//                       ),
//                     ),

//                     if (_selectedFileName != null) ...[
//                       SizedBox(height: 12),
//                       Container(
//                         padding: EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           color: Colors.green[50],
//                           border: Border.all(color: Colors.green),
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.check_circle,
//                               color: Colors.green,
//                               size: 20,
//                             ),
//                             SizedBox(width: 8),
//                             Expanded(
//                               child: Text(
//                                 'Selected: $_selectedFileName',
//                                 style: TextStyle(
//                                   color: Colors.green[700],
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ],
//                 ),
//               ),
//             ),

//             if (_base64String != null && !_isUploading) ...[
//               SizedBox(height: 16),
//               Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton.icon(
//                       onPressed: _showResult,
//                       icon: Icon(Icons.code),
//                       label: Text('Show JSON'),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.grey[600],
//                         foregroundColor: Colors.white,
//                         minimumSize: Size(0, 48),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 12),
//                   Expanded(
//                     child: ElevatedButton.icon(
//                       onPressed: _uploadDocument,
//                       icon: Icon(Icons.cloud_upload),
//                       label: Text('Upload'),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                         foregroundColor: Colors.white,
//                         minimumSize: Size(0, 48),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],

//             SizedBox(height: 16),
//             Container(
//               padding: EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.blue[50],
//                 border: Border.all(color: Colors.blue[200]!),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Icon(Icons.info, color: Colors.blue, size: 20),
//                       SizedBox(width: 8),
//                       Text(
//                         'Performance Tips:',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.blue[700],
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     '• Files are processed in background to prevent app freezing\n• Maximum file size: 5MB\n• Base64 encoding uses isolate for better performance\n• Upload progress is shown for better user experience\n• Large files may take longer to process',
//                     style: TextStyle(
//                       fontSize: 11,
//                       color: Colors.blue[700],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

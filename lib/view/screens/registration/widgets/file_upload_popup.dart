import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/view/widgets/custom_snackbar.dart';
import '../../../../controller/customer_profile/customer_profile_controller.dart';
import '../../../../utils/style/colors/colors.dart';
import '../../../widgets/loading_dialog.dart';

class FileUploadDialog extends StatefulWidget {
  final String docType;

  const FileUploadDialog({
    super.key,
    required this.docType,
  });

  @override
  State<FileUploadDialog> createState() => _FileUploadDialogState();
}

class _FileUploadDialogState extends State<FileUploadDialog> {
  PlatformFile? selectedFile;
  String? previewPath;

  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
        withData: true, // Important for web platform
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          selectedFile = result.files.single;
          previewPath = selectedFile?.path;
        });
      }
    } catch (e) {
      debugPrint('Error picking file: $e');
      if (mounted) {
        CustomSnackBar.show(context, 'Error selecting file');
      }
    }
  }

  Future<void> _submitFile() async {
    if (selectedFile == null) {
      CustomSnackBar.show(context, 'Please select a file first');
      return;
    }

    bool isLoaderShown = false;

    try {
      Uint8List? bytes = selectedFile!.bytes;
      if (bytes == null && selectedFile!.path != null && !kIsWeb) {
        bytes = await File(selectedFile!.path!).readAsBytes();
      }

      if (bytes == null) {
        if (mounted) {
          CustomSnackBar.show(context, 'Unable to read file data');
        }
        return;
      }

      // Determine MIME type
      String mimeType = '';
      final ext = selectedFile!.extension?.toLowerCase();

      switch (ext) {
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
          if (mounted) {
            CustomSnackBar.show(context, 'Unsupported file type');
          }
          return;
      }

      // Validate file size (e.g., 5MB limit)
      const maxSize = 5 * 1024 * 1024; // 5MB
      if (bytes.length > maxSize) {
        if (mounted) {
          CustomSnackBar.show(
            context,
            'File too large. Maximum size is 5MB',
          );
        }
        return;
      }

      // Show loader
      if (mounted) {
        showLoaderDialog(context);
        isLoaderShown = true;
      }
      final base64String = 'data:$mimeType;base64,${base64Encode(bytes)}';

      final result = await Get.find<CustomerProfileController>().uploadDocument(
        // ignore: use_build_context_synchronously
        context: context,
        body: {
          "doc_type": widget.docType,
          "base64": base64String,
        },
      );

      // Close loader dialog
      if (mounted && isLoaderShown) {
        Navigator.pop(context);
        isLoaderShown = false;
      }

      // Handle result
      if (mounted) {
        if (result != null && result != "false") {
          Navigator.pop(context); // Close the file upload dialog
          CustomSnackBar.show(context, 'File uploaded successfully');
        } else {
          CustomSnackBar.show(context, 'Failed to upload file');
        }
      }
    } catch (e) {
      debugPrint('Error uploading file: $e');

      // Close loader if shown
      if (mounted && isLoaderShown) {
        Navigator.pop(context);
      }

      // Show error message
      if (mounted) {
        CustomSnackBar.show(
          context,
          'An error occurred while uploading the file',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        'Upload Document',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Select an image or PDF file to upload.'),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: _pickFile,
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
                      selectedFile?.name ?? 'Choose file',
                      style: TextStyle(
                        color: selectedFile != null
                            ? AppColors.textColor
                            : Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(Icons.folder_open, color: AppColors.primaryColor),
                ],
              ),
            ),
          ),
          if (selectedFile != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Row(
                children: [
                  Icon(
                    selectedFile!.extension?.toLowerCase() == 'pdf'
                        ? Icons.picture_as_pdf
                        : Icons.image,
                    color: Colors.green.shade700,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectedFile!.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '${(selectedFile!.size / 1024).toStringAsFixed(2)} KB',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: selectedFile == null ? null : _submitFile,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
            disabledBackgroundColor: Colors.grey.shade300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';

// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:overseas_front_end/view/widgets/custom_snackbar.dart';

// import '../../../../controller/customer_profile/customer_profile_controller.dart';
// import '../../../../controller/registration/registration_controller.dart';
// import '../../../../utils/style/colors/colors.dart';
// import '../../../widgets/loading_dialog.dart';

// class FileUploadDialog extends StatefulWidget {
//   final String docType;

//   const FileUploadDialog({
//     super.key,
//     required this.docType,
//   });

//   @override
//   State<FileUploadDialog> createState() => _FileUploadDialogState();
// }

// class _FileUploadDialogState extends State<FileUploadDialog> {
//   PlatformFile? selectedFile;
//   String? previewPath;

//   Future<void> _pickFile() async {
//     final result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
//       withData: true,
//     );

//     if (result != null && result.files.isNotEmpty) {
//       setState(() {
//         selectedFile = result.files.single;
//         previewPath = selectedFile?.path;
//       });
//     }
//   }

//   Future<void> _submitFile() async {
//     if (selectedFile == null) return;
//     try {
//       Uint8List? bytes = selectedFile!.bytes;

//       if (bytes == null && selectedFile!.path != null) {
//         bytes = await File(selectedFile!.path!).readAsBytes();
//       }

//       if (bytes != null) {
//         String mimeType = '';
//         final ext = selectedFile!.extension?.toLowerCase();
//         if (ext == 'pdf') {
//           mimeType = 'application/pdf';
//         } else if (ext == 'jpg' || ext == 'jpeg') {
//           mimeType = 'image/jpeg';
//         } else if (ext == 'png') {
//           mimeType = 'image/png';
//         }

//         if (mimeType.isNotEmpty) {
//           final base64String = 'data:$mimeType;base64,${base64Encode(bytes)}';

//           /// 🔥 Here’s where your API call happens
//           showLoaderDialog(context);
//           var result =
//               await Get.find<CustomerProfileController>().uploadDocument(
//             context: context,
//             body: {"doc_type": widget.docType, "base64": base64String},
//           );

//           if (result != "false") {
//             if (mounted) Navigator.pop(context); // Close the loader dialog
//             Navigator.pop(context);
//             CustomSnackBar.show(context, 'File uploaded successfully');
//             // Handle successful upload
//           } else {
//             if (mounted) Navigator.pop(context); // Close the loader dialog
//             CustomSnackBar.show(context, 'Failed to upload file');
//           }
//         } else {
//           if (mounted) Navigator.pop(context); // Close the loader dialog
//           CustomSnackBar.show(context, 'Unsupported file type');
//         }
//       } else {
//         if (mounted) Navigator.pop(context); // Close the loader dialog
//         CustomSnackBar.show(context, 'Unsupported file type');
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Failed to upload file'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       title: const Text(
//         'Upload Document',
//         style: TextStyle(fontWeight: FontWeight.w600),
//       ),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const Text('Select an image or PDF file to upload.'),
//           const SizedBox(height: 20),
//           GestureDetector(
//             onTap: _pickFile,
//             child: Container(
//               padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
//               decoration: BoxDecoration(
//                 border: Border.all(color: AppColors.primaryColor),
//                 borderRadius: BorderRadius.circular(8),
//                 color: Colors.grey.shade100,
//               ),
//               child: Row(
//                 children: [
//                   const Icon(Icons.attach_file, color: AppColors.primaryColor),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Text(
//                       selectedFile?.name ?? 'Choose file',
//                       style: TextStyle(
//                         color: selectedFile != null
//                             ? AppColors.textColor
//                             : Colors.grey,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                   const Icon(Icons.folder_open, color: AppColors.primaryColor),
//                 ],
//               ),
//             ),
//           ),

//           /// File Preview
//           // if (selectedFile != null) ...[
//           //   const SizedBox(height: 12),
//           //   if (selectedFile!.extension?.toLowerCase() == 'pdf')
//           //     Row(
//           //       children: [
//           //         const Icon(Icons.picture_as_pdf,
//           //             color: AppColors.primaryColor),
//           //         const SizedBox(width: 8),
//           //         Expanded(
//           //           child: Text(
//           //             selectedFile!.name,
//           //             style: const TextStyle(fontWeight: FontWeight.w500),
//           //           ),
//           //         ),
//           //       ],
//           //     )
//           //   else if (previewPath != null)
//           //     SizedBox(
//           //       height: 150,
//           //       child: ClipRRect(
//           //         borderRadius: BorderRadius.circular(8),
//           //         child: Image.file(
//           //           File(previewPath!),
//           //           fit: BoxFit.cover,
//           //         ),
//           //       ),
//           //     ),
//           // ],
//         ],
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: const Text('Cancel'),
//         ),
//         ElevatedButton(
//           onPressed: selectedFile == null ? null : _submitFile,
//           style: ElevatedButton.styleFrom(
//             backgroundColor: AppColors.primaryColor,
//             foregroundColor: Colors.white,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//           ),
//           child: const Text('Submit'),
//         ),
//       ],
//     );
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overseas_front_end/view/widgets/custom_snackbar.dart';

import '../../../../controller/registration/registration_controller.dart';
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
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      withData: true,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        selectedFile = result.files.single;
        previewPath = selectedFile?.path;
      });
    }
  }

  Future<void> _submitFile() async {
    if (selectedFile == null) return;
    try {
      Uint8List? bytes = selectedFile!.bytes;

      if (bytes == null && selectedFile!.path != null) {
        bytes = await File(selectedFile!.path!).readAsBytes();
      }

      if (bytes != null) {
        String mimeType = '';
        final ext = selectedFile!.extension?.toLowerCase();
        if (ext == 'pdf') {
          mimeType = 'application/pdf';
        } else if (ext == 'jpg' || ext == 'jpeg') {
          mimeType = 'image/jpeg';
        } else if (ext == 'png') {
          mimeType = 'image/png';
        }

        if (mimeType.isNotEmpty) {
          final base64String = 'data:$mimeType;base64,${base64Encode(bytes)}';

          /// 🔥 Here’s where your API call happens
          showLoaderDialog(context);
          var result = await Get.find<RegistrationController>()
              .updateClientRequiredDocuments(
            docType: widget.docType,
            base64String: base64String,
          );

          if (result != "false") {
            if (mounted) Navigator.pop(context); // Close the loader dialog
            Navigator.pop(context);
            CustomSnackBar.show(context, 'File uploaded successfully');
            // Handle successful upload
          } else {
            if (mounted) Navigator.pop(context); // Close the loader dialog
            CustomSnackBar.show(context, 'Failed to upload file');
          }
        } else {
          if (mounted) Navigator.pop(context); // Close the loader dialog
          CustomSnackBar.show(context, 'Unsupported file type');
        }
      } else {
        if (mounted) Navigator.pop(context); // Close the loader dialog
        CustomSnackBar.show(context, 'Unsupported file type');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to upload file'),
            backgroundColor: Colors.red,
          ),
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
                    ),
                  ),
                  const Icon(Icons.folder_open, color: AppColors.primaryColor),
                ],
              ),
            ),
          ),

          /// File Preview
          // if (selectedFile != null) ...[
          //   const SizedBox(height: 12),
          //   if (selectedFile!.extension?.toLowerCase() == 'pdf')
          //     Row(
          //       children: [
          //         const Icon(Icons.picture_as_pdf,
          //             color: AppColors.primaryColor),
          //         const SizedBox(width: 8),
          //         Expanded(
          //           child: Text(
          //             selectedFile!.name,
          //             style: const TextStyle(fontWeight: FontWeight.w500),
          //           ),
          //         ),
          //       ],
          //     )
          //   else if (previewPath != null)
          //     SizedBox(
          //       height: 150,
          //       child: ClipRRect(
          //         borderRadius: BorderRadius.circular(8),
          //         child: Image.file(
          //           File(previewPath!),
          //           fit: BoxFit.cover,
          //         ),
          //       ),
          //     ),
          // ],
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

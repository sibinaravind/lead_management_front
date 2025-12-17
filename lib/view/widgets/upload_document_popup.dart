import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:overseas_front_end/view/widgets/custom_dropdown_field.dart';
import 'package:overseas_front_end/view/widgets/widgets.dart';

class UploadDocumentPopup extends StatefulWidget {
  final bool allowMultiple;
  final List<String>? items;
  final Function(Map<String, dynamic>) onSave;
  final bool onlyImages;
  final bool noDocType;

  const UploadDocumentPopup({
    super.key,
    required this.onSave,
    this.allowMultiple = false,
    this.items,
    this.onlyImages = false,
    this.noDocType = false,
  });

  @override
  State<UploadDocumentPopup> createState() => _ModernUploadPopupState();
}

class _ModernUploadPopupState extends State<UploadDocumentPopup> {
  String selectedDocType = "";
  TextEditingController selectedDocTypeController = TextEditingController();
  List<Map<String, dynamic>> files = [];
  bool isProcessing = false;

  // File size limits
  static const int maxImageSize = 2 * 1024 * 1024; // 2MB for images
  static const int maxPdfSize = 5 * 1024 * 1024; // 5MB for PDFs
  static const int imageQuality = 85; // JPEG quality (0-100)
  static const int maxImageDimension = 1920; // Max width/height

  @override
  void initState() {
    super.initState();
    if ((widget.items ?? []).isNotEmpty) {
      selectedDocType = widget.items?.first ?? "";
    }
    if (widget.noDocType) {
      selectedDocType = "Doc";
    }
  }

  Future<void> pickFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: widget.allowMultiple,
        type: FileType.custom,
        allowedExtensions: widget.onlyImages
            ? ['jpg', 'jpeg', 'png']
            : ['jpg', 'jpeg', 'png', 'pdf'],
        withData: true,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() => isProcessing = true);

        // Process files in background
        final processedFiles = await _processFilesInBackground(result.files);

        if (mounted) {
          setState(() {
            files = processedFiles;
            isProcessing = false;
          });
        }
      }
    } catch (e) {
      debugPrint('Error picking files: $e');
      if (mounted) {
        setState(() => isProcessing = false);
        _showError('Error selecting files: ${e.toString()}');
      }
    }
  }

  Future<List<Map<String, dynamic>>> _processFilesInBackground(
      List<PlatformFile> platformFiles) async {
    List<Map<String, dynamic>> processedFiles = [];

    for (var file in platformFiles) {
      try {
        if (file.bytes == null) continue;

        String ext = file.extension?.toLowerCase() ?? "";
        String mime = _getMimeType(ext);

        // Validate file size before processing
        if (_isImageFile(ext)) {
          if (file.bytes!.length > maxImageSize * 2) {
            // Allow 2x for compression
            _showError(
                '${file.name} is too large. Max size for images: ${maxImageSize / (1024 * 1024)}MB');
            continue;
          }
        } else if (ext == 'pdf') {
          if (file.bytes!.length > maxPdfSize) {
            _showError(
                '${file.name} is too large. Max size for PDFs: ${maxPdfSize / (1024 * 1024)}MB');
            continue;
          }
        }

        // Process file based on type
        String base64String;
        if (_isImageFile(ext)) {
          // Compress and encode image in isolate
          base64String = await _compressAndEncodeImage(file.bytes!, ext);
        } else {
          // For PDFs, just encode in isolate
          base64String = await compute(_encodeBase64, file.bytes!);
        }

        // Format with data URI (no space after comma)
        final formattedBase64 = _formatBase64WithDataUri(base64String, mime);

        processedFiles.add({
          "mime": mime,
          "base64": formattedBase64,
          "name": file.name,
          "size": file.bytes!.length,
        });
      } catch (e) {
        debugPrint('Error processing ${file.name}: $e');
        _showError('Failed to process ${file.name}');
      }
    }

    return processedFiles;
  }

  bool _isImageFile(String ext) {
    return ext == 'jpg' || ext == 'jpeg' || ext == 'png';
  }

  Future<String> _compressAndEncodeImage(
      Uint8List bytes, String extension) async {
    return await compute(_compressImageInIsolate, {
      'bytes': bytes,
      'extension': extension,
      'quality': imageQuality,
      'maxDimension': maxImageDimension,
    });
  }

  static String _compressImageInIsolate(Map<String, dynamic> params) {
    try {
      final Uint8List bytes = params['bytes'];
      final String extension = params['extension'];
      final int quality = params['quality'];
      final int maxDimension = params['maxDimension'];

      // Decode image
      img.Image? image = img.decodeImage(bytes);
      if (image == null) {
        // If decoding fails, just encode as-is
        return base64Encode(bytes);
      }

      // Resize if too large
      if (image.width > maxDimension || image.height > maxDimension) {
        image = img.copyResize(
          image,
          width: image.width > image.height ? maxDimension : null,
          height: image.height >= image.width ? maxDimension : null,
          interpolation: img.Interpolation.linear,
        );
      }

      // Encode with compression
      Uint8List compressed;
      if (extension == 'png') {
        compressed = Uint8List.fromList(img.encodePng(image, level: 6));
      } else {
        compressed = Uint8List.fromList(img.encodeJpg(image, quality: quality));
      }

      // Use smaller version
      final finalBytes = compressed.length < bytes.length ? compressed : bytes;
      return base64Encode(finalBytes);
    } catch (e) {
      debugPrint('Error compressing image: $e');
      // Fallback to original
      return base64Encode(params['bytes']);
    }
  }

  static String _encodeBase64(Uint8List bytes) {
    return base64Encode(bytes);
  }

  String _getMimeType(String ext) {
    switch (ext.toLowerCase()) {
      case "jpg":
      case "jpeg":
        return "image/jpeg";
      case "png":
        return "image/png";
      case "pdf":
        return "application/pdf";
      default:
        return "application/octet-stream";
    }
  }

  String _formatBase64WithDataUri(String base64, String mimeType) {
    // Format: data:image/jpeg;base64,<base64_string>
    // Note: NO SPACE after the comma
    return "data:$mimeType;base64,$base64";
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void save() {
    if (selectedDocType.isEmpty) {
      _showError("Please select document type");
      return;
    }

    if (files.isEmpty) {
      _showError("Please select at least one file");
      return;
    }

    final output = {
      "doc_type": selectedDocType,
      "base64": widget.allowMultiple
          ? files.map((e) => e["base64"]).toList()
          : files.first["base64"],
    };

    widget.onSave(output);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.cloud_upload_outlined,
                      color: Colors.blue.shade700, size: 24),
                ),
                const SizedBox(width: 12),
                const Text(
                  "Upload Document",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.grey.shade100,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),
            if (widget.noDocType == false) ...[
              // Document Type Dropdown
              if (widget.items != null)
                CustomDropdownField(
                  label: 'Document Type',
                  value: selectedDocType,
                  items: (widget.items ?? []).map((e) => e).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedDocType = value ?? "";
                    });
                  },
                  isRequired: true,
                )
              else
                CustomTextFormField(
                  label: 'Document Type',
                  controller: selectedDocTypeController,
                  onChanged: (value) {
                    selectedDocType = value;
                  },
                ),

              const SizedBox(height: 24),
            ],
            // Processing indicator or upload/preview area
            if (isProcessing)
              _buildProcessingIndicator()
            else if (files.isEmpty)
              _buildUploadArea()
            else
              _buildPreviewArea(),

            const SizedBox(height: 24),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: isProcessing ? null : () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Cancel"),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: isProcessing || files.isEmpty ? null : save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade300,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Save"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProcessingIndicator() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.blue.shade50,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 48,
            height: 48,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade700),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Processing files...",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.blue.shade900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Compressing and optimizing",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadArea() {
    return InkWell(
      onTap: pickFiles,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.blue.shade300, width: 2),
          color: Colors.blue.shade50,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.shade100,
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Icon(
                Icons.cloud_upload_outlined,
                size: 48,
                color: Colors.blue.shade700,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.allowMultiple ? "Upload Files" : "Upload File",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.blue.shade900,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "JPG, PNG (max 2MB) • PDF (max 5MB)",
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Images will be automatically compressed",
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade500,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey.shade50,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Selected ${widget.allowMultiple ? 'Files' : 'File'} (${files.length})",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton.icon(
                onPressed: pickFiles,
                icon: const Icon(Icons.refresh, size: 18),
                label: const Text("Reselect"),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 140,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: files.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final file = files[index];
                final mime = file["mime"];
                final base64 = file["base64"];
                final name = file["name"] ?? "File ${index + 1}";
                final size = file["size"] ?? 0;

                return Container(
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Preview
                      Expanded(
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12)),
                              child: mime.contains("pdf")
                                  ? Container(
                                      color: Colors.red.shade50,
                                      child: Center(
                                        child: Icon(Icons.picture_as_pdf,
                                            size: 48,
                                            color: Colors.red.shade700),
                                      ),
                                    )
                                  : Image.memory(
                                      base64Decode(base64.split(',').last),
                                      width: double.infinity,
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Container(
                                        color: Colors.grey.shade200,
                                        child: Icon(Icons.broken_image,
                                            size: 32,
                                            color: Colors.grey.shade400),
                                      ),
                                    ),
                            ),
                            // Delete button
                            Positioned(
                              right: 6,
                              top: 6,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() => files.removeAt(index));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.red.shade600,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // File name and size
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Text(
                              name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _formatFileSize(size),
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}

// import 'dart:convert';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:overseas_front_end/view/widgets/custom_dropdown_field.dart';

// class UploadDocumentPopup extends StatefulWidget {
//   final bool allowMultiple;
//   final List<String> items;
//   final Function(Map<String, dynamic>) onSave;

//   const UploadDocumentPopup({
//     super.key,
//     required this.onSave,
//     this.allowMultiple = false,
//     this.items = const ['Passport', 'Aadhaar', 'Pan', 'Degree', 'Certificate'],
//   });

//   @override
//   State<UploadDocumentPopup> createState() => _ModernUploadPopupState();
// }

// class _ModernUploadPopupState extends State<UploadDocumentPopup> {
//   String selectedDocType = "";
//   List<Map<String, dynamic>> files = [];

//   @override
//   void initState() {
//     super.initState();
//     if (widget.items.isNotEmpty) {
//       selectedDocType = widget.items.first;
//     }
//   }

//   Future<void> pickFiles() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       allowMultiple: widget.allowMultiple,
//       type: FileType.custom,
//       allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
//       withData: true, // Important: load file bytes
//     );

//     if (result != null) {
//       files.clear();

//       for (var file in result.files) {
//         if (file.bytes != null) {
//           String ext = file.extension ?? "";
//           String mime = _getMimeType(ext);
//           String base64 = base64Encode(file.bytes!);

//           files.add({
//             "mime": mime,
//             "base64": base64,
//             "name": file.name,
//           });
//         }
//       }

//       setState(() {});
//     }
//   }

//   String _getMimeType(String ext) {
//     switch (ext.toLowerCase()) {
//       case "jpg":
//       case "jpeg":
//         return "image/jpeg";
//       case "png":
//         return "image/png";
//       case "pdf":
//         return "application/pdf";
//       default:
//         return "application/octet-stream";
//     }
//   }

//   void save() {
//     // if (selectedDocType.isEmpty) {
//     //   ScaffoldMessenger.of(context).showSnackBar(
//     //     SnackBar(
//     //       content: const Text("Please select document type"),
//     //       behavior: SnackBarBehavior.floating,
//     //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//     //     ),
//     //   );
//     //   return;
//     // }

//     // if (files.isEmpty) {
//     //   ScaffoldMessenger.of(context).showSnackBar(
//     //     SnackBar(
//     //       content: const Text("Please select at least one file"),
//     //       behavior: SnackBarBehavior.floating,
//     //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//     //     ),
//     //   );
//     //   return;
//     // }

//     final output = {
//       "doc_type": selectedDocType,
//       "base64": widget.allowMultiple
//           ? files.map((e) => e["base64"]).toList()
//           : files.first["base64"],
//     };

//     widget.onSave(output);
//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       child: Container(
//         constraints: const BoxConstraints(maxWidth: 500),
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Header
//             Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     color: Colors.blue.shade50,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Icon(Icons.cloud_upload_outlined,
//                       color: Colors.blue.shade700, size: 24),
//                 ),
//                 const SizedBox(width: 12),
//                 const Text(
//                   "Upload Document",
//                   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                 ),
//                 const Spacer(),
//                 IconButton(
//                   onPressed: () => Navigator.pop(context),
//                   icon: const Icon(Icons.close),
//                   style: IconButton.styleFrom(
//                     backgroundColor: Colors.grey.shade100,
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 24),

//             // Document Type Dropdown
//             CustomDropdownField(
//               label: 'Status',
//               value: selectedDocType,
//               items: widget.items.map((e) => e).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedDocType = value ?? "";
//                 });
//               },
//               isRequired: true,
//             ),

//             const SizedBox(height: 24),

//             // Upload Area or Preview
//             if (files.isEmpty) _buildUploadArea() else _buildPreviewArea(),

//             const SizedBox(height: 24),

//             // Action Buttons
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 OutlinedButton(
//                   onPressed: () => Navigator.pop(context),
//                   style: OutlinedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 24, vertical: 12),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: const Text("Cancel"),
//                 ),
//                 const SizedBox(width: 12),
//                 ElevatedButton(
//                   onPressed: save,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue.shade700,
//                     foregroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 32, vertical: 12),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: const Text("Save"),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildUploadArea() {
//     return InkWell(
//       onTap: pickFiles,
//       borderRadius: BorderRadius.circular(16),
//       child: Container(
//         height: 200,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(color: Colors.blue.shade300, width: 2),
//           color: Colors.blue.shade50,
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 shape: BoxShape.circle,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.blue.shade100,
//                     blurRadius: 12,
//                     spreadRadius: 2,
//                   ),
//                 ],
//               ),
//               child: Icon(
//                 Icons.cloud_upload_outlined,
//                 size: 48,
//                 color: Colors.blue.shade700,
//               ),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               widget.allowMultiple ? "Upload Files" : "Upload File",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.blue.shade900,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               "Supported: JPG, PNG, PDF",
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey.shade600,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPreviewArea() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         color: Colors.grey.shade50,
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Selected ${widget.allowMultiple ? 'Files' : 'File'} (${files.length})",
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               TextButton.icon(
//                 onPressed: pickFiles,
//                 icon: const Icon(Icons.refresh, size: 18),
//                 label: const Text("Reselect"),
//                 style: TextButton.styleFrom(
//                   foregroundColor: Colors.blue.shade700,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           SizedBox(
//             height: 140,
//             child: ListView.separated(
//               scrollDirection: Axis.horizontal,
//               itemCount: files.length,
//               separatorBuilder: (_, __) => const SizedBox(width: 12),
//               itemBuilder: (context, index) {
//                 final file = files[index];
//                 final mime = file["mime"];
//                 final base64 = file["base64"];
//                 final name = file["name"] ?? "File ${index + 1}";

//                 return Container(
//                   width: 120,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.shade200,
//                         blurRadius: 4,
//                         spreadRadius: 1,
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       // Preview
//                       Expanded(
//                         child: Stack(
//                           children: [
//                             ClipRRect(
//                               borderRadius: const BorderRadius.vertical(
//                                   top: Radius.circular(12)),
//                               child: mime.contains("pdf")
//                                   ? Container(
//                                       color: Colors.red.shade50,
//                                       child: Center(
//                                         child: Icon(Icons.picture_as_pdf,
//                                             size: 48,
//                                             color: Colors.red.shade700),
//                                       ),
//                                     )
//                                   : Image.memory(
//                                       base64Decode(base64),
//                                       width: double.infinity,
//                                       height: double.infinity,
//                                       fit: BoxFit.cover,
//                                     ),
//                             ),
//                             // Delete button
//                             Positioned(
//                               right: 6,
//                               top: 6,
//                               child: GestureDetector(
//                                 onTap: () {
//                                   setState(() => files.removeAt(index));
//                                 },
//                                 child: Container(
//                                   padding: const EdgeInsets.all(6),
//                                   decoration: BoxDecoration(
//                                     color: Colors.red.shade600,
//                                     shape: BoxShape.circle,
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.black.withOpacity(0.2),
//                                         blurRadius: 4,
//                                       ),
//                                     ],
//                                   ),
//                                   child: const Icon(
//                                     Icons.close,
//                                     size: 14,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       // File name
//                       Padding(
//                         padding: const EdgeInsets.all(8),
//                         child: Text(
//                           name,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.grey.shade700,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:overseas_front_end/utils/style/colors/colors.dart';

// import '../../../widgets/widgets.dart';

// class UploadDocumentsPopup extends StatefulWidget {
//   final Function(List<Map<String, dynamic>>) onSave;
//   final bool allowMultipleFiles;

//   const UploadDocumentsPopup({
//     super.key,
//     required this.onSave,
//     this.allowMultipleFiles = true,
//   });

//   @override
//   State<UploadDocumentsPopup> createState() => _UploadDocumentsPopupState();
// }

// class _UploadDocumentsPopupState extends State<UploadDocumentsPopup> {
//   List<DocumentItem> _documents = [];
//   final List<File> _selectedFiles = [];
//   final _formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     super.initState();
//   }

//   void _addDocument() {
//     setState(() {
//       _documents.add(DocumentItem(
//         docType: '',
//         filePath: '',
//         updatedAt: DateTime.now().toIso8601String(),
//         fileName: '',
//         fileSize: '',
//       ));
//     });
//   }

//   void _removeDocument(int index) {
//     if (_documents.length > 1) {
//       setState(() {
//         _documents.removeAt(index);
//       });
//     }
//   }

//   Future<void> _pickFiles() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       allowMultiple: widget.allowMultipleFiles,
//       type: FileType.custom,
//       allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png', 'txt'],
//     );

//     if (result != null) {
//       setState(() {
//         _selectedFiles.addAll(result.paths.map((path) => File(path!)).toList());
//       });
//       _showFileSelectionSuccess(result.files.length);
//     }
//   }

//   void _showFileSelectionSuccess(int count) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('$count file(s) selected successfully'),
//         backgroundColor: Colors.green,
//       ),
//     );
//   }

//   Future<void> _saveDocuments() async {
//     if (_formKey.currentState!.validate()) {
//       // Process uploaded files
//       final List<Map<String, dynamic>> documentsList = [];

//       // Add existing documents
//       for (var doc in _documents) {
//         if (doc.docType.isNotEmpty) {
//           documentsList.add({
//             'doc_type': doc.docType,
//             'file_path': doc.filePath,
//             'updated_at': doc.updatedAt,
//             'file_name': doc.fileName,
//             'file_size': doc.fileSize,
//           });
//         }
//       }

//       // Add new uploaded files
//       for (var file in _selectedFiles) {
//         documentsList.add({
//           'doc_type': _getDocumentType(file.path),
//           'file_path': file.path,
//           'updated_at': DateTime.now().toIso8601String(),
//           'file_name': file.path.split('/').last,
//           'file_size': '${(file.lengthSync() / 1024).toStringAsFixed(2)} KB',
//         });
//       }

//       widget.onSave(documentsList);
//       Navigator.of(context).pop();
//     }
//   }

//   String _getDocumentType(String filePath) {
//     final ext = filePath.split('.').last.toLowerCase();
//     switch (ext) {
//       case 'pdf':
//         return 'pdf';
//       case 'doc':
//       case 'docx':
//         return 'word';
//       case 'jpg':
//       case 'jpeg':
//       case 'png':
//         return 'image';
//       case 'txt':
//         return 'text';
//       default:
//         return 'other';
//     }
//   }

//   IconData _getDocumentIcon(String docType) {
//     switch (docType.toLowerCase()) {
//       case 'passport':
//         return Icons.book_online;
//       case 'aadhaar':
//       case 'pan':
//         return Icons.badge;
//       case 'degree':
//       case 'certificate':
//         return Icons.school;
//       case 'photo':
//         return Icons.photo;
//       case 'resume':
//         return Icons.description;
//       case 'pdf':
//         return Icons.picture_as_pdf;
//       case 'word':
//         return Icons.description;
//       case 'image':
//         return Icons.image;
//       default:
//         return Icons.insert_drive_file;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       child: Container(
//         width: 700,
//         constraints: const BoxConstraints(maxHeight: 600),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.2),
//               blurRadius: 20,
//               spreadRadius: 0,
//             ),
//           ],
//         ),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // Header
//               Container(
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: AppColors.primaryColor,
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(16),
//                     topRight: Radius.circular(16),
//                   ),
//                 ),
//                 child: Row(
//                   children: [
//                     const Icon(
//                       Icons.cloud_upload_rounded,
//                       color: Colors.white,
//                       size: 24,
//                     ),
//                     const SizedBox(width: 12),
//                     const Expanded(
//                       child: Text(
//                         'Upload Documents',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.close, color: Colors.white),
//                       onPressed: () => Navigator.of(context).pop(),
//                     ),
//                   ],
//                 ),
//               ),

//               // Content
//               Expanded(
//                 child: SingleChildScrollView(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     children: [
//                       // File Upload Section
//                       Container(
//                         padding: const EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: Colors.blue.shade50,
//                           borderRadius: BorderRadius.circular(12),
//                           border: Border.all(color: Colors.blue.shade100),
//                         ),
//                         child: Column(
//                           children: [
//                             const Icon(
//                               Icons.cloud_upload,
//                               size: 48,
//                               color: Colors.blue,
//                             ),
//                             const SizedBox(height: 16),
//                             const Text(
//                               'Upload Documents',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.blue,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               widget.allowMultipleFiles
//                                   ? 'Select multiple files (PDF, Word, Images, Text)'
//                                   : 'Select a file (PDF, Word, Images, Text)',
//                               style: TextStyle(color: Colors.grey.shade600),
//                               textAlign: TextAlign.center,
//                             ),
//                             const SizedBox(height: 16),
//                             CustomActionButton(
//                               text: 'Browse Files',
//                               icon: Icons.folder_open,
//                               onPressed: _pickFiles,
//                               backgroundColor: Colors.white,
//                               textColor: Colors.blue,
//                               borderColor: Colors.blue,
//                             ),
//                           ],
//                         ),
//                       ),

//                       // Selected Files List
//                       if (_selectedFiles.isNotEmpty) ...[
//                         const SizedBox(height: 20),
//                         const Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             'Selected Files:',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         ..._selectedFiles.asMap().entries.map((entry) {
//                           final index = entry.key;
//                           final file = entry.value;
//                           return _buildFileItem(index, file);
//                         }).toList(),
//                       ],

//                       const SizedBox(height: 24),

//                       // Existing Documents
//                       const Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           'Document Details',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: AppColors.primaryColor,
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 16),

//                       // Document List
//                       ..._documents.asMap().entries.map((entry) {
//                         final index = entry.key;
//                         final document = entry.value;
//                         return _buildDocumentCard(index, document);
//                       }).toList(),

//                       // Add Document Button
//                       Container(
//                         margin: const EdgeInsets.only(top: 16),
//                         child: CustomActionButton(
//                           text: 'Add Another Document',
//                           icon: Icons.add,
//                           onPressed: _addDocument,
//                           backgroundColor:
//                               AppColors.primaryColor.withOpacity(0.1),
//                           textColor: AppColors.primaryColor,
//                           borderColor: AppColors.primaryColor.withOpacity(0.3),
//                         ),
//                       ),

//                       const SizedBox(height: 32),

//                       // Save Button
//                       Row(
//                         children: [
//                           Expanded(
//                             child: CustomActionButton(
//                               text: 'Cancel',
//                               icon: Icons.close,
//                               onPressed: () => Navigator.of(context).pop(),
//                               textColor: Colors.grey,
//                               borderColor: Colors.grey.shade300,
//                             ),
//                           ),
//                           const SizedBox(width: 16),
//                           Expanded(
//                             child: CustomActionButton(
//                               text: 'Upload Documents',
//                               icon: Icons.cloud_upload,
//                               isFilled: true,
//                               gradient: const LinearGradient(
//                                 colors: [
//                                   Color(0xFF7F00FF),
//                                   Color(0xFFE100FF),
//                                 ],
//                               ),
//                               onPressed: _saveDocuments,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildFileItem(int index, File file) {
//     final fileName = file.path.split('/').last;
//     final fileSize = '${(file.lengthSync() / 1024).toStringAsFixed(2)} KB';

//     return Container(
//       margin: const EdgeInsets.only(bottom: 8),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade50,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: Row(
//         children: [
//           Icon(
//             _getDocumentIcon(fileName.split('.').last),
//             color: AppColors.primaryColor,
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   fileName,
//                   style: const TextStyle(fontWeight: FontWeight.w500),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 Text(
//                   fileSize,
//                   style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
//                 ),
//               ],
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.close, color: Colors.red, size: 18),
//             onPressed: () {
//               setState(() {
//                 _selectedFiles.removeAt(index);
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDocumentCard(int index, DocumentItem document) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 16),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Document Header
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Icon(
//                       _getDocumentIcon(document.docType),
//                       color: AppColors.primaryColor,
//                     ),
//                     const SizedBox(width: 8),
//                     Text(
//                       'Document ${index + 1}',
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.primaryColor,
//                       ),
//                     ),
//                   ],
//                 ),
//                 if (_documents.length > 1)
//                   IconButton(
//                     icon: const Icon(Icons.delete, color: Colors.red),
//                     onPressed: () => _removeDocument(index),
//                     tooltip: 'Remove Document',
//                   ),
//               ],
//             ),

//             const SizedBox(height: 16),

//             // Document Details
//             CustomDropdownField(
//               label: 'Document Type *',
//               value: document.docType,
//               items: const [
//                 'passport',
//                 'aadhaar',
//                 'pan',
//                 'degree',
//                 'certificate',
//                 'photo',
//                 'resume',
//                 'offer_letter',
//                 'salary_slip',
//                 'bank_statement',
//                 'visa',
//                 'ticket',
//                 'hotel_voucher',
//                 'insurance',
//                 'other',
//               ],
//               onChanged: (value) {
//                 setState(() {
//                   _documents[index].docType = value ?? '';
//                 });
//               },
//               // validator: (value) {
//               //   if (value == null || value.isEmpty) {
//               //     return 'Please select document type';
//               //   }
//               //   return null;
//               // },
//             ),

//             const SizedBox(height: 12),

//             Row(
//               children: [
//                 Expanded(
//                   child: CustomTextFormField(
//                     label: 'File URL/Path',
//                     controller: TextEditingController(text: document.filePath),
//                     onChanged: (value) {
//                       setState(() {
//                         _documents[index].filePath = value;
//                       });
//                     },
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter file URL or path';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: CustomTextFormField(
//                     label: 'File Name',
//                     controller: TextEditingController(text: document.fileName),
//                     onChanged: (value) {
//                       setState(() {
//                         _documents[index].fileName = value;
//                       });
//                     },
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 12),

//             Row(
//               children: [
//                 Expanded(
//                   child: CustomTextFormField(
//                     label: 'File Size',
//                     controller: TextEditingController(text: document.fileSize),
//                     onChanged: (value) {
//                       setState(() {
//                         _documents[index].fileSize = value;
//                       });
//                     },
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: CustomTextFormField(
//                     label: 'Updated At',
//                     controller: TextEditingController(text: document.updatedAt),
//                     readOnly: true,
//                     // suffixIcon: Icons.calendar_today,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Data Model
// class DocumentItem {
//   String docType;
//   String filePath;
//   String updatedAt;
//   String fileName;
//   String fileSize;

//   DocumentItem({
//     required this.docType,
//     required this.filePath,
//     required this.updatedAt,
//     required this.fileName,
//     required this.fileSize,
//   });
// }

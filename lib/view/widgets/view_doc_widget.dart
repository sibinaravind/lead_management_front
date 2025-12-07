import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:overseas_front_end/config/flavour_config.dart';
import 'package:overseas_front_end/core/di/service_locator.dart';
import 'package:printing/printing.dart';
import '../../utils/style/colors/colors.dart';
import 'custom_text.dart';

class ViewDocWidget extends StatefulWidget {
  final String fileUrl;
  final String fileName;

  const ViewDocWidget({
    super.key,
    required this.fileUrl,
    required this.fileName,
  });

  @override
  State<ViewDocWidget> createState() => _ViewDocWidgetState();
}

class _ViewDocWidgetState extends State<ViewDocWidget> {
  String _loadingMessage = "Loading document...";
  Uint8List? _fileBytes;
  bool _isLoading = true;
  String? _error;
  String? _textContent;
  String _fileType = 'unknown';

  bool _isPdfBytes(Uint8List data) {
    return data.length > 4 &&
        data[0] == 0x25 && // %
        data[1] == 0x50 && // P
        data[2] == 0x44 && // D
        data[3] == 0x46; // F
  }

  bool _isImageBytes(Uint8List data) {
    if (data.length < 4) return false;

    // JPEG
    if (data[0] == 0xFF && data[1] == 0xD8 && data[2] == 0xFF) return true;

    // PNG
    if (data[0] == 0x89 &&
        data[1] == 0x50 &&
        data[2] == 0x4E &&
        data[3] == 0x47) return true;

    // GIF
    if (data[0] == 0x47 &&
        data[1] == 0x49 &&
        data[2] == 0x46 &&
        data[3] == 0x38) return true;

    // WebP (RIFF header)
    if (data[0] == 0x52 &&
        data[1] == 0x49 &&
        data[2] == 0x46 &&
        data[3] == 0x46) return true;

    return false;
  }

  Future<void> _loadFile() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
        _loadingMessage = "Downloading file...";
        _fileBytes = null;
        _textContent = null;
      });

      final ext = widget.fileUrl.split('.').last.toLowerCase();

      // Determine file type
      if (ext == 'pdf') {
        _fileType = 'pdf';
      } else if (['jpg', 'jpeg', 'png', 'gif', 'webp'].contains(ext)) {
        _fileType = 'image';
      } else if (ext == 'txt') {
        _fileType = 'text';
      } else {
        _fileType = 'unknown';
      }

      if (_fileType == 'text') {
        await _loadTextFile();
      } else {
        await _loadBinaryFile();
      }
    } catch (e) {
      setState(() {
        _error = 'Failed to load document: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _loadBinaryFile() async {
    final response = await http.get(Uri.parse(widget.fileUrl));

    if (response.statusCode != 200) {
      throw Exception('Failed to load file: ${response.statusCode}');
    }

    final bytes = response.bodyBytes;

    // Validate file type
    if (_fileType == 'pdf' && !_isPdfBytes(bytes)) {
      throw Exception('Downloaded content is not a valid PDF');
    }

    if (_fileType == 'image' && !_isImageBytes(bytes)) {
      throw Exception('Downloaded content is not a valid image');
    }

    setState(() {
      _fileBytes = bytes;
      _isLoading = false;
    });
  }

  Future<void> _loadTextFile() async {
    final Dio dio = serviceLocator();
    final response = await dio.get(
      widget.fileUrl,
      options: Options(responseType: ResponseType.plain),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load text file: ${response.statusCode}');
    }

    final body = response.data.toString();
    final cleaned = body.contains(',') ? body.split(',').last : body.trim();

    try {
      // Try to decode as base64 first
      final decoded = base64Decode(cleaned);

      if (_isPdfBytes(decoded)) {
        _fileType = 'pdf';
        setState(() {
          _fileBytes = decoded;
          _isLoading = false;
        });
      } else if (_isImageBytes(decoded)) {
        _fileType = 'image';
        setState(() {
          _fileBytes = decoded;
          _isLoading = false;
        });
      } else {
        // If not binary, treat as text
        _fileType = 'text';
        setState(() {
          _textContent = utf8.decode(decoded);
          _isLoading = false;
        });
      }
    } on FormatException {
      // Not base64, treat as plain text
      _fileType = 'text';
      setState(() {
        _textContent = body;
        _isLoading = false;
      });
    }
  }

  Widget _buildPdfViewer() {
    return SizedBox(
      // height: MediaQuery.of(context).size.height * 0.9,
      width: MediaQuery.of(context).size.width > 700
          ? 700
          : MediaQuery.of(context).size.width,
      child: PdfPreview(
        build: (format) => _fileBytes!,
        allowSharing: false,
        allowPrinting: false,
        canChangePageFormat: false,
        canDebug: false,
        canChangeOrientation: false,
        // initialPageFormat: PdfPageFormat.a4,
        // maxPageWidth: 700,
        pdfFileName: widget.fileName,
      ),
    );
  }

  Widget _buildImageViewer() {
    return InteractiveViewer(
      panEnabled: true,
      minScale: 0.5,
      maxScale: 4.0,
      child: Center(
        child: Image.memory(
          _fileBytes!,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text('Failed to display image: $error'),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextViewer() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SelectableText(
        _textContent!,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            FlavourConfig.appLogo(),
            fit: BoxFit.contain,
            height: 100,
            width: 200,
          ),
          const SizedBox(height: 20),
          const CircularProgressIndicator(color: Colors.white),
          const SizedBox(height: 12),
          CustomText(text: _loadingMessage),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          CustomText(
            text: _error ?? 'Unknown error occurred',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _loadFile,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildUnsupportedState() {
    return const Center(
      child: CustomText(text: 'Unsupported file format'),
    );
  }

  Widget _buildContent() {
    if (_isLoading) return _buildLoadingState();
    if (_error != null) return _buildErrorState();

    switch (_fileType) {
      case 'pdf':
        return _fileBytes != null ? _buildPdfViewer() : _buildErrorState();
      case 'image':
        return _fileBytes != null ? _buildImageViewer() : _buildErrorState();
      case 'text':
        return _textContent != null ? _buildTextViewer() : _buildErrorState();
      default:
        return _buildUnsupportedState();
    }
  }

  @override
  void initState() {
    super.initState();
    _loadFile();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
        maxWidth: 1000,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              // color: AppColors.primaryColor.withOpacity(0.05),
              color: AppColors.primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                const SizedBox(width: 12),
                Expanded(
                  child: CustomText(
                    text: widget.fileName,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteMainColor,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:pdf/pdf.dart';
// import 'package:printing/printing.dart';

// class ViewDocWidget extends StatefulWidget {
//   final String fileUrl;
//   final String fileName;

//   const ViewDocWidget({
//     super.key,
//     required this.fileUrl,
//     required this.fileName,
//   });

//   @override
//   State<ViewDocWidget> createState() => _ViewDocWidgetState();
// }

// class _ViewDocWidgetState extends State<ViewDocWidget> {
//   String _loadingMessage = "Loading document...";
//   Uint8List? _fileBytes;
//   bool _isLoading = true;
//   String? _error;
//   String? _textContent;
//   bool _isPdf = true;

//   // bool _isPdfBytes(Uint8List data) {
//   //   return data.length > 4 &&
//   //       data[0] == 0x25 &&
//   //       data[1] == 0x50 &&
//   //       data[2] == 0x44 &&
//   //       data[3] == 0x46;
//   // }

//   // bool _isImageBytes(Uint8List data) {
//   //   if (data.length > 4) {
//   //     if (data[0] == 0xFF && data[1] == 0xD8 && data[2] == 0xFF) {
//   //       return true; // JPEG
//   //     }
//   //     if (data[0] == 0x89 &&
//   //         data[1] == 0x50 &&
//   //         data[2] == 0x4E &&
//   //         data[3] == 0x47) {
//   //       return true; // PNG
//   //     }
//   //     if (data[0] == 0x47 &&
//   //         data[1] == 0x49 &&
//   //         data[2] == 0x46 &&
//   //         data[3] == 0x38) {
//   //       return true; // GIF
//   //     }
//   //     if (data[0] == 0x52 &&
//   //         data[1] == 0x49 &&
//   //         data[2] == 0x46 &&
//   //         data[3] == 0x46) {
//   //       return true; // WebP
//   //     }
//   //   }
//   //   return false;
//   // }

//   Future<void> _loadFile() async {
    
//   }

//   Widget _buildPdfViewer(Uint8List bytes) {
//     return SizedBox(
//       height: MediaQuery.of(context).size.height * 0.6,
//       width: 500,
//       child: PdfPreview(
//         build: (format) => bytes,
//         allowSharing: true,
//         allowPrinting: true,
//         canChangePageFormat: false,
//         initialPageFormat: PdfPageFormat.a4,
//         maxPageWidth: 700,
//         pdfFileName: widget.fileName,
//       ),
//     );
//   }

//   Widget _buildLoadingState() {
//     return SizedBox(
//       height: MediaQuery.of(context).size.height * 0.7,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const CircularProgressIndicator(),
//           const SizedBox(height: 16),
//           Text(_loadingMessage),
//         ],
//       ),
//     );
//   }

//   Widget _buildErrorState() {
//     return SizedBox(
//       height: MediaQuery.of(context).size.height * 0.7,
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.error_outline, size: 48, color: Colors.red),
//             const SizedBox(height: 16),
//             Text(
//               _error ?? 'Unknown error occurred',
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _loadFile,
//               child: const Text('Retry'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     _loadFile();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.grey[100],
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//       ),
//       constraints: BoxConstraints(
//         maxHeight: MediaQuery.of(context).size.height * 0.9,
//         maxWidth: 1000,
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     widget.fileName,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.close),
//                   onPressed: () => Navigator.of(context).pop(),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Expanded(
//               child: _isLoading
//                   ? _buildLoadingState()
//                   : _error != null
//                       ? _buildErrorState()
//                       : _fileBytes != null
//                           ? _buildPdfViewer(_fileBytes!)
//                           : _buildErrorState(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CustomText extends StatelessWidget {
//   final String text;
//   final double fontSize;
//   final TextAlign textAlign;
//   final Color color;

//   const CustomText({
//     super.key,
//     required this.text,
//     this.fontSize = 16,
//     this.textAlign = TextAlign.left,
//     this.color = Colors.black,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       text,
//       style: TextStyle(fontSize: fontSize, color: color),
//       textAlign: textAlign,
//     );
//   }
// }
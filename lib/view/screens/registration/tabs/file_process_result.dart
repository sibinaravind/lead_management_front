// file_processor_service.dart
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

enum FileType { image, pdf, unknown }

class FileProcessorResult {
  final String base64String;
  final String mimeType;
  final String fileName;
  final int originalSize;
  final int processedSize;
  final FileType fileType;
  final Uint8List bytes;

  FileProcessorResult({
    required this.base64String,
    required this.mimeType,
    required this.fileName,
    required this.originalSize,
    required this.processedSize,
    required this.fileType,
    required this.bytes,
  });

  Map<String, dynamic> toJson() => {
        'base64String': base64String,
        'mimeType': mimeType,
        'fileName': fileName,
        'originalSize': originalSize,
        'processedSize': processedSize,
        'fileType': fileType.toString(),
      };
}

class FileProcessorConfig {
  final int maxFileSizeBytes;
  final int imageQuality;
  final int maxImageWidth;
  final int maxImageHeight;
  final bool compressImages;
  final List<String> allowedExtensions;

  const FileProcessorConfig({
    this.maxFileSizeBytes = 10 * 1024 * 1024, // 10MB
    this.imageQuality = 85,
    this.maxImageWidth = 1920,
    this.maxImageHeight = 1080,
    this.compressImages = true,
    this.allowedExtensions = const ['jpg', 'jpeg', 'png', 'pdf'],
  });
}

class FileProcessorException implements Exception {
  final String message;
  final String? details;

  FileProcessorException(this.message, [this.details]);

  @override
  String toString() => details != null ? '$message: $details' : message;
}

class FileProcessorService {
  static const FileProcessorService _instance =
      FileProcessorService._internal();
  factory FileProcessorService() => _instance;
  const FileProcessorService._internal();

  /// Main method to pick and process files
  static Future<FileProcessorResult?> pickAndProcessFile({
    FileProcessorConfig config = const FileProcessorConfig(),
    VoidCallback? onProgress,
  }) async {
    try {
      // Pick file with optimized settings
      final result = await FilePicker.platform.pickFiles(
        // type: FileType.custom,
        allowedExtensions: config.allowedExtensions,
        withData: kIsWeb, // Only load data on web
        allowCompression: !kIsWeb,
        allowMultiple: false,
      );

      if (result == null || result.files.isEmpty) {
        return null;
      }

      final platformFile = result.files.first;
      return await processFile(platformFile,
          config: config, onProgress: onProgress);
    } catch (e) {
      throw FileProcessorException('File picking failed', e.toString());
    }
  }

  /// Process a PlatformFile to FileProcessorResult
  static Future<FileProcessorResult> processFile(
    PlatformFile file, {
    FileProcessorConfig config = const FileProcessorConfig(),
    VoidCallback? onProgress,
  }) async {
    try {
      // Validate file
      _validateFile(file, config);

      onProgress?.call();

      // Get file bytes efficiently
      final bytes = await _getFileBytes(file);
      final fileType = _getFileType(file.extension);

      onProgress?.call();

      // Process based on file type
      Uint8List processedBytes;
      String mimeType;

      switch (fileType) {
        case FileType.image:
          final result = await _processImage(bytes, file.name, config);
          processedBytes = result.bytes;
          mimeType = result.mimeType;
          break;
        case FileType.pdf:
          processedBytes = bytes;
          mimeType = 'application/pdf';
          break;
        default:
          throw FileProcessorException(
              'Unsupported file type: ${file.extension}');
      }

      onProgress?.call();

      // Convert to base64 efficiently
      final base64String = await _convertToBase64(processedBytes);
      final dataUrl = 'data:$mimeType;base64,$base64String';

      return FileProcessorResult(
        base64String: dataUrl,
        mimeType: mimeType,
        fileName: file.name,
        originalSize: file.size,
        processedSize: processedBytes.length,
        fileType: fileType,
        bytes: processedBytes,
      );
    } catch (e) {
      if (e is FileProcessorException) rethrow;
      throw FileProcessorException('File processing failed', e.toString());
    }
  }

  /// Process bytes directly (useful when you already have file data)
  static Future<FileProcessorResult> processBytes(
    Uint8List bytes,
    String fileName, {
    FileProcessorConfig config = const FileProcessorConfig(),
    VoidCallback? onProgress,
  }) async {
    try {
      final extension = fileName.split('.').last.toLowerCase();
      final fileType = _getFileType(extension);

      // Validate size
      if (bytes.length > config.maxFileSizeBytes) {
        throw FileProcessorException(
            'File too large: ${_formatBytes(bytes.length)} > ${_formatBytes(config.maxFileSizeBytes)}');
      }

      onProgress?.call();

      // Process based on file type
      Uint8List processedBytes;
      String mimeType;

      switch (fileType) {
        case FileType.image:
          final result = await _processImage(bytes, fileName, config);
          processedBytes = result.bytes;
          mimeType = result.mimeType;
          break;
        case FileType.pdf:
          processedBytes = bytes;
          mimeType = 'application/pdf';
          break;
        default:
          throw FileProcessorException('Unsupported file type: $extension');
      }

      onProgress?.call();

      // Convert to base64
      final base64String = await _convertToBase64(processedBytes);
      final dataUrl = 'data:$mimeType;base64,$base64String';

      return FileProcessorResult(
        base64String: dataUrl,
        mimeType: mimeType,
        fileName: fileName,
        originalSize: bytes.length,
        processedSize: processedBytes.length,
        fileType: fileType,
        bytes: processedBytes,
      );
    } catch (e) {
      if (e is FileProcessorException) rethrow;
      throw FileProcessorException('Bytes processing failed', e.toString());
    }
  }

  // Private helper methods

  static void _validateFile(PlatformFile file, FileProcessorConfig config) {
    if (file.size > config.maxFileSizeBytes) {
      throw FileProcessorException(
          'File too large: ${_formatBytes(file.size)} > ${_formatBytes(config.maxFileSizeBytes)}');
    }

    final extension = file.extension?.toLowerCase();
    if (extension == null || !config.allowedExtensions.contains(extension)) {
      throw FileProcessorException('Invalid file type: $extension');
    }
  }

  static Future<Uint8List> _getFileBytes(PlatformFile file) async {
    if (kIsWeb && file.bytes != null) {
      return file.bytes!;
    }

    if (file.path != null) {
      final fileObj = File(file.path!);
      if (!await fileObj.exists()) {
        throw FileProcessorException('File not found: ${file.path}');
      }
      return await fileObj.readAsBytes();
    }

    if (file.bytes != null) {
      return file.bytes!;
    }

    throw FileProcessorException('No file data available');
  }

  static FileType _getFileType(String? extension) {
    switch (extension?.toLowerCase()) {
      case 'jpg':
      case 'jpeg':
      case 'png':
        return FileType.image;
      case 'pdf':
        return FileType.pdf;
      default:
        return FileType.unknown;
    }
  }

  static Future<({Uint8List bytes, String mimeType})> _processImage(
    Uint8List bytes,
    String fileName,
    FileProcessorConfig config,
  ) async {
    if (!config.compressImages) {
      return (
        bytes: bytes,
        mimeType: _getImageMimeType(fileName),
      );
    }

    return await compute(_compressImageIsolate, {
      'bytes': bytes,
      'fileName': fileName,
      'quality': config.imageQuality,
      'maxWidth': config.maxImageWidth,
      'maxHeight': config.maxImageHeight,
    });
  }

  static ({Uint8List bytes, String mimeType}) _compressImageIsolate(
      Map<String, dynamic> params) {
    final bytes = params['bytes'] as Uint8List;
    final fileName = params['fileName'] as String;
    final quality = params['quality'] as int;
    final maxWidth = params['maxWidth'] as int;
    final maxHeight = params['maxHeight'] as int;

    try {
      // Decode image
      final image = img.decodeImage(bytes);
      if (image == null) {
        throw FileProcessorException('Failed to decode image');
      }

      // Resize if needed
      img.Image resizedImage = image;
      if (image.width > maxWidth || image.height > maxHeight) {
        resizedImage = img.copyResize(
          image,
          width: image.width > maxWidth ? maxWidth : null,
          height: image.height > maxHeight ? maxHeight : null,
          maintainAspect: true,
        );
      }

      // Encode with compression
      final extension = fileName.split('.').last.toLowerCase();
      Uint8List compressedBytes;
      String mimeType;

      switch (extension) {
        case 'png':
          compressedBytes = Uint8List.fromList(img.encodePng(resizedImage));
          mimeType = 'image/png';
          break;
        case 'jpg':
        case 'jpeg':
        default:
          compressedBytes =
              Uint8List.fromList(img.encodeJpg(resizedImage, quality: quality));
          mimeType = 'image/jpeg';
          break;
      }

      return (bytes: compressedBytes, mimeType: mimeType);
    } catch (e) {
      // Fallback to original if compression fails
      return (bytes: bytes, mimeType: _getImageMimeType(fileName));
    }
  }

  static String _getImageMimeType(String fileName) {
    final extension = fileName.split('.').last.toLowerCase();
    switch (extension) {
      case 'png':
        return 'image/png';
      case 'jpg':
      case 'jpeg':
      default:
        return 'image/jpeg';
    }
  }

  static Future<String> _convertToBase64(Uint8List bytes) async {
    // For large files, use chunked encoding in isolate
    if (bytes.length > 5 * 1024 * 1024) {
      // 5MB
      return await compute(_base64EncodeIsolate, bytes);
    }
    return base64Encode(bytes);
  }

  static String _base64EncodeIsolate(Uint8List bytes) {
    return base64Encode(bytes);
  }

  static String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  /// Utility method to get file info without processing
  static Map<String, dynamic> getFileInfo(PlatformFile file) {
    return {
      'name': file.name,
      'size': file.size,
      'formattedSize': _formatBytes(file.size),
      'extension': file.extension,
      'type': _getFileType(file.extension).toString(),
    };
  }
}

// Widget for easy integration
class FileProcessorWidget extends StatefulWidget {
  final Function(FileProcessorResult) onFileProcessed;
  final Function(String)? onError;
  final FileProcessorConfig config;
  final Widget? child;
  final String buttonText;

  const FileProcessorWidget({
    Key? key,
    required this.onFileProcessed,
    this.onError,
    this.config = const FileProcessorConfig(),
    this.child,
    this.buttonText = 'Select File',
  }) : super(key: key);

  @override
  State<FileProcessorWidget> createState() => _FileProcessorWidgetState();
}

class _FileProcessorWidgetState extends State<FileProcessorWidget> {
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return widget.child ??
        ElevatedButton(
          onPressed: _isProcessing ? null : _processFile,
          child: _isProcessing
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(widget.buttonText),
        );
  }

  Future<void> _processFile() async {
    setState(() => _isProcessing = true);

    try {
      final result = await FileProcessorService.pickAndProcessFile(
        config: widget.config,
        onProgress: () {
          // Optional: Update progress
        },
      );

      if (result != null) {
        widget.onFileProcessed(result);
      }
    } catch (e) {
      widget.onError?.call(e.toString());
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }
}

// Example usage class
class FileProcessorExample extends StatefulWidget {
  @override
  State<FileProcessorExample> createState() => _FileProcessorExampleState();
}

class _FileProcessorExampleState extends State<FileProcessorExample> {
  FileProcessorResult? _result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('File Processor Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Method 1: Using the widget
            FileProcessorWidget(
              onFileProcessed: (result) {
                setState(() => _result = result);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('File processed: ${result.fileName}')),
                );
              },
              onError: (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: $error')),
                );
              },
              config: const FileProcessorConfig(
                maxFileSizeBytes: 5 * 1024 * 1024, // 5MB
                imageQuality: 80,
                compressImages: true,
              ),
            ),

            const SizedBox(height: 20),

            // Method 2: Custom implementation
            ElevatedButton(
              onPressed: _processFileManually,
              child: const Text('Process File Manually'),
            ),

            const SizedBox(height: 20),

            // Display result
            if (_result != null) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('File: ${_result!.fileName}'),
                      Text('Type: ${_result!.fileType}'),
                      Text(
                          'Original Size: ${_formatBytes(_result!.originalSize)}'),
                      Text(
                          'Processed Size: ${_formatBytes(_result!.processedSize)}'),
                      Text('MIME Type: ${_result!.mimeType}'),
                      const SizedBox(height: 8),
                      Text('Base64 Length: ${_result!.base64String.length}'),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _processFileManually() async {
    try {
      final result = await FileProcessorService.pickAndProcessFile(
        config: const FileProcessorConfig(
          compressImages: true,
          imageQuality: 90,
        ),
      );

      if (result != null) {
        setState(() => _result = result);

        // You can now use result.base64String for upload
        // await uploadToServer(result.base64String);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}

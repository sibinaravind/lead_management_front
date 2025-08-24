import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

// ===== Helpers =====
Future<String> base64ToFile(Uint8List base64Bytes) async {
  final dir = await getTemporaryDirectory();
  final file = File('${dir.path}/downloaded.pdf');
  await file.writeAsBytes(base64Bytes);
  return file.path;
}

Uint8List decodeBase64(String data) {
  final cleaned = data.contains(',') ? data.split(',').last : data;
  return base64Decode(cleaned);
}

bool isPdf(Uint8List data) {
  return data.length > 4 &&
      data[0] == 0x25 &&
      data[1] == 0x50 &&
      data[2] == 0x44 &&
      data[3] == 0x46;
}

bool isImage(Uint8List data) {
  if (data.length > 4) {
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
  }
  return false;
}

Future<String?> preparePdf(Uint8List data) async {
  return await base64ToFile(data);
}

// ===== Main handler =====
Future<Map<String, dynamic>> handleFileDownload(String url, String ext) async {
  Dio dio = Dio();
  final response = await dio.get(
    url,
    options: Options(responseType: ResponseType.bytes), // raw bytes
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to download file');
  }

  Uint8List fileBytes;

  if (ext == 'txt') {
    // Try to interpret as plain text first
    final textContent = utf8.decode(response.data, allowMalformed: true).trim();

    // If it's base64 text, decode it to bytes
    try {
      fileBytes = decodeBase64(textContent);
    } catch (_) {
      // Not base64, treat as plain text file
      return {
        'type': 'text',
        'content': textContent,
      };
    }
  } else {
    // Directly use downloaded bytes
    fileBytes = Uint8List.fromList(response.data);
  }

  // Detect file type
  if (isPdf(fileBytes)) {
    final pdfPath = await preparePdf(fileBytes);
    return {
      'type': 'pdf',
      'filePath': pdfPath,
    };
  } else if (isImage(fileBytes)) {
    return {
      'type': 'image',
      'bytes': fileBytes,
    };
  } else {
    // If unknown binary type
    return {
      'type': 'binary',
      'bytes': fileBytes,
    };
  }
}

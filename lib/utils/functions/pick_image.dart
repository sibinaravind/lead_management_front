import 'dart:convert';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:mime/mime.dart';

class FileUploadService {
  Future<String?> pickAndCompressFileAsBase64() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
      withData: true,
    );

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;
      final Uint8List? bytes = file.bytes;
      final String? fileName = file.name;
      final String? extension = file.extension?.toLowerCase();

      if (bytes != null && fileName != null && extension != null) {
        Uint8List finalBytes = bytes;

        if (['jpg', 'jpeg', 'png', 'webp'].contains(extension)) {
          // 🔽 Compress image to best size/quality balance
          finalBytes = await FlutterImageCompress.compressWithList(
            bytes,
            minWidth: 800, // Reduce resolution
            minHeight: 800,
            quality: 60, // Lower quality = higher compression
            format: _getImageFormat(extension),
          );
        }

        final mimeType = lookupMimeType(fileName) ?? 'application/octet-stream';
        final base64String = base64Encode(finalBytes);
        return 'data:$mimeType;base64,$base64String';
      }
    }
    return null;
  }

  CompressFormat _getImageFormat(String ext) {
    switch (ext) {
      case 'png':
        return CompressFormat.png;
      case 'webp':
        return CompressFormat.webp;
      case 'heic':
        return CompressFormat.heic;
      default:
        return CompressFormat.jpeg;
    }
  }
}

// import 'dart:typed_data';
// import 'package:image_picker/image_picker.dart';
// import 'package:file_picker/file_picker.dart';

// Future<Uint8List?> pickImageBytes() async {
//   try {
//     final pickedFile = await ImagePicker().pickImage(
//       source: ImageSource.gallery,
//     );
//     if (pickedFile == null) return null;

//     return await pickedFile.readAsBytes(); // works for web and mobile
//   } catch (e) {
//     return null;
//   }
// }

// class FileUploadService {
//   Future<void> pickAndUploadFile() async {
//     final result = await FilePicker.platform.pickFiles(
//       type: FileType.any,
//       allowMultiple: false,
//       withData: true,
//     );

//     if (result != null && result.files.isNotEmpty) {
//       final file = result.files.first;
//       final Uint8List? bytes = file.bytes;
//       final String? fileName = file.name;
//       final String? extension = file.extension;

//       if (bytes != null && fileName != null) {
//         // final mimeType = lookupMimeType(fileName);
// //
//         // print('File picked: $fileName, Type: $mimeType');

//         // Upload to backend or DB
//         // await uploadFileToServer(bytes, fileName, mimeType);
//       }
//     }
//   }
// }

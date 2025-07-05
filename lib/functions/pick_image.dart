import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

Future<Uint8List?> pickImageBytes() async {
  try {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile == null) return null;

    return await pickedFile.readAsBytes(); // works for web and mobile
  } catch (e) {
    return null;
  }
}

class FileUploadService {
  Future<void> pickAndUploadFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
      withData: true,
    );

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;
      final Uint8List? bytes = file.bytes;
      final String? fileName = file.name;
      final String? extension = file.extension;

      if (bytes != null && fileName != null) {
        // final mimeType = lookupMimeType(fileName);
//
        // print('File picked: $fileName, Type: $mimeType');

        // Upload to backend or DB
        // await uploadFileToServer(bytes, fileName, mimeType);
      }
    }
  }
}

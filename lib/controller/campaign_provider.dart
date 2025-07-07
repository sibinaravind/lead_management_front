import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:overseas_front_end/functions/pick_image.dart';

class CampaignProvider extends ChangeNotifier {
  Uint8List? imageBytes;

  void uploadImage() async {
    imageBytes = await pickImageBytes();
    notifyListeners();
  }
}

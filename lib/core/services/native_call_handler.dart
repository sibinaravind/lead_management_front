import 'package:flutter/services.dart';

class NativeCallHandler {
  static const platform =
      MethodChannel('com.example.affinix_overseas/native_call_handler');

  static Future<void> initPhoneCallListener() async {
    try {
      await platform.invokeMethod('startCallMonitoring');
    } on PlatformException catch (e) {
      print("Error: ${e.message}");
    }
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'config/flavour_config.dart';
import 'core/di/service_locator.dart';
import 'core/flavor/flavor_config.dart';
import 'core/services/native_call_handler.dart';
import 'my_app.dart';

Future<void> requestCallPermissions() async {
  if (!kIsWeb) {
    await [
      Permission.phone,
    ].request();
  }
}

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // final prefs = await SharedPreferences.getInstance();
  // final token = prefs.getString("token");
  // final officerData = prefs.getString("officer");
  FlavorConfigration(
    name: Partner.affiniks, //
    color: Colors.blue,
    // variables: {
    //   "counter": 5,
    //   "baseUrl": "https://www.example.com",
    // },
  );
  WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load();
  // setPathUrlStrategy();
  await setupServiceLocator();
  await requestCallPermissions();
  if (!kIsWeb) {
    await NativeCallHandler.initPhoneCallListener();
  }
  runApp(MyApp(
      // isLoggedIn: token != null && officerData != null,
      ));
}

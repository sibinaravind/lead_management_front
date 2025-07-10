import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/flavour_config.dart';
import 'core/di/service_locator.dart';
import 'core/flavor/flavor_config.dart';
import 'my_app.dart';

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
  runApp(MyApp(
    // isLoggedIn: token != null && officerData != null,
  ));
}

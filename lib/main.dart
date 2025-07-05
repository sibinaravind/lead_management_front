import 'package:flutter/material.dart';

import 'config/flavour_config.dart';
import 'core/di/service_locator.dart';
import 'core/flavor/flavor_config.dart';
import 'my_app.dart';

Future<void> main() async {
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
  runApp(const MyApp());
}

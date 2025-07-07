import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overseas_front_end/controller/app_user_provider.dart';
import 'package:overseas_front_end/controller/config_provider.dart';
import 'package:overseas_front_end/controller/officers_controller/officers_controller.dart';
import 'package:overseas_front_end/view/screens/employee/employee_permission_screen.dart';
import 'package:overseas_front_end/controller/campaign/campaign_provider.dart';
import 'package:provider/provider.dart';

import 'config/flavour_config.dart';
import 'controller/permission_conteroller/access_permission_controller.dart';
import 'view/screens/drawer/drawer_screen.dart';
// import 'view/features/drawer/drawer_screen.dart';

class MyApp extends StatelessWidget {
  final String? flavour;
  const MyApp({super.key, this.flavour});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppUserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CampaignProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ConfigProvider(),
        ),
        ChangeNotifierProvider(create: (context) => AccessPermissionProvider()),
        ChangeNotifierProvider(
            create: (context) => OfficersControllerProvider()),
      ],
      child: MaterialApp(
        title: ' ${FlavourConfig.partnerName()} ',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          textTheme:
              GoogleFonts.notoSansArmenianTextTheme(), //ptSansCaptionTextTheme
          useMaterial3: true,
        ),
        routes: {
          '/not-found': (context) =>
              Center(child: Text('404 - Page not found')),
          // '/': (context) => AccessPermissionScreen()
          '/': (context) => DrawerScreen()
        },
        initialRoute: '/',
      ),
    );
  }
}

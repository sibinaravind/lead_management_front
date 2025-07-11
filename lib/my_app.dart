import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overseas_front_end/controller/app_user_provider.dart';
import 'package:overseas_front_end/controller/auth/login_controller.dart';
import 'package:overseas_front_end/controller/lead/lead_provider.dart';
import 'package:overseas_front_end/controller/team_lead/team_lead_provider.dart';
import 'package:overseas_front_end/controller/config_provider.dart';
import 'package:overseas_front_end/controller/officers_controller/officers_controller.dart';
import 'package:overseas_front_end/view/screens/Auth/login_screen.dart';
import 'package:overseas_front_end/view/screens/employee/employee_permission_screen.dart';
import 'package:overseas_front_end/controller/campaign/campaign_provider.dart';
import 'package:overseas_front_end/view/screens/officers/employee_creation_screen.dart';
import 'package:overseas_front_end/view/screens/officers/employee_data_display.dart';
import 'package:overseas_front_end/view/screens/officers/widgets/employee_user_list_table.dart';
import 'package:overseas_front_end/view/screens/team_lead/team_lead_data_display.dart';
import 'package:provider/provider.dart';

import 'config/flavour_config.dart';
import 'controller/permission_controller/access_permission_controller.dart';
import 'controller/project/client_provider_controller.dart';
import 'view/screens/drawer/drawer_screen.dart';
// import 'view/features/drawer/drawer_screen.dart';

class MyApp extends StatelessWidget {
  // final bool isLoggedIn;

  final String? flavour;
  const MyApp({
    super.key,
    this.flavour,
    // required this.isLoggedIn
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppUserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ClientProvider(),
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
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => LeadProvider()),
        ChangeNotifierProvider(create: (context) => TeamLeadProvider()),
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
          // '/': (context) => DrawerScreen()
          '/': (context) => LoginScreen()
        },
        initialRoute: '/',
      ),
    );
  }
}

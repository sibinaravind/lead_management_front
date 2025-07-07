import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overseas_front_end/controller/app_user_provider.dart';
import 'package:overseas_front_end/controller/campaign_provider.dart';
import 'package:overseas_front_end/controller/config_provider.dart';
import 'package:provider/provider.dart';

import 'config/flavour_config.dart';
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
          '/': (context) => DrawerScreen()
        },
        initialRoute: '/',
      ),
    );
  }
}

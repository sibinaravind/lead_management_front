import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:overseas_front_end/config/flavour_config.dart';
import 'package:overseas_front_end/core/bindings/global_bindings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'view/screens/Auth/login_screen.dart';
import 'view/screens/drawer/main_layout_screen.dart';
import 'view/screens/error_screen/error_screen.dart';

class MyApp extends StatelessWidget {
  final String? flavour;
  const MyApp({super.key, this.flavour});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/dashboard/:mainTab/:subTab',
          builder: (context, state) {
            final mainTab = state.pathParameters['mainTab'] ?? 'dashboard';
            final subTab = state.pathParameters['subTab'] ?? 'overview';
            return MainLayoutScreen(mainTab: mainTab, subTab: subTab);
          },
        ),
      ],
      errorBuilder: (context, state) => ErrorScreen(),
      initialLocation: '/dashboard/dashboard/overview',
    );
    return GetMaterialApp.router(
      initialBinding: GlobalBindings(),
      title: ' ${FlavourConfig.partnerName()} ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        textTheme:
            GoogleFonts.notoSansArmenianTextTheme(), //ptSansCaptionTextTheme
        useMaterial3: true,
      ),
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:overseas_front_end/controller/app_user_provider.dart';
// import 'package:overseas_front_end/controller/auth/login_controller.dart';
// import 'package:overseas_front_end/controller/lead/lead_provider.dart';
// import 'package:overseas_front_end/controller/registration/registration_controller.dart';
// import 'package:overseas_front_end/controller/team_lead/team_lead_provider.dart';
// import 'package:overseas_front_end/controller/config/config_provider.dart';
// import 'package:overseas_front_end/controller/officers_controller/officers_controller.dart';
// import 'package:overseas_front_end/controller/campaign/campaign_provider.dart';
// import 'package:overseas_front_end/view/screens/Auth/login_screen.dart';
// import 'package:overseas_front_end/view/screens/leads/lead_data_display.dart';
// import 'package:provider/provider.dart';
// import 'config/flavour_config.dart';
// import 'controller/lead/round_robin_provider.dart';
// import 'controller/permission_controller/access_permission_controller.dart';
// import 'controller/project/project_provider_controller.dart';
// import 'controller/project/vacancy_controller.dart';
// import 'view/screens/drawer/drawer_screen.dart';
// import 'view/screens/team_lead/team_lead_data_display.dart';
// // import 'view/features/drawer/drawer_screen.dart';

// class MyApp extends StatelessWidget {
//   // final bool isLoggedIn;

//   final String? flavour;
//   const MyApp({
//     super.key,
//     this.flavour,
//     // required this.isLoggedIn
//   });

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(
//           create: (context) => AppUserProvider(),
//         ),
//         // ChangeNotifierProvider(create: (_) => VacancyProvider()),
//         ChangeNotifierProvider(
//           create: (context) => ProjectProvider(),
//         ),
//         ChangeNotifierProvider(
//           create: (context) => CampaignProvider(),
//         ),
//         ChangeNotifierProvider(
//           create: (context) => ConfigProvider(),
//         ),
//         ChangeNotifierProvider(create: (context) => AccessPermissionProvider()),
//         ChangeNotifierProvider(
//             create: (context) => OfficersControllerProvider()),
//         ChangeNotifierProvider(create: (_) => LoginProvider()),
//         ChangeNotifierProvider(create: (_) => LeadProvider()),
//         ChangeNotifierProvider(create: (context) => TeamLeadProvider()),
//         ChangeNotifierProvider(create: (_) => RoundRobinProvider()),
//         ChangeNotifierProvider(create: (_) => RegistrationController()),
//       ],
//       child: MaterialApp(
//         title: ' ${FlavourConfig.partnerName()} ',
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
//           textTheme:
//               GoogleFonts.notoSansArmenianTextTheme(), //ptSansCaptionTextTheme
//           useMaterial3: true,
//         ),
//         routes: {
//           '/not-found': (context) =>
//               Center(child: Text('404 - Page not found')),
//           '/dashboard': (context) => DrawerScreen(),
//           '/test': (context) => TeamLeadDataDisplay(),
//           '/': (context) => LoginScreen()
//         },
//         initialRoute: '/',
//       ),
//     );
//   }
// }

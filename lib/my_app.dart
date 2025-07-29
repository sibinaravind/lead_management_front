import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:overseas_front_end/config/flavour_config.dart';
import 'package:overseas_front_end/core/bindings/global_bindings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overseas_front_end/view/screens/auth/login_screen.dart';
import 'view/screens/drawer/main_layout_screen.dart';
import 'view/screens/employee/round_robin_screen.dart' show RoundRobinScreen;
import 'view/screens/error_screen/error_screen.dart';
import 'core/services/navigation_service.dart'; // Import your navigation service

final GlobalKey<NavigatorState> routerNavigatorKey =
    GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  final String? flavour;
  const MyApp({super.key, this.flavour});

  @override
  Widget build(BuildContext context) {
    // Create a separate navigator key for GoRouter

    final GoRouter router = GoRouter(
      navigatorKey: routerNavigatorKey, // Use separate key for GoRouter
      // redirect: (context, state) {
      //   final loggedIn = UserCacheService().isLogin();
      //   if (!loggedIn && state.matchedLocation != '/') {
      //     return '/';
      //   }
      //   if (loggedIn && state.matchedLocation == '/') {
      //     return '/dashboard/dashboard/overview';
      //   }
      //   return null;
      // }, // Uncomment if you want to prpoerp logout //test
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => LoginScreen(),
        ),
        GoRoute(
          path: '/dashboard/:mainTab/:subTab',
          builder: (context, state) {
            final mainTab = state.pathParameters['mainTab'] ?? 'dashboard';
            final subTab = state.pathParameters['subTab'] ?? 'overview';
            return MainLayoutScreen(mainTab: mainTab, subTab: subTab);
          },
        ),
        GoRoute(
          path: '/test',
          builder: (context, state) => RoundRobinScreen(),
        ),
      ],
      errorBuilder: (context, state) => ErrorScreen(),
      initialLocation: '/test',
    );
    // Initialize the navigation service with the router
    NavigationService.initialize(router);
    return GetMaterialApp.router(
      initialBinding: GlobalBindings(),
      title: ' ${FlavourConfig.partnerName()} ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        textTheme: GoogleFonts.notoSansArmenianTextTheme(),
        useMaterial3: true,
      ),
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context),
          child: child!,
        );
      },
      scaffoldMessengerKey: GlobalKey<ScaffoldMessengerState>(),
    );
  }
}

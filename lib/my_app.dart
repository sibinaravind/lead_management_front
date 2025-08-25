import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:overseas_front_end/config/flavour_config.dart';
import 'package:overseas_front_end/core/bindings/global_bindings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overseas_front_end/view/screens/auth/login_screen.dart';
import 'package:overseas_front_end/view/screens/dashboard/dashbaord_screen.dart';
import 'view/screens/drawer/main_layout_screen.dart';
import 'view/screens/error_screen/error_screen.dart';
import 'core/services/navigation_service.dart';

final GlobalKey<NavigatorState> routerNavigatorKey =
    GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  final String? flavour;
  const MyApp({super.key, this.flavour});

  @override
  Widget build(BuildContext context) {
    // Create a separate navigator key for GoRouter
    // UserCacheService().saveAuthToken(
    //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2ODZjZWRhOWU5Mjk5ZjM0MjlkNjIzOWEiLCJvZmZpY2VyX2lkIjoiNCIsImRlc2lnbmF0aW9uIjpbIkNPVU5TSUxPUiIsIkFETUlOIl0sImJyYW5jaCI6WyJUU1QxMyJdLCJvZmZpY2VycyI6W3sib2ZmaWNlcl9pZCI6IjY4NmZmMzA3MWRhNWViYmE1YzZjZjBiOSIsInN0YWZmX2lkIjoiMjMiLCJlZGl0X3Blcm1pc3Npb24iOmZhbHNlfSx7Im9mZmljZXJfaWQiOiI2ODdiNWIxYjBhZTY1ZjhjZTlkNDYwMWEiLCJzdGFmZl9pZCI6IjIzIiwiZWRpdF9wZXJtaXNzaW9uIjpmYWxzZX0seyJvZmZpY2VyX2lkIjoiNjg2Y2VkYTllOTI5OWYzNDI5ZDYyMzlhIiwic3RhZmZfaWQiOiI0IiwiZWRpdF9wZXJtaXNzaW9uIjpmYWxzZX0seyJvZmZpY2VyX2lkIjoiNjg3YjY4ZTAwYWU2NWY4Y2U5ZDQ2MDFiIiwic3RhZmZfaWQiOiIxMjEiLCJlZGl0X3Blcm1pc3Npb24iOmZhbHNlfSx7Im9mZmljZXJfaWQiOiI2ODdlM2RiY2NkYjdjNTJjOWQ5OTM1ZWIiLCJzdGFmZl9pZCI6Ijg1IiwiZWRpdF9wZXJtaXNzaW9uIjpmYWxzZX0seyJvZmZpY2VyX2lkIjoiNjg2Y2VkYTllOTI5OWYzNDI5ZDYyMzlhIiwic3RhZmZfaWQiOiI0IiwiZWRpdF9wZXJtaXNzaW9uIjp0cnVlfSx7Im9mZmljZXJfaWQiOiI2ODZkMWVkZGU5Mjk5ZjM0MjlkNjIzYTUiLCJzdGFmZl9pZCI6IjY0IiwiZWRpdF9wZXJtaXNzaW9uIjp0cnVlfSx7Im9mZmljZXJfaWQiOiI2ODdiMzM0NTBhZTY1ZjhjZTlkNDYwMTUiLCJzdGFmZl9pZCI6IjI1IiwiZWRpdF9wZXJtaXNzaW9uIjp0cnVlfSx7Im9mZmljZXJfaWQiOiI2ODdiNWIxYjBhZTY1ZjhjZTlkNDYwMWEiLCJzdGFmZl9pZCI6IjEwMCIsImVkaXRfcGVybWlzc2lvbiI6dHJ1ZX1dLCJpYXQiOjE3NTQ0NjU5MDYsImV4cCI6MTc1NDQ2NzcwNn0.vXpF291lBByUtS3my-AOhkr79JXneSIJWBugLSl7U8o');
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
          path: '/', //test move to /
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
          builder: (context, state) => DashboardScreen(),
          // builder: (context, state) => CustomerJourneyScreen(),
        ),
      ],
      errorBuilder: (context, state) => ErrorScreen(),
      initialLocation: '/dashboard/dashboard/overview',
      // initialLocation: '/test',
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

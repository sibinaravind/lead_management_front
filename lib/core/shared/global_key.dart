import 'package:flutter/material.dart';

class GlobalKeyService {
  static final GlobalKeyService _instance = GlobalKeyService._internal();

  factory GlobalKeyService() {
    return _instance;
  }

  GlobalKeyService._internal();

  final GlobalKey<ScaffoldState> dashboardScaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: 'dashboard_screen_key');
  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'navigator_key');
}

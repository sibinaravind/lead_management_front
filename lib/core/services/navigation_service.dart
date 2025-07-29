import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
// ignore: deprecated_member_use, avoid_web_libraries_in_flutter
import 'dart:html' as html;

class NavigationService {
  static GoRouter? _router;

  /// Initialize the navigation service with the GoRouter instance
  static void initialize(GoRouter router) {
    _router = router;
  }

  // ============ BASIC NAVIGATION METHODS ============

  /// Navigate to a specific path (standard navigation - replaces current route in history)
  ///

  static void clearHistoryAndNavigate(String path, {Object? extra}) {
    final context = _router?.routerDelegate.navigatorKey.currentContext;
    if (context != null) {
      // Normal go_router navigation
      context.go(path, extra: extra);
      // On web: replace current browser history so back button won't go back
      if (kIsWeb) {
        html.window.history.replaceState(null, '', path);
      }
    }
  }

  static void go(String path, {Object? extra}) {
    final context = _router?.routerDelegate.navigatorKey.currentContext;
    if (context != null) {
      context.go(path, extra: extra);
    }
  }

  static void replaceAndClearStack(String location, {Object? extra}) {
    final context = _router?.routerDelegate.navigatorKey.currentContext;
    if (context != null) {
      // Pop all existing routes
      while (context.canPop()) {
        context.pop();
      }
      // Use go to replace the root route
      context.go(location, extra: extra);
    }
  }

  /// Push a new route onto the stack (keeps previous routes)
  static void push(String path, {Object? extra}) {
    final context = _router?.routerDelegate.navigatorKey.currentContext;
    if (context != null) {
      context.push(path, extra: extra);
    }
  }

  /// Replace current route with a new path (removes current from stack)
  static void replace(String path, {Object? extra}) {
    final context = _router?.routerDelegate.navigatorKey.currentContext;
    if (context != null) {
      context.replace(path, extra: extra);
    }
  }

  // ============ ADVANCED NAVIGATION METHODS ============

  /// Navigate and clear all previous routes from stack
  static void goAndClearStack(String path, {Object? extra}) {
    final context = _router?.routerDelegate.navigatorKey.currentContext;
    if (context != null) {
      // Pop all routes until we can't pop anymore
      while (context.canPop()) {
        context.pop();
      }
      // Then navigate to the new path
      context.go(path, extra: extra);
    }
  }

  /// Navigate and replace entire navigation stack (complete reset)
  static void resetToRoute(String path, {Object? extra}) {
    final context = _router?.routerDelegate.navigatorKey.currentContext;
    if (context != null) {
      // Use go which replaces the current location in the history
      context.go(path, extra: extra);
    }
  }

  /// Navigate with complete app reset (like logout scenario)
  static void resetApp(String path, {Object? extra}) {
    final context = _router?.routerDelegate.navigatorKey.currentContext;
    if (context != null) {
      // Clear all routes and reset to initial route
      while (context.canPop()) {
        context.pop();
      }
      context.go(path, extra: extra);
      // Refresh the router to ensure clean state
      _router?.refresh();
    }
  }

  /// Navigate without adding to browser history (replaces current entry)
  static void navigateReplaceHistory(String path, {Object? extra}) {
    final context = _router?.routerDelegate.navigatorKey.currentContext;
    if (context != null) {
      // This replaces the current browser history entry
      context.go(path, extra: extra);
    }
  }

  /// Clear browser history and navigate (for web apps)
  // static void clearHistoryAndNavigate(String path, {Object? extra}) {
  //   final context = _router?.routerDelegate.navigatorKey.currentContext;
  //   if (context != null) {
  //     // For web, this approach helps clear the browser back stack
  //     context.go(path, extra: extra);

  //     // Additional web-specific history management
  //     try {
  //       // Replace the browser history state
  //       if (context.mounted) {
  //         // This ensures the browser history is properly managed
  //         Future.microtask(() {
  //           final currentUri = Uri.parse(path);
  //           _router?.routeInformationProvider.routerReportsNewRouteInformation(
  //             RouteInformation(
  //               uri: currentUri,
  //               state: null,
  //             ),
  //             type: RouteInformationReportingType.neglect,
  //           );
  //         });
  //       }
  //     } catch (e) {
  //       // Fallback if history manipulation fails
  //       print('History manipulation failed: $e');
  //     }
  //   }
  // }

  /// Push and clear previous routes (useful for login -> dashboard flow)
  static void pushAndClearPrevious(String path, {Object? extra}) {
    final context = _router?.routerDelegate.navigatorKey.currentContext;
    if (context != null) {
      // Pop until we reach the root, then push new route
      while (context.canPop()) {
        context.pop();
      }
      context.push(path, extra: extra);
    }
  }

  // ============ BACK NAVIGATION ============

  /// Go back to the previous route
  static void goBack([Object? result]) {
    final context = _router?.routerDelegate.navigatorKey.currentContext;
    if (context != null && context.canPop()) {
      context.pop(result);
    }
  }

  /// Go back multiple steps
  static void goBackSteps(int steps) {
    final context = _router?.routerDelegate.navigatorKey.currentContext;
    if (context != null) {
      for (int i = 0; i < steps && context.canPop(); i++) {
        context.pop();
      }
    }
  }

  /// Go back to specific route (pop until we reach the target route)
  static void goBackToRoute(String targetPath) {
    final context = _router?.routerDelegate.navigatorKey.currentContext;
    if (context != null) {
      // Keep popping until we can't pop anymore or reach target
      while (context.canPop()) {
        final currentLocation = getCurrentLocation();
        if (currentLocation == targetPath) {
          break;
        }
        context.pop();
      }
    }
  }

  // ============ UTILITY METHODS ============

  /// Check if we can go back
  static bool canGoBack() {
    final context = _router?.routerDelegate.navigatorKey.currentContext;
    return context?.canPop() ?? false;
  }

  /// Get current location
  static String? getCurrentLocation() {
    return _router?.routeInformationProvider.value.uri.toString();
  }

  /// Get current path parameters
  static Map<String, String> getCurrentPathParameters() {
    final context = _router?.routerDelegate.navigatorKey.currentContext;
    if (context != null) {
      final routeState = GoRouterState.of(context);
      return routeState.pathParameters;
    }
    return {};
  }

  /// Get current query parameters
  static Map<String, String> getCurrentQueryParameters() {
    final context = _router?.routerDelegate.navigatorKey.currentContext;
    if (context != null) {
      final routeState = GoRouterState.of(context);
      return routeState.uri.queryParameters;
    }
    return {};
  }

  /// Check if current route matches a specific path
  static bool isCurrentRoute(String path) {
    return getCurrentLocation() == path;
  }

  /// Refresh current route
  static void refresh() {
    _router?.refresh();
  }

  // ============ SPECIALIZED NAVIGATION PATTERNS ============

  /// Navigation for login success (clear auth routes, go to dashboard)
  static void onLoginSuccess(
      {String dashboardPath = '/dashboard/dashboard/overview'}) {
    clearHistoryAndNavigate(dashboardPath);
  }

  /// Navigation for logout (clear all routes, go to login)
  static void onLogout({String loginPath = '/'}) {
    resetApp(loginPath);
  }

  /// Navigation for authentication required (clear current, go to login)
  static void requireAuthentication({String loginPath = '/'}) {
    goAndClearStack(loginPath);
  }

  /// Navigation with confirmation dialog
  static void navigateWithConfirmation(
    BuildContext context,
    String path, {
    String title = 'Confirm Navigation',
    String message = 'Are you sure you want to leave this page?',
    String confirmText = 'Yes',
    String cancelText = 'Cancel',
    Object? extra,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(cancelText),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                go(path, extra: extra);
              },
              child: Text(confirmText),
            ),
          ],
        );
      },
    );
  }
}

// ============ EXTENSION FOR EASIER ACCESS ============

extension NavigationExtension on BuildContext {
  void goTo(String path, {Object? extra}) {
    NavigationService.go(path, extra: extra);
  }

  void pushTo(String path, {Object? extra}) {
    NavigationService.push(path, extra: extra);
  }

  void replaceTo(String path, {Object? extra}) {
    NavigationService.replace(path, extra: extra);
  }

  void resetTo(String path, {Object? extra}) {
    NavigationService.resetApp(path, extra: extra);
  }
}

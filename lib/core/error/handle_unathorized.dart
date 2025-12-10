import '../services/navigation_service.dart';
import '../di/service_locator.dart';
import '../services/user_cache_service.dart';

void handleUnauthorized() {
  // final context = GlobalKeyService().navigatorKey.currentContext;
  // if (context != null) {
  print("Handling unauthorized access - logging out user.");
  serviceLocator<UserCacheService>().deleteUser();
  //   // Clear user cache
  NavigationService.clearHistoryAndNavigate('/login');
  // } else {
  //   print("Unauthorized context is null");
  // }
}

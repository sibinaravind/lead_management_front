import '../services/navigation_service.dart';
import '../di/service_locator.dart';
import '../services/user_cache_service.dart';

void handleUnauthorized() {
  // final context = GlobalKeyService().navigatorKey.currentContext;
  // if (context != null) {
  serviceLocator<UserCacheService>().deleteUser();
  //   // Clear user cache
  NavigationService.clearHistoryAndNavigate('/');
  // } else {
  //   print("Unauthorized context is null");
  // }
}

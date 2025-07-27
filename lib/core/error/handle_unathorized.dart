import 'package:go_router/go_router.dart';
import 'package:overseas_front_end/core/di/service_locator.dart';
import 'package:overseas_front_end/core/services/user_cache_service.dart';

import '../shared/global_key.dart';

void handleUnauthorized() {
  final context = GlobalKeyService().navigatorKey.currentContext;
  if (context != null) {
    serviceLocator<UserCacheService>().deleteUser();
    GoRouter.of(context).go('/');
  } else {
    print("Unauthorized context is null");
  }
}

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/network_client.dart';
import '../services/user_cache_service.dart';
import '../shared/contants.dart';

final serviceLocator = GetIt.instance;

Future<void> setupServiceLocator() async {
  //services
  serviceLocator.registerSingleton<UserCacheService>(UserCacheService());
  serviceLocator.registerFactory<Constant>(() => Constant());
  serviceLocator.registerFactory<Dio>(
    () => NetworkClient(Dio(), constant: serviceLocator()).dio,
  );

  //localStorage

  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerFactory<SharedPreferences>(() => sharedPreferences);

  // serviceLocator.reset();
}

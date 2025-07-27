import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:overseas_front_end/core/error/api_exception_handler.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/services/user_cache_service.dart';
import '../../../core/shared/constants.dart';
import '../../../model/app_configs/config_list_model.dart';

class ConfigApi {
  ConfigApi();

  Future<Either<Exception, ConfigListModel>> getConfigItem() async {
    Dio client = serviceLocator();

    try {
      var token = await UserCacheService().getAuthToken();
      Response response = await client.get(
        Constant().featureBaseUrl + Constant().configList,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": token,
        }),
      );
      if (response.statusCode == 200) {
        return Right(
            ConfigListModel.fromJson(response.data["data"])); //for list
      } else {
        return Left(Exception(response.data['msg'] ?? 'Unknown error'));
      }
    } catch (e) {
      throw handleApiException(e);
    }
  }

  Future<Either<Exception, ConfigListModel>> patchConfigItem(
      Map<String, dynamic> data) async {
    Dio client = serviceLocator();

    try {
      var token = await UserCacheService().getAuthToken();
      Response response = await client.patch(
        data: data,
        Constant().featureBaseUrl + Constant().editConfigList,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": token,
        }),
      );
      if (response.statusCode == 200) {
        return Right(ConfigListModel.fromJson(response.data["data"]));
      } else {
        return Left(Exception(response.data['msg'] ?? 'Unknown error'));
      }
    } catch (e) {
      throw handleApiException(e);
    }
  }
}

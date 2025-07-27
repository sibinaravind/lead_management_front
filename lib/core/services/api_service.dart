import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:overseas_front_end/core/di/service_locator.dart';
import 'package:overseas_front_end/core/error/failure.dart';
import 'package:overseas_front_end/core/shared/constants.dart';
import '../error/api_exception_handler.dart';

class ApiService extends GetxService {
  final String baseUrl = Constant().featureBaseUrl;

  @override
  void onInit() {
    super.onInit();
  }

  /// ✅ GET Request
  Future<Either<Exception, T>> getRequest<T>({
    required String endpoint,
    required T Function(dynamic json) fromJson,
    Map<String, dynamic>? params,
  }) async {
    Dio dio = serviceLocator();
    try {
      final response = await dio.get(
        endpoint,
        queryParameters: params,
        options: _getOptions(),
      );
      if (response.statusCode == 200) {
        return Right(fromJson(response.data["data"]));
      } else {
        throw Left(Exception(response.data['msg'] ?? 'Unknown error'));
      }
    } on DioException catch (e) {
      return Left(handleApiException(e));
    }
  }

  /// ✅ POST Request
  Future<Either<Exception, T>> postRequest<T>({
    required String endpoint,
    required dynamic body,
    required T Function(dynamic json) fromJson,
  }) async {
    try {
      Dio dio = serviceLocator();
      final response = await dio.post(
        endpoint,
        data: body,
        options: _getOptions(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(fromJson(response.data["data"]));
      } else {
        return Left(Exception(response.data['msg'] ?? 'Unknown error'));
      }
    } on DioException catch (e) {
      return Left(handleApiException(e));
    }
  }

  /// ✅ PUT Request
  Future<Either<Exception, T>> putRequest<T>({
    required String endpoint,
    required dynamic body,
    required T Function(dynamic json) fromJson,
  }) async {
    try {
      Dio dio = serviceLocator();
      final response = await dio.put(
        endpoint,
        data: body,
        options: _getOptions(),
      );
      if (response.statusCode == 200) {
        return Right(fromJson(response.data["data"]));
      } else {
        return Left(Exception(response.data['msg'] ?? 'Unknown error'));
      }
    } on DioException catch (e) {
      return Left(handleApiException(e));
    }
  }

  /// ✅ DELETE Request
  Future<Either<Exception, T>> deleteRequest<T>({
    required String endpoint,
    required T Function(dynamic json) fromJson,
    Map<String, dynamic>? params,
  }) async {
    try {
      Dio dio = serviceLocator();
      final response = await dio.delete(
        endpoint,
        queryParameters: params,
        options: _getOptions(),
      );
      if (response.statusCode == 200) {
        return Right(fromJson(response.data["data"]));
      } else {
        return Left(Exception(response.data['msg'] ?? 'Unknown error'));
      }
    } on DioException catch (e) {
      throw Left(handleApiException(e));
    }
  }

  /// ✅ Common Options
  Options _getOptions() {
    return Options(
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer your_token_here', // optional
      },
    );
  }
}

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:overseas_front_end/core/services/user_cache_service.dart';
// import 'package:overseas_front_end/core/shared/constants.dart';

// import '../di/service_locator.dart';

// class ApiService {
//   static final ApiService _instance = ApiService._internal();
//   static final String _baseUrl = Constant().featureBaseUrl;
//   late final Dio _dio;
//   factory ApiService() {
//     return _instance;
//   }

//   Options? options;

//   // Options(
//   //   validateStatus: (status) => status != null && status < 500,
//   //   // baseUrl: _baseUrl,
//   //   // connectTimeout: const Duration(seconds: 10),
//   //   receiveTimeout: const Duration(seconds: 15),
//   //   headers: {
//   //     'Content-Type': 'application/json',
//   //     'Accept': 'application/json',
//   //     'Authorization': 'Bearer ${}',
//   //   },
//   // );

//   ApiService._internal() {
//     BaseOptions options = BaseOptions(
//       baseUrl: _baseUrl,
//       connectTimeout: const Duration(seconds: 10),
//       receiveTimeout: const Duration(seconds: 15),
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         // 'Authorization': 'Bearer your_token_here',
//       },
//     );

//     _dio = serviceLocator();
//   }

//   Future<dynamic> get(String endpoint, {BuildContext? context}) async {
//     try {
//       String token = await UserCacheService().getAuthToken() ?? "";
//       options = Options(
//         validateStatus: (status) => status != null && status < 500,
//         receiveTimeout: const Duration(seconds: 15),
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': token,
//         },
//       );

//       final response = await _dio.get(endpoint, options: options);
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         return response.data;
//       } else if (response.statusCode == 400 || response.statusCode == 401) {
//         if (context != null && context.mounted) {
//           Navigator.pushNamedAndRemoveUntil(
//             context,
//             '/',
//             (route) => false,
//           );
//         }
//         // _handleError(response.data['message']);
//       } else {
//         _handleError(response.data['message']);
//       }
//     } on DioException catch (e) {
//       _handleError(e);
//     }
//   }
//   //
//   // Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
//   //   try {
//   //     final response = await _dio.post(endpoint, data: data);
//   //     if (response.statusCode == 200 || response.statusCode == 201) {
//   //       return response.data;
//   //     } else {
//   //       _handleError(response.data['message']);
//   //     }
//   //   } on DioException catch (e) {
//   //     _handleError(e);
//   //   }
//   // }

//   Future<dynamic> post(String endpoint, Map<String, dynamic> data,
//       {BuildContext? context, List listData = const []}) async {
//     try {
//       String token = await UserCacheService().getAuthToken() ?? "";
//       options = Options(
//         validateStatus: (status) => status != null && status < 500,
//         receiveTimeout: const Duration(seconds: 15),
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': token,
//         },
//       );
//       final cleanedData = Map.fromEntries(
//         data.entries.where((entry) => entry.value != null && entry.value != ""),
//       );

//       final response = await _dio.post(endpoint,
//           data: cleanedData.isEmpty ? listData : cleanedData, options: options);
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         return response.data;
//       } else if (response.statusCode == 400 || response.statusCode == 401) {
//         if (context != null && context.mounted) {
//           Navigator.pushNamedAndRemoveUntil(
//             context,
//             "/",
//             (route) => false,
//           );
//         }
//       } else {
//         _handleError(response.data['message']);
//       }
//     } on DioException catch (e) {
//       _handleError(e);
//     }
//   }

//   Future<dynamic> put(String endpoint, Map<String, dynamic> data,
//       {BuildContext? context}) async {
//     try {
//       String token = await UserCacheService().getAuthToken() ?? "";
//       options = Options(
//         validateStatus: (status) => status != null && status < 500,
//         receiveTimeout: const Duration(seconds: 15),
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': token,
//         },
//       );
//       final cleanedData = Map.fromEntries(
//         data.entries.where((entry) => entry.value != null && entry.value != ""),
//       );

//       final response =
//           await _dio.put(endpoint, data: cleanedData, options: options);
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         return response.data;
//       } else if (response.statusCode == 400 || response.statusCode == 401) {
//         if (context != null && context.mounted) {
//           Navigator.pushNamedAndRemoveUntil(
//             context,
//             "/",
//             (route) => false,
//           );
//         }
//       } else {
//         _handleError(response.data['message']);
//       }
//     } on DioException catch (e) {
//       _handleError(e);
//     }
//   }

//   Future<dynamic> patch(String endpoint, Map<String, dynamic> data,
//       {BuildContext? context, List listData = const []}) async {
//     try {
//       String token = await UserCacheService().getAuthToken() ?? "";
//       options = Options(
//         validateStatus: (status) => status != null && status < 500,
//         receiveTimeout: const Duration(seconds: 15),
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': token,
//         },
//       );
//       final cleanedData = Map.fromEntries(
//         data.entries.where((entry) => entry.value != null && entry.value != ""),
//       );

//       final response = await _dio.patch(endpoint,
//           data: cleanedData.isEmpty ? listData : cleanedData, options: options);
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         return response.data;
//       } else if (response.statusCode == 400 || response.statusCode == 401) {
//         if (context != null && context.mounted) {
//           Navigator.pushNamedAndRemoveUntil(
//             context,
//             "/",
//             (route) => false,
//           );
//         }
//       } else {
//         _handleError(response.data['message']);
//       }
//     } on DioException catch (e) {
//       _handleError(e);
//     }
//   }

//   Future<dynamic> delete(String endpoint, Map<String, dynamic> data,
//       {BuildContext? context}) async {
//     try {
//       String token = await UserCacheService().getAuthToken() ?? "";
//       options = Options(
//         validateStatus: (status) => status != null && status < 500,
//         receiveTimeout: const Duration(seconds: 15),
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': token,
//         },
//       );
//       final response =
//           await _dio.delete(endpoint, data: data, options: options);
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         return response.data;
//       } else if (response.statusCode == 400 || response.statusCode == 401) {
//         if (context != null && context.mounted) {
//           Navigator.pushNamedAndRemoveUntil(
//             context,
//             "/",
//             (route) => false,
//           );
//         }
//       } else {
//         _handleError(response.data['message']);
//       }
//     } on DioException catch (e) {
//       _handleError(e);
//     }
//   }

//   void _handleError(DioException e) {
//     if (e.response != null) {
//       throw Exception(
//           'Dio Error ${e.response?.statusCode}: ${e.response?.data}');
//     } else {
//       throw Exception('Dio Error: ${e.message}');
//     }
//   }
// }

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:overseas_front_end/core/shared/constants.dart';

import '../di/service_locator.dart';
import 'user_cache_service.dart';

class ApiService extends GetxService {
  late final Dio _dio;
  final String baseUrl = Constant().featureBaseUrl;

  @override
  void onInit() {
    super.onInit();

    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
    ));

    // Add interceptors
    _dio.interceptors.add(AuthInterceptor());
    // _dio.interceptors.add(LoggingInterceptor());
  }

  Future<Response> get(String endpoint, {Map<String, dynamic>? params}) async {
    try {
      return await _dio.get(
        endpoint,
        queryParameters: params,
        options: _getOptions(),
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> post(String endpoint, dynamic data) async {
    try {
      return await _dio.post(
        endpoint,
        data: data,
        options: _getOptions(),
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> put(String endpoint, dynamic data) async {
    try {
      return await _dio.put(
        endpoint,
        data: data,
        options: _getOptions(),
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> patch(String endpoint, dynamic data) async {
    try {
      return await _dio.patch(
        endpoint,
        data: data,
        options: _getOptions(),
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> delete(String endpoint, {dynamic data}) async {
    try {
      return await _dio.delete(
        endpoint,
        data: data,
        options: _getOptions(),
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Options _getOptions() {
    // final token = serviceLocator<UserCacheService>().getAuthToken();
    return Options(
      headers: {
        // 'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
  }

  dynamic _handleError(DioException e) {
    if (e.response?.statusCode == 401) {
      // Get.offAll(page: '/login');

      throw Exception('Unauthorized access. Please log in again.');
    }
    throw e.response?.data['message'] ?? 'Unknown error occurred';
  }
}

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = serviceLocator<UserCacheService>().getAuthToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {}
    handler.next(err);
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

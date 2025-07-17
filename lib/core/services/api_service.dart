import 'package:dio/dio.dart';
import 'package:overseas_front_end/core/shared/constants.dart';

import '../di/service_locator.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  static final String _baseUrl = Constant().featureBaseUrl;

  late final Dio _dio;

  factory ApiService() {
    return _instance;
  }

  ApiService._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        // 'Authorization': 'Bearer your_token_here',
      },
    );

    _dio = serviceLocator();
  }

  Future<dynamic> get(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        _handleError(response.data['message']);
      }
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        _handleError(response.data['message']);
      }
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        _handleError(response.data['message']);
      }
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  Future<dynamic> patch(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _dio.patch(endpoint, data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        _handleError(response.data['message']);
      }
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  Future<dynamic> delete(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.delete(endpoint,data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        _handleError(response.data['message']);
      }
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  void _handleError(DioException e) {
    if (e.response != null) {
      throw Exception(
          'Dio Error ${e.response?.statusCode}: ${e.response?.data}');
    } else {
      throw Exception('Dio Error: ${e.message}');
    }
  }
}

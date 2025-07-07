import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:overseas_front_end/controller/app_user_provider.dart';

import '../../../model/app_configs/config_model.dart';

class ConfigProvider extends ChangeNotifier {
  ConfigProvider._privateContstructor();
  static final ConfigProvider _instance = ConfigProvider._privateContstructor();
  factory ConfigProvider() {
    return _instance;
  }

  ConfigModel? configModel;

  void getConfigData() {
    configModel = ConfigModel.fromMap(AppUserProvider().data);
    notifyListeners();
  }

  Future<bool> editProgramApi({required Map<String, dynamic> data}) async {
    final response = await ApiService().patch("endpoint", data);
    if (response.statusCode == 200) return true;
    return false;
  }

  Future<bool> addProgramApi({required Map<String, dynamic> data}) async {
    final response = await ApiService().put("endpoint", data);
    if (response.statusCode == 200) return true;

    return false;
  }

  Future<bool> deleteProgramApi({required Map<String, dynamic> data}) async {
    final response = await ApiService().delete("endpoint", data);
    if (response.statusCode == 200) return true;

    return false;
  }

  // void editEducationProgram() {}

  // void addEducationProgram() {}

  // void deleteEducationProgram() {}

  // void editLangsProgram() {}

  // void addLangsProgram() {}

  // void deleteLangsProgram() {}

  // void editUniversityProgram() {}

  // void addUniversityProgram() {}

  // void deleteUniversityProgram() {}

  // void editIntakeProgram() {}

  // void addIntakeProgram() {}

  // void deleteIntakeProgram() {}

  // void editCountryProgram() {}

  // void addCountryProgram() {}

  // void deleteCountryProgram() {}

  // void editLeadCategoryProgram() {}

  // void addLeadCategoryProgram() {}

  // void deleteLeadCategoryProgram() {}

  // void editCountryProgram() {}

  // void addCountryProgram() {}

  // void deleteCountryProgram() {}

  // void editCountryProgram() {}

  // void addCountryProgram() {}

  // void deleteCountryProgram() {}
}

class ApiService {
  // Singleton pattern (optional but recommended)
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  late Dio _dio;

  void init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: '', // Replace with your API base URL
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    // You can add interceptors for logging, auth, etc.
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  Future<Response> get(String endpoint,
      {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: queryParams);
      return response;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Response> post(String endpoint, dynamic data) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Response> patch(String endpoint, dynamic data) async {
    try {
      final response = await _dio.patch(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Response> put(String endpoint, dynamic data) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Response> delete(String endpoint, data) async {
    try {
      final response = await _dio.delete(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  void _handleError(DioException e) {
    // Basic error handling
    if (e.type == DioExceptionType.connectionTimeout) {
      print("Connection Timeout");
    } else if (e.type == DioExceptionType.receiveTimeout) {
      print("Receive Timeout");
    } else if (e.type == DioExceptionType.badResponse) {
      print("Bad Response: ${e.response?.statusCode} - ${e.response?.data}");
    } else {
      print("Unhandled Dio error: $e");
    }
  }
}

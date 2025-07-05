import 'package:dio/dio.dart';

import 'auth_exception.dart';
import 'exception.dart';

class ErrHandler {
  static Exception transformException(Exception e) {
    if (e is ServerException) {
      return e;
    }
    if (e is DioException) {
      if (e.response != null) {
        final statusCode = e.response!.statusCode;
        if (statusCode == 401) {
          return AuthException();
        } else {
          return ServerException(
              e.response!.data['message'] ?? 'Unknown error');
        }
      } else if (e.type == DioExceptionType.connectionError) {
        return ServerException('Connection Error');
      } else {
        return ServerException(e.message ?? "Error To Load data Action");
      }
    } else {
      return ServerException("Error To Load data Action");
    }
  }
}

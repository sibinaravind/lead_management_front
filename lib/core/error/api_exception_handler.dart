//

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:overseas_front_end/core/error/handle_unathorized.dart';
import 'exception.dart';

Exception handleApiException(dynamic e) {
  if (e is DioException) {
    if (e.type == DioExceptionType.connectionError ||
        e.error is SocketException) {
      return ServerException(
          "No internet connection. Please check your network.");
    } else if (e.response != null) {
      if (e.response!.statusCode == 401) {
        handleUnauthorized(); // 👈 handle logout + redirect
        return ServerException('Unauthorized');
      }

      if (e.response!.statusCode == 403) {
        return ServerException('Blocked');
      }

      return ServerException(
        e.response!.data['message'] ?? "An error has occurred",
      );
    } else {
      return ServerException(e.message ?? "An unexpected error occurred");
    }
  } else if (e is SocketException) {
    return ServerException("Check your internet connection and try again.");
  } else {
    return ServerException("An error has occurred. Please try later.");
  }
}

// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'exception.dart';

// Exception handleApiException(dynamic e) {
//   if (e is DioException) {
//     if (e.type == DioExceptionType.connectionError ||
//         e.error is SocketException) {
//       return ServerException(
//           "No internet connection. Please check your network.");
//     } else if (e.response != null) {
//       return e.response!.statusCode == 403
//           ? ServerException('Blocked')
//           : ServerException(
//               e.response!.data['message'] ?? "An error has occurred");
//     } else {
//       return ServerException(e.message ?? "An unexpected error occurred");
//     }
//   } else if (e is SocketException) {
//     return ServerException("Check your internet connection and try again.");
//   } else {
//     return ServerException("An error has occurred. Please try later.");
//   }
// }

import 'dart:convert';
import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show compute;
import 'package:overseas_front_end/core/services/user_cache_service.dart';
import 'package:overseas_front_end/core/shared/constants.dart';

class OptimizedHttpService {
  static const Duration _uploadTimeout = Duration(minutes: 5);
  Future<Either<Exception, T>> postDocumentUpload<T>({
    required String endpoint,
    required dynamic body,
    required T Function(dynamic json) fromJson,
    Duration? timeout,
    Function(double)? onProgress,
  }) async {
    try {
      // print(
      //     "📤 POST Document Upload to ${Constant().featureBaseUrl + endpoint}");
      // Use longer timeout for uploads
      final requestTimeout = timeout ?? _uploadTimeout;

      // Process large JSON encoding in isolate to prevent UI blocking
      String encodedBody;
      if (body is Map && body.toString().length > 100000) {
        // print("📊 Large payload detected, processing in isolate...");
        encodedBody = await compute(_encodeJsonInIsolate, body);
      } else {
        encodedBody = jsonEncode(body);
      }

      // Simulate progress reporting
      if (onProgress != null) {
        onProgress(0.1); // Started encoding
      }

      final headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        'Authorization': await UserCacheService().getAuthToken() ?? ''
      };

      if (onProgress != null) {
        onProgress(0.3); // Headers prepared
      }
      final response = await http
          .post(
            Uri.parse(Constant().featureBaseUrl + endpoint),
            headers: headers,
            body: encodedBody,
          )
          .timeout(requestTimeout);

      if (onProgress != null) {
        onProgress(0.8);
      }

      // print("📥 Response status: ${response.statusCode}");
      // print("📥 Response size: ${response.body.length} bytes");

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.body.isEmpty) {
          return Left(Exception("Empty success response"));
        }

        // Process large JSON decoding in isolate for better performance
        dynamic decoded;
        if (response.body.length > 50000) {
          decoded = await compute(_decodeJsonInIsolate, response.body);
        } else {
          decoded = jsonDecode(response.body);
        }

        if (onProgress != null) {
          onProgress(1.0); // Complete
        }

        final data = decoded["data"];
        return Right(fromJson(data));
      } else {
        if (response.body.isEmpty) {
          return Left(Exception("Server error ${response.statusCode}"));
        }
        final decoded = jsonDecode(response.body);
        return Left(Exception(decoded["msg"] ?? "Unknown error"));
      }
    } on TimeoutException {
      return Left(Exception(
          "Request timeout. Please check your connection and try again."));
    } catch (e) {
      // Better error handling for different types of exceptions
      String errorMessage = e.toString();
      if (e.toString().contains('SocketException')) {
        errorMessage =
            "Network connection error. Please check your internet connection.";
      } else if (e.toString().contains('FormatException')) {
        errorMessage = "Invalid server response format.";
      } else if (e.toString().contains('HandshakeException')) {
        errorMessage = "SSL connection error. Please try again.";
      }

      return Left(Exception(errorMessage));
    }
  }

  String _encodeJsonInIsolate(dynamic data) {
    return jsonEncode(data);
  }

  dynamic _decodeJsonInIsolate(String jsonString) {
    return jsonDecode(jsonString);
  }
  // Regular HTTP requests (non-upload)
}

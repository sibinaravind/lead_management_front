import 'package:dio/dio.dart';
import 'package:jwt_decode_full/jwt_decode_full.dart';
import 'login_cache_service.dart';
import '../../core/services/api_service.dart';
import '../../core/shared/constants.dart';

class Session {
  final OfficerCacheService officerCacheService = OfficerCacheService();
  final ApiService _apiService = ApiService();

  String accessToken = '';
  bool tokenExpired = false;

  Future<String?> validateSession() async {
    try {
      final token = await officerCacheService.getToken();

      if (token != null) {
        accessToken = token;
        tokenExpired = jwtDecode(accessToken).isExpired ?? false;

        if (!tokenExpired) {
          return token;
        } else {
          // _apiService.logout(context);
          return null;
        }
      } else {
        return null;
      }
    } catch (ex) {
      throw Exception("Token check failed: $ex");
    }
  }
}

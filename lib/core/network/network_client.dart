import 'package:dio/dio.dart';
import '../shared/contants.dart';

class NetworkClient {
  final Dio _dio;
  final Constant constant;
  NetworkClient(this._dio, {required this.constant}) {
    _dio.options = BaseOptions(
        baseUrl: constant.featureBaseUrl,
        connectTimeout: const Duration(seconds: 5000),
        receiveTimeout: const Duration(seconds: 5000));
    _dio.interceptors
        .add(LogInterceptor(responseBody: true, requestBody: true));
    // _dio.interceptors.add(TokenInterceptor());
  }

  get dio => _dio;
}

// class TokenInterceptor extends Interceptor {
//   @override
//   void onRequest(
//       RequestOptions options, RequestInterceptorHandler handler) async {
//     try {
//       String? token = await UserCacheService().getAuthToken();
//       if (token != null) {
//         options.headers['Authorization'] = token;
//       }
//       if (FlavourConfig.partner() == Partner.affiniks) {
//         options.headers['x-api-key'] =
//             'uBzj6roJGPR4gxu6SvYS62LDRjnmid12wBssLAeb';
//       }
//     } catch (e) {}
//   }
// }

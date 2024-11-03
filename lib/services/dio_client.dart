import 'package:dio/dio.dart';

import 'package:flutter_chatgpt/services/token_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioClient {
  DioClient._internal(this._tokenManager);

  static final DioClient _instance = DioClient._internal(TokenManager());

  final TokenManager _tokenManager;

  factory DioClient() {
    return _instance;
  }

  final Dio _dio = Dio(BaseOptions(
    baseUrl: dotenv.env['BASE_URL']!,
    connectTimeout: const Duration(seconds: 10),
    contentType: Headers.jsonContentType,
  ))
    ..interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
      options.headers["authorization"] = "Bearer ${_instance._tokenManager.accessToken}";
      return handler.next(options);
    }, onResponse: (Response response, ResponseInterceptorHandler handler) {
      final responseData = response.data as Map<String, dynamic>;
      if (response.statusCode == 200) {
        return handler.resolve(Response(
            requestOptions: response.requestOptions,
            data: responseData,
            statusCode: response.statusCode,
            statusMessage: response.statusMessage));
      } else {
        return handler.reject(DioException(
            requestOptions: response.requestOptions, message: responseData.toString()));
      }
    }, onError: (DioException error, ErrorInterceptorHandler handler) async {
      final responseData = error.response!.data as Map<String, dynamic>;
      final dioException = DioException(
        requestOptions: error.requestOptions,
        message: responseData["error"],
      );

      if (error.response?.statusCode == 401) {
        // TODO: 跳转登录页
        return;
      }
      return handler.reject(dioException);
    }));

  static Dio get dio => _instance._dio;
}

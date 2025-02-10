// lib/core/interceptors/dio_interceptor.dart
import 'package:dio/dio.dart';
import 'package:iman_invest/core/config/api_config.dart';
/// Dio interceptor
class DioInterceptor extends Interceptor {
  /// Factory constructor for [DioInterceptor]
  factory DioInterceptor() {
    return _instance;
  }

  DioInterceptor._internal();
  static final DioInterceptor _instance = DioInterceptor._internal();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

    options.headers['Authorization'] = 'Bearer ${ApiClass.apiKey}';
    return super.onRequest(options, handler);
  }


  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Handle errors
    return super.onError(err, handler);
  }
}

// lib/core/interceptors/dio_interceptor.dart
import 'package:dio/dio.dart';
import 'package:iman_invest/core/config/api_config.dart';
class DioInterceptor extends Interceptor {
  static final DioInterceptor _instance = DioInterceptor._internal();

  factory DioInterceptor() {
    return _instance;
  }

  DioInterceptor._internal();

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

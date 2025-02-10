import 'package:dio/dio.dart';
import 'package:iman_invest/core/config/api_config.dart';
import 'package:iman_invest/core/network/dio_interceptor.dart';

///
class DioClient {
  ///
  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiClass.baseUrl,

        connectTimeout: const Duration(seconds: 10),
        // 5 seconds
        receiveTimeout: const Duration(seconds: 10),
        // 3 seconds
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    _dio.interceptors.add(DioInterceptor());
  }

  late Dio _dio;

  /// GET request
  Future<Response<dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get<Map<String,dynamic>>(
        endpoint,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException {
      rethrow; // Rethrow to be handled by caller or error handling strategy
    }
  }

  /// POST request
  Future<Response<dynamic>> post(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.post<Response<dynamic>>(
        endpoint,
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  /// PUT request
  Future<Response<dynamic>> put(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.put<Response<dynamic>>(
        endpoint,
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  /// DELETE request
  Future<Response<dynamic>> delete(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.delete<Response<dynamic>>(
        endpoint,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }
}

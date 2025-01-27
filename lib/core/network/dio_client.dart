import 'package:dio/dio.dart';
import 'package:iman_invest/core/config/api_config.dart';
import 'package:iman_invest/core/network/dio_interceptor.dart';

class DioClient {
  late Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiClass.baseUrl,

        connectTimeout: const Duration(seconds: 25),
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

  // GET request
  Future<Response> get(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await _dio.get(endpoint, queryParameters: queryParameters);
      return response;
    } on DioException {
      rethrow; // Rethrow to be handled by caller or error handling strategy
    }
  }

  // POST request
  Future<Response> post(String endpoint,
      {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.post(endpoint,
          data: data, queryParameters: queryParameters);
      return response;
    } on DioException {
      rethrow;
    }
  }

  // PUT request
  Future<Response> put(String endpoint,
      {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.put(endpoint,
          data: data, queryParameters: queryParameters);
      return response;
    } on DioException {
      rethrow;
    }
  }

  // DELETE request
  Future<Response> delete(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await _dio.delete(endpoint, queryParameters: queryParameters);
      return response;
    } on DioException {
      rethrow;
    }
  }
}

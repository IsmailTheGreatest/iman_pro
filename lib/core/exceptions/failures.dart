import 'package:dio/dio.dart';

///
abstract class Failure {
  ///
  const Failure(this.message);

  ///
  final String message;
}
///
class ServerFailure extends Failure{
  ///
  const ServerFailure(super.message);
}
///
class UnknownFailure extends Failure{
  ///
  const UnknownFailure(super.message);
}

///
class NetworkFailure extends Failure{
  ///
  const NetworkFailure(super.message);
}
///
class ParsingFailure extends Failure{
  ///
  const ParsingFailure(super.message);
}
///
class DioExceptionMapper {
  ///
  static Failure mapDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return const NetworkFailure('Connection timed out');
      case DioExceptionType.sendTimeout:
        return const NetworkFailure('Request send timeout');
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure('Response receive timeout');
      case DioExceptionType.badResponse:
        return ServerFailure(
            dioException.response?.statusMessage ?? 'Bad response',);
      case DioExceptionType.cancel:
        return const UnknownFailure('Request was cancelled');
      case DioExceptionType.connectionError:
        return const NetworkFailure('No internet connection');
      case DioExceptionType.unknown:
        return UnknownFailure(dioException.error.toString());
      case DioExceptionType.badCertificate:
        return const NetworkFailure('Bad certificate');
      }
  }
}

///
class AppException implements Exception {
  ///
  const AppException(this.message);

  ///
  final String message;

  @override
  String toString() => message;
}

///
class ParsingException extends AppException {
  ///
  const ParsingException([super.message = 'Parsing error occurred']);
}

///
class ServerException extends AppException {
  ///
  const ServerException(
    this.statusCode, [
    super.message = 'Server error occurred',
  ]);

  ///
  final int? statusCode;
}

///
class UnknownException extends AppException {
  ///
  const UnknownException([super.message = 'An unknown error occurred']);
}

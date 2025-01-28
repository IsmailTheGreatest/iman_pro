

class AppException implements Exception {
  final String message;

  const AppException(this.message);

  @override
  String toString() => message;
}

class ParsingException extends AppException {
  const ParsingException([super.message = "Parsing error occurred"]);
}

class ServerException extends AppException {
  final int? statusCode;

  const ServerException(this.statusCode,
      [super.message = "Server error occurred"]);
}

class UnknownException extends AppException {
  const UnknownException([super.message = "An unknown error occurred"]);
}

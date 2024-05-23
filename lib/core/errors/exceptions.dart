/// Base exception class with a message
abstract class BaseException implements Exception {
  final String? message;
  BaseException(this.message);
}

/// Exception representing errors related to server communication.
class ServerException extends BaseException {
  ServerException({String? message}) : super(message);
}

/// Exception representing errors related to caching data.
class CacheException extends BaseException {
  CacheException({String? message}) : super(message);
}

/// Exception representing errors related to network connectivity.
class NetworkException extends BaseException {
  NetworkException({String? message}) : super(message);
}

/// Exception representing errors related to Firebase .
class FBException extends BaseException {
  FBException({required String message}) : super(message);
}

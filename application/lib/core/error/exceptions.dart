/// Base exception class for the application
abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalException;

  const AppException(
    this.message, {
    this.code,
    this.originalException,
  });

  @override
  String toString() => 'AppException: $message';
}

/// Domain-specific exceptions
class DomainException extends AppException {
  const DomainException(
    String message, {
    String? code,
    dynamic originalException,
  }) : super(message, code: code, originalException: originalException);
}

/// Infrastructure-specific exceptions
class InfrastructureException extends AppException {
  const InfrastructureException(
    String message, {
    String? code,
    dynamic originalException,
  }) : super(message, code: code, originalException: originalException);
}

/// Network-related exceptions
class NetworkException extends InfrastructureException {
  const NetworkException(
    String message, {
    String? code,
    dynamic originalException,
  }) : super(message, code: code, originalException: originalException);
}

/// Cache-related exceptions
class CacheException extends InfrastructureException {
  const CacheException(
    String message, {
    String? code,
    dynamic originalException,
  }) : super(message, code: code, originalException: originalException);
}
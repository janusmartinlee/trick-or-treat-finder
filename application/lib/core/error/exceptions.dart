/// Base exception class for the application
abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalException;

  const AppException(this.message, {this.code, this.originalException});

  @override
  String toString() => 'AppException: $message';
}

/// Domain-specific exceptions
class DomainException extends AppException {
  const DomainException(super.message, {super.code, super.originalException});
}

/// Infrastructure-specific exceptions
class InfrastructureException extends AppException {
  const InfrastructureException(
    super.message, {
    super.code,
    super.originalException,
  });
}

/// Network-related exceptions
class NetworkException extends InfrastructureException {
  const NetworkException(super.message, {super.code, super.originalException});
}

/// Cache-related exceptions
class CacheException extends InfrastructureException {
  const CacheException(super.message, {super.code, super.originalException});
}

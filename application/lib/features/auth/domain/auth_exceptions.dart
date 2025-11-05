/// Exception thrown when authentication fails.
///
/// This is a domain-level exception - infrastructure adapters translate
/// their specific errors (Firebase exceptions, HTTP errors, etc.) into this.
class AuthException implements Exception {
  const AuthException(this.message);

  final String message;

  @override
  String toString() => 'AuthException: $message';
}

/// Exception thrown when user is not authenticated but tries to access
/// protected functionality.
class NotAuthenticatedException implements Exception {
  const NotAuthenticatedException([this.message = 'User not authenticated']);

  final String message;

  @override
  String toString() => 'NotAuthenticatedException: $message';
}

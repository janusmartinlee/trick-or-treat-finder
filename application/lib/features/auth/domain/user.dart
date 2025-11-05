/// Domain entity representing an authenticated user.
///
/// This is a core domain concept that encapsulates user identity.
/// It's infrastructure-agnostic - doesn't know about Firebase, OAuth, etc.
///
/// Why immutable?
/// - Represents a snapshot of user state at a point in time
/// - Thread-safe for concurrent access
/// - Easier to reason about state changes (new instance = new state)
class User {
  const User({
    required this.id,
    required this.email,
    this.displayName,
    this.photoUrl,
  });

  /// Unique identifier for the user (from auth provider)
  final String id;

  /// User's email address
  final String email;

  /// Optional display name
  final String? displayName;

  /// Optional profile photo URL
  final String? photoUrl;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email &&
          displayName == other.displayName &&
          photoUrl == other.photoUrl;

  @override
  int get hashCode =>
      id.hashCode ^
      email.hashCode ^
      displayName.hashCode ^
      photoUrl.hashCode;

  @override
  String toString() =>
      'User(id: $id, email: $email, displayName: $displayName)';
}

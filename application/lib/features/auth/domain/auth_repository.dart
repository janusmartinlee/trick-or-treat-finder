import 'user.dart';

/// Port (interface) defining authentication operations.
///
/// This is the boundary between domain and infrastructure. The domain
/// defines WHAT auth operations are needed, infrastructure defines HOW
/// to perform them (Firebase, mock, etc.).
///
/// Ports & Adapters Pattern:
/// - PORT: This interface (what the application needs)
/// - ADAPTERS: FirebaseAuthAdapter, InMemoryAuthRepository (how to provide it)
///
/// Why use this pattern?
/// - Domain stays pure - no Firebase/HTTP/storage dependencies
/// - Easy testing - swap in mock adapter for tests
/// - Flexibility - switch auth providers without changing domain logic
/// - Clear boundaries - adapter can't leak implementation details
///
/// Example adapters that could implement this:
/// - FirebaseAuthAdapter (production OAuth sign-in)
/// - InMemoryAuthRepository (testing/development)
/// - Auth0Adapter (alternative OAuth provider)
/// - MockAuthRepository (for widget tests)
abstract interface class AuthRepository {
  /// Stream of authentication state changes.
  ///
  /// Emits:
  /// - User when signed in
  /// - null when signed out
  ///
  /// This allows the application to reactively respond to auth changes
  /// (user signs in, signs out, token expires, etc.)
  Stream<User?> get authStateChanges;

  /// Get currently authenticated user, or null if signed out.
  Future<User?> getCurrentUser();

  /// Sign in with email and password.
  ///
  /// Throws [AuthException] if sign-in fails.
  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Sign in with Google OAuth.
  ///
  /// Throws [AuthException] if sign-in fails.
  Future<User> signInWithGoogle();

  /// Sign out current user.
  ///
  /// Does nothing if no user is signed in.
  Future<void> signOut();
}

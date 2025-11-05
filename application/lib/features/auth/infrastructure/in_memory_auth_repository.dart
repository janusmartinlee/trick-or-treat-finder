import 'dart:async';

import '../domain/auth_exceptions.dart';
import '../domain/auth_repository.dart';
import '../domain/user.dart';

/// In-memory adapter for testing and development.
///
/// Ports & Adapters Pattern:
/// - Implements AuthRepository port from domain
/// - Provides fake authentication for tests and development
/// - No external dependencies (no Firebase, no HTTP, no storage)
///
/// Use cases:
/// - Unit tests - test domain/application logic without real auth
/// - Widget tests - test UI without Firebase setup
/// - Development - work on features before auth provider is ready
///
/// Production alternative: FirebaseAuthAdapter
class InMemoryAuthRepository implements AuthRepository {
  InMemoryAuthRepository() {
    _controller = StreamController<User?>.broadcast(
      onListen: () => _controller.add(_currentUser),
    );
  }

  late final StreamController<User?> _controller;
  User? _currentUser;

  // Pre-configured test users for easy testing
  static final _testUsers = {
    'test@example.com': const User(
      id: 'test-user-1',
      email: 'test@example.com',
      displayName: 'Test User',
    ),
    'admin@example.com': const User(
      id: 'admin-user-1',
      email: 'admin@example.com',
      displayName: 'Admin User',
    ),
  };

  @override
  Stream<User?> get authStateChanges => _controller.stream;

  @override
  Future<User?> getCurrentUser() async => _currentUser;

  @override
  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 100));

    // Check for test users
    final user = _testUsers[email];
    if (user != null && password == 'password') {
      _currentUser = user;
      _controller.add(user);
      return user;
    }

    throw const AuthException('Invalid email or password');
  }

  @override
  Future<User> signInWithGoogle() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 100));

    // Return a fake Google user
    const user = User(
      id: 'google-user-1',
      email: 'google.user@gmail.com',
      displayName: 'Google User',
      photoUrl: 'https://example.com/photo.jpg',
    );

    _currentUser = user;
    _controller.add(user);
    return user;
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 50));
    _currentUser = null;
    _controller.add(null);
  }

  /// Test helper: Set current user without going through sign-in flow.
  /// Useful for setting up test scenarios.
  void setCurrentUser(User? user) {
    _currentUser = user;
    _controller.add(user);
  }

  /// Clean up resources
  void dispose() {
    _controller.close();
  }
}

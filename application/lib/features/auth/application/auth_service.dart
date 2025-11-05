import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/auth_repository.dart';
import '../domain/user.dart';
import 'auth_providers.dart';

part 'auth_service.g.dart';

/// Application service orchestrating authentication use cases.
///
/// This is the application layer - coordinates domain objects and ports
/// to fulfill use cases. No UI code, no infrastructure code.
///
/// Architecture layers:
/// - Domain: User, AuthRepository (port), AuthException
/// - Application: AuthService (this) - orchestrates domain
/// - Infrastructure: InMemoryAuthRepository, FirebaseAuthAdapter (adapters)
/// - Presentation: Login widgets, auth state UI
@riverpod
class AuthService extends _$AuthService {
  @override
  FutureOr<User?> build() async {
    // Initialize with current user
    final repository = ref.watch(authRepositoryProvider);
    return await repository.getCurrentUser();
  }

  /// Sign in with email and password.
  ///
  /// Updates state on success, throws AuthException on failure.
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);
      return await repository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    });
  }

  /// Sign in with Google OAuth.
  ///
  /// Updates state on success, throws AuthException on failure.
  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);
      return await repository.signInWithGoogle();
    });
  }

  /// Sign out current user.
  ///
  /// Sets state to null on success.
  Future<void> signOut() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);
      await repository.signOut();
      return null;
    });
  }
}

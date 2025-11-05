import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/dependency_injection.dart';
import '../domain/auth_repository.dart';
import '../domain/user.dart';

part 'auth_providers.g.dart';

/// Provider for AuthRepository port.
///
/// Gets the concrete adapter from dependency injection (service locator).
/// This bridges infrastructure (get_it) with application (Riverpod).
///
/// The actual implementation is configured in core/dependency_injection.dart:
/// - Development/testing: InMemoryAuthRepository
/// - Production: FirebaseAuthAdapter (when implemented)
@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return serviceLocator<AuthRepository>();
}

/// Stream provider for current user authentication state.
///
/// Emits:
/// - User object when authenticated
/// - null when signed out
///
/// UI can watch this to reactively update based on auth state.
@riverpod
Stream<User?> authStateChanges(AuthStateChangesRef ref) {
  final repository = ref.watch(authRepositoryProvider);
  return repository.authStateChanges;
}

/// Provider for current user.
///
/// Returns null if user is not authenticated.
/// UI can use this to show/hide authenticated content.
@riverpod
Future<User?> currentUser(CurrentUserRef ref) {
  final repository = ref.watch(authRepositoryProvider);
  return repository.getCurrentUser();
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authServiceHash() => r'82c3518973c86ca3ec9175c70cd95dcdb49e598b';

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
///
/// Copied from [AuthService].
@ProviderFor(AuthService)
final authServiceProvider =
    AutoDisposeAsyncNotifierProvider<AuthService, User?>.internal(
      AuthService.new,
      name: r'authServiceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$authServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AuthService = AutoDisposeAsyncNotifier<User?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

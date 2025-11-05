// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preferences_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$preferencesRepositoryHash() =>
    r'b0a1a4a8e9ea7317948c8502d36358a92ee20461';

/// Provider for preferences repository
///
/// This is the infrastructure layer - provides access to data persistence
///
/// Copied from [preferencesRepository].
@ProviderFor(preferencesRepository)
final preferencesRepositoryProvider =
    AutoDisposeProvider<PreferencesRepository>.internal(
      preferencesRepository,
      name: r'preferencesRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$preferencesRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PreferencesRepositoryRef =
    AutoDisposeProviderRef<PreferencesRepository>;
String _$preferencesHash() => r'8fc4be3c03baddd82244b73c7fa24233e5bb9662';

/// Stream provider for user preferences
///
/// Watches the preferences stream and rebuilds dependent widgets when
/// preferences change. This is the reactive data source for the app.
///
/// Copied from [preferences].
@ProviderFor(preferences)
final preferencesProvider = AutoDisposeStreamProvider<UserPreferences>.internal(
  preferences,
  name: r'preferencesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$preferencesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PreferencesRef = AutoDisposeStreamProviderRef<UserPreferences>;
String _$preferencesNotifierHash() =>
    r'693e6251bfe475f25fa95be1759ca25ec9f508db';

/// Notifier for managing preference updates
///
/// This is the application layer - contains business logic for managing
/// user preferences including theme mode and locale selection.
///
/// Follows Clean Architecture:
/// - Presentation calls this notifier
/// - Notifier orchestrates domain entities
/// - Repository handles persistence
///
/// Copied from [PreferencesNotifier].
@ProviderFor(PreferencesNotifier)
final preferencesNotifierProvider =
    AutoDisposeAsyncNotifierProvider<
      PreferencesNotifier,
      UserPreferences
    >.internal(
      PreferencesNotifier.new,
      name: r'preferencesNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$preferencesNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PreferencesNotifier = AutoDisposeAsyncNotifier<UserPreferences>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

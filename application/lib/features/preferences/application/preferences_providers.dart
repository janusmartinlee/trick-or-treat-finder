import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/user_preferences.dart';
import '../domain/preferences_repository.dart';
import '../../../core/dependency_injection.dart';

part 'preferences_providers.g.dart';

/// Provider for preferences repository
/// 
/// This is the infrastructure layer - provides access to data persistence
@riverpod
PreferencesRepository preferencesRepository(PreferencesRepositoryRef ref) {
  return serviceLocator<PreferencesRepository>();
}

/// Stream provider for user preferences
/// 
/// Watches the preferences stream and rebuilds dependent widgets when
/// preferences change. This is the reactive data source for the app.
@riverpod
Stream<UserPreferences> preferences(PreferencesRef ref) {
  final repository = ref.watch(preferencesRepositoryProvider);
  return repository.preferencesStream;
}

/// Notifier for managing preference updates
/// 
/// This is the application layer - contains business logic for managing
/// user preferences including theme mode and locale selection.
/// 
/// Follows Clean Architecture:
/// - Presentation calls this notifier
/// - Notifier orchestrates domain entities
/// - Repository handles persistence
@riverpod
class PreferencesNotifier extends _$PreferencesNotifier {
  @override
  Future<UserPreferences> build() async {
    // Get initial preferences from repository
    final repository = ref.watch(preferencesRepositoryProvider);
    return repository.getPreferences();
  }

  /// Update the theme mode preference
  /// 
  /// Business logic: Get current state, create updated entity, persist
  Future<void> updateThemeMode(ThemeMode themeMode) async {
    state = const AsyncValue.loading();
    
    try {
      final repository = ref.read(preferencesRepositoryProvider);
      final currentPrefs = await repository.getPreferences();
      
      // Domain logic: Create new entity with updated value
      final updatedPrefs = currentPrefs.copyWith(themeMode: themeMode);
      
      // Persist through repository
      await repository.savePreferences(updatedPrefs);
      
      // Update state
      state = AsyncValue.data(updatedPrefs);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Update the locale preference
  /// 
  /// Business logic: Get current state, create updated entity, persist
  Future<void> updateLocale(Locale locale) async {
    state = const AsyncValue.loading();
    
    try {
      final repository = ref.read(preferencesRepositoryProvider);
      final currentPrefs = await repository.getPreferences();
      
      // Domain logic: Create new entity with updated value
      final updatedPrefs = currentPrefs.copyWith(locale: locale);
      
      // Persist through repository
      await repository.savePreferences(updatedPrefs);
      
      // Update state
      state = AsyncValue.data(updatedPrefs);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

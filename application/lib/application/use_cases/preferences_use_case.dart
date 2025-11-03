import 'package:flutter/material.dart';
import '../../domain/entities/user_preferences.dart';
import '../../domain/repositories/preferences_repository.dart';

/// Use case for managing user preferences
class PreferencesUseCase {
  final PreferencesRepository _repository;

  const PreferencesUseCase(this._repository);

  /// Get current user preferences
  Future<UserPreferences> getPreferences() async {
    return await _repository.getPreferences();
  }

  /// Update theme mode
  Future<void> updateThemeMode(ThemeMode themeMode) async {
    final currentPreferences = await _repository.getPreferences();
    final updatedPreferences = currentPreferences.copyWith(
      themeMode: themeMode,
    );
    await _repository.savePreferences(updatedPreferences);
  }

  /// Update locale
  Future<void> updateLocale(Locale locale) async {
    final currentPreferences = await _repository.getPreferences();
    final updatedPreferences = currentPreferences.copyWith(locale: locale);
    await _repository.savePreferences(updatedPreferences);
  }

  /// Update all preferences
  Future<void> updatePreferences(UserPreferences preferences) async {
    await _repository.savePreferences(preferences);
  }

  /// Stream of preference changes
  Stream<UserPreferences> get preferencesStream =>
      _repository.preferencesStream;
}

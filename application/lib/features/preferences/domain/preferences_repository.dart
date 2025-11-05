import 'user_preferences.dart';

/// Repository interface for user preferences storage
abstract class PreferencesRepository {
  /// Get user preferences
  Future<UserPreferences> getPreferences();

  /// Save user preferences
  Future<void> savePreferences(UserPreferences preferences);

  /// Stream of preference changes
  Stream<UserPreferences> get preferencesStream;
}

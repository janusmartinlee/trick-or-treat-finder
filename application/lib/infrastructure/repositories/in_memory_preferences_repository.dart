import 'dart:async';
import '../../domain/entities/user_preferences.dart';
import '../../domain/repositories/preferences_repository.dart';

/// In-memory implementation of preferences repository
/// TODO: Replace with persistent storage (SharedPreferences, Hive, etc.)
class InMemoryPreferencesRepository implements PreferencesRepository {
  UserPreferences _preferences = UserPreferences.defaultPreferences;
  final StreamController<UserPreferences> _controller =
      StreamController<UserPreferences>.broadcast();

  @override
  Future<UserPreferences> getPreferences() async {
    return _preferences;
  }

  @override
  Future<void> savePreferences(UserPreferences preferences) async {
    _preferences = preferences;
    _controller.add(_preferences);
  }

  @override
  Stream<UserPreferences> get preferencesStream => _controller.stream;

  /// Dispose resources
  void dispose() {
    _controller.close();
  }
}

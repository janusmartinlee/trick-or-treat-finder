import 'dart:async';
import '../domain/user_preferences.dart';
import '../domain/preferences_repository.dart';

/// Adapter that implements PreferencesRepository using in-memory storage
/// 
/// This is a **Ports & Adapters** (Hexagonal Architecture) implementation:
/// - **Port (Interface)**: PreferencesRepository in domain layer defines "what" we need
/// - **Adapter (Implementation)**: This class in infrastructure layer defines "how" we do it
/// 
/// Key Benefits of Ports & Adapters:
/// 1. **Testability**: Domain logic can be tested without real storage
/// 2. **Flexibility**: Easy to swap adapters (in-memory → SharedPreferences → cloud)
/// 3. **Independence**: Domain doesn't know about infrastructure details
/// 4. **Maintainability**: Changes to storage don't affect domain logic
/// 
/// Dependency Flow (Dependency Inversion Principle):
/// ```
/// Domain (Port: PreferencesRepository) ← Infrastructure (Adapter: InMemoryPreferencesRepository)
/// ```
/// Infrastructure depends on domain, never the reverse!
/// 
/// Usage:
/// ```dart
/// // In dependency_injection.dart
/// final repository = InMemoryPreferencesRepository();
/// 
/// // Domain/application code only knows about the port:
/// PreferencesRepository repo = serviceLocator<PreferencesRepository>();
/// ```
/// 
/// Note: This is a temporary adapter for development/testing.
/// For production, use SharedPreferencesAdapter or another persistent adapter.
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

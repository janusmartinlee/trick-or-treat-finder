import 'user_preferences.dart';

/// Port (Interface) for user preferences storage
/// 
/// This is a **Port** in the Ports & Adapters (Hexagonal Architecture) pattern.
/// 
/// What is a Port?
/// - An interface defined by the domain layer
/// - Declares "what" the application needs, not "how" to do it
/// - Infrastructure adapters implement this interface
/// 
/// Why use this pattern?
/// 1. **Domain Independence**: Business logic doesn't depend on specific storage
/// 2. **Testability**: Easy to mock for tests
/// 3. **Flexibility**: Swap implementations without changing domain code
/// 4. **Clean Architecture**: Maintains proper dependency direction
/// 
/// Example Adapters:
/// - InMemoryPreferencesRepository (for testing/development)
/// - SharedPreferencesAdapter (for persistent local storage)
/// - FirebasePreferencesAdapter (for cloud sync)
/// - SqlitePreferencesAdapter (for structured storage)
/// 
/// The application layer uses this interface through Riverpod providers,
/// never knowing about the specific adapter implementation.
abstract class PreferencesRepository {
  /// Get user preferences
  Future<UserPreferences> getPreferences();

  /// Save user preferences
  Future<void> savePreferences(UserPreferences preferences);

  /// Stream of preference changes
  Stream<UserPreferences> get preferencesStream;
}

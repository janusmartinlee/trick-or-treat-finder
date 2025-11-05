import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/user_preferences.dart';
import '../domain/preferences_repository.dart';

/// Adapter that implements PreferencesRepository using SharedPreferences
/// 
/// This is a **Ports & Adapters** implementation:
/// - Port (Interface): PreferencesRepository in domain layer
/// - Adapter (Implementation): This class in infrastructure layer
/// 
/// Benefits of this pattern:
/// - Domain logic doesn't know about SharedPreferences
/// - Easy to swap implementations (in-memory, SharedPreferences, cloud, etc.)
/// - Infrastructure details isolated from business logic
/// - Testing is easier (can mock the port interface)
class SharedPreferencesAdapter implements PreferencesRepository {
  static const String _preferencesKey = 'user_preferences';
  
  final SharedPreferences _sharedPreferences;
  final StreamController<UserPreferences> _controller =
      StreamController<UserPreferences>.broadcast();

  SharedPreferencesAdapter(this._sharedPreferences);

  /// Factory constructor that handles async initialization
  /// 
  /// Use this to create the adapter:
  /// ```dart
  /// final adapter = await SharedPreferencesAdapter.create();
  /// ```
  static Future<SharedPreferencesAdapter> create() async {
    final prefs = await SharedPreferences.getInstance();
    return SharedPreferencesAdapter(prefs);
  }

  @override
  Future<UserPreferences> getPreferences() async {
    final jsonString = _sharedPreferences.getString(_preferencesKey);
    
    if (jsonString == null) {
      return UserPreferences.defaultPreferences;
    }

    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return UserPreferences.fromJson(json);
    } catch (e) {
      // If deserialization fails, return defaults
      return UserPreferences.defaultPreferences;
    }
  }

  @override
  Future<void> savePreferences(UserPreferences preferences) async {
    final jsonString = jsonEncode(preferences.toJson());
    await _sharedPreferences.setString(_preferencesKey, jsonString);
    
    // Notify listeners of the change
    _controller.add(preferences);
  }

  @override
  Stream<UserPreferences> get preferencesStream => _controller.stream;

  /// Clean up resources
  void dispose() {
    _controller.close();
  }
}

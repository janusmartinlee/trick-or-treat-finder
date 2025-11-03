import 'package:flutter/material.dart';

/// User preferences entity
class UserPreferences {
  final ThemeMode themeMode;
  final Locale locale;

  const UserPreferences({required this.themeMode, required this.locale});

  /// Create a copy with modified values
  UserPreferences copyWith({ThemeMode? themeMode, Locale? locale}) {
    return UserPreferences(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
    );
  }

  /// Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'themeMode': themeMode.index,
      'locale': {
        'languageCode': locale.languageCode,
        'countryCode': locale.countryCode,
      },
    };
  }

  /// Create from JSON
  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    final localeData = json['locale'] as Map<String, dynamic>;
    return UserPreferences(
      themeMode: ThemeMode.values[json['themeMode'] as int],
      locale: Locale(
        localeData['languageCode'] as String,
        localeData['countryCode'] as String?,
      ),
    );
  }

  /// Default preferences
  static const UserPreferences defaultPreferences = UserPreferences(
    themeMode: ThemeMode.system,
    locale: Locale('en', 'US'),
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserPreferences &&
          runtimeType == other.runtimeType &&
          themeMode == other.themeMode &&
          locale == other.locale;

  @override
  int get hashCode => themeMode.hashCode ^ locale.hashCode;
}

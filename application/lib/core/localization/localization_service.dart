import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// Localization service for managing app internationalization
class LocalizationService {
  /// Supported locales for the application
  static const List<Locale> supportedLocales = [
    Locale('en', 'US'), // English (United States)
    // Add more locales as needed:
    // Locale('es', 'ES'), // Spanish (Spain)
    // Locale('fr', 'FR'), // French (France)
  ];

  /// Localization delegates for the app
  static const List<LocalizationsDelegate> localizationsDelegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    // AppLocalizations.delegate will be added after code generation
  ];

  /// Locale resolution callback
  static Locale? localeResolutionCallback(
    List<Locale>? locales,
    Iterable<Locale> supportedLocales,
  ) {
    // Check if the current device locale is supported
    if (locales != null) {
      for (final locale in locales) {
        if (supportedLocales.any((supportedLocale) =>
            supportedLocale.languageCode == locale.languageCode &&
            supportedLocale.countryCode == locale.countryCode)) {
          return locale;
        }
      }
      
      // If no exact match, try to find a match by language code only
      for (final locale in locales) {
        if (supportedLocales.any((supportedLocale) =>
            supportedLocale.languageCode == locale.languageCode)) {
          return supportedLocales.firstWhere((supportedLocale) =>
              supportedLocale.languageCode == locale.languageCode);
        }
      }
    }
    
    // Return the first supported locale as fallback
    return supportedLocales.first;
  }
}
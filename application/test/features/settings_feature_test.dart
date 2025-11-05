import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:trick_or_treat_finder/features/preferences/domain/user_preferences.dart';
import 'package:trick_or_treat_finder/features/preferences/domain/preferences_repository.dart';
import 'package:trick_or_treat_finder/features/preferences/infrastructure/in_memory_preferences_repository.dart';

void main() {
  group('Feature: User preferences management', () {
    late PreferencesRepository repository;

    setUp(() {
      repository = InMemoryPreferencesRepository();
    });

    group('Scenario: User changes theme preference', () {
      test(
        'Given default preferences, When user changes to dark theme, Then preferences are updated',
        () async {
          // Given - default preferences
          final initialPreferences = await repository.getPreferences();
          expect(initialPreferences.themeMode, equals(ThemeMode.system));

          // When - user changes to dark theme
          final updated = initialPreferences.copyWith(themeMode: ThemeMode.dark);
          await repository.savePreferences(updated);

          // Then - preferences are updated
          final updatedPreferences = await repository.getPreferences();
          expect(updatedPreferences.themeMode, equals(ThemeMode.dark));
        },
      );

      test(
        'Given dark theme selected, When user changes to light theme, Then preferences are updated',
        () async {
          // Given - dark theme selected
          var prefs = await repository.getPreferences();
          prefs = prefs.copyWith(themeMode: ThemeMode.dark);
          await repository.savePreferences(prefs);

          // When - user changes to light theme
          prefs = prefs.copyWith(themeMode: ThemeMode.light);
          await repository.savePreferences(prefs);

          // Then - preferences are updated
          final updatedPreferences = await repository.getPreferences();
          expect(updatedPreferences.themeMode, equals(ThemeMode.light));
        },
      );
    });

    group('Scenario: User changes language preference', () {
      test(
        'Given default locale, When user changes to Spanish, Then preferences are updated',
        () async {
          // Given - default locale
          final initialPreferences = await repository.getPreferences();
          expect(initialPreferences.locale, equals(const Locale('en', 'US')));

          // When - user changes to Spanish
          final updated = initialPreferences.copyWith(locale: const Locale('es', 'ES'));
          await repository.savePreferences(updated);

          // Then - preferences are updated
          final updatedPreferences = await repository.getPreferences();
          expect(updatedPreferences.locale, equals(const Locale('es', 'ES')));
        },
      );

      test(
        'Given English locale, When user changes to Danish, Then preferences are updated',
        () async {
          // Given - English locale (default)
          final initialPreferences = await repository.getPreferences();
          expect(initialPreferences.locale, equals(const Locale('en', 'US')));

          // When - user changes to Danish
          final updated = initialPreferences.copyWith(locale: const Locale('da', 'DK'));
          await repository.savePreferences(updated);

          // Then - preferences are updated
          final updatedPreferences = await repository.getPreferences();
          expect(updatedPreferences.locale, equals(const Locale('da', 'DK')));
        },
      );
    });

    group('Scenario: Preferences persistence', () {
      test(
        'Given preferences are set, When retrieving preferences, Then correct values are returned',
        () async {
          // Given - preferences are set
          const testPreferences = UserPreferences(
            themeMode: ThemeMode.dark,
            locale: Locale('fr', 'FR'),
          );
          await repository.savePreferences(testPreferences);

          // When - retrieving preferences
          final retrievedPreferences = await repository.getPreferences();

          // Then - correct values are returned
          expect(retrievedPreferences.themeMode, equals(ThemeMode.dark));
          expect(retrievedPreferences.locale, equals(const Locale('fr', 'FR')));
        },
      );
    });

    group('Scenario: Preferences change notification', () {
      test(
        'Given listening to preferences stream, When preferences change, Then stream emits new values',
        () async {
          // Given - listening to preferences stream
          final streamEvents = <UserPreferences>[];

          final subscription = repository.preferencesStream.listen((preferences) {
            streamEvents.add(preferences);
          });

          // When - preferences change
          final prefs = await repository.getPreferences();
          final updated = prefs.copyWith(themeMode: ThemeMode.dark);
          await repository.savePreferences(updated);

          // Then - stream should have emitted at least one event
          await Future.delayed(const Duration(milliseconds: 10)); // Wait for stream
          expect(streamEvents.length, greaterThanOrEqualTo(1));
          expect(streamEvents.last.themeMode, equals(ThemeMode.dark));

          await subscription.cancel();
        },
      );
    });
  });
}

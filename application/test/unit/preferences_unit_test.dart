import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:trick_or_treat_finder/features/preferences/domain/user_preferences.dart';
import 'package:trick_or_treat_finder/features/preferences/infrastructure/in_memory_preferences_repository.dart';

void main() {
  group('Unit Tests: User Preferences Logic', () {
    late InMemoryPreferencesRepository repository;

    setUp(() {
      repository = InMemoryPreferencesRepository();
    });

    tearDown(() {
      repository.dispose();
    });

    test(
      'Given default preferences, When getting preferences, Then returns system theme and EN locale',
      () async {
        // Given - default preferences
        // When - getting preferences
        final preferences = await repository.getPreferences();

        // Then - returns system theme and EN locale
        expect(preferences.themeMode, equals(ThemeMode.system));
        expect(preferences.locale, equals(const Locale('en', 'US')));
      },
    );

    test(
      'Given system theme, When updating to dark theme, Then theme mode changes to dark',
      () async {
        // Given - system theme (default)
        final initialPreferences = await repository.getPreferences();
        expect(initialPreferences.themeMode, equals(ThemeMode.system));

        // When - updating to dark theme
        final updated = initialPreferences.copyWith(themeMode: ThemeMode.dark);
        await repository.savePreferences(updated);

        // Then - theme mode changes to dark
        final updatedPreferences = await repository.getPreferences();
        expect(updatedPreferences.themeMode, equals(ThemeMode.dark));
        expect(
          updatedPreferences.locale,
          equals(const Locale('en', 'US')),
        ); // Locale unchanged
      },
    );

    test(
      'Given EN locale, When updating to ES locale, Then locale changes to Spanish',
      () async {
        // Given - EN locale (default)
        final initialPreferences = await repository.getPreferences();
        expect(initialPreferences.locale, equals(const Locale('en', 'US')));

        // When - updating to ES locale
        final updated = initialPreferences.copyWith(locale: const Locale('es', 'ES'));
        await repository.savePreferences(updated);

        // Then - locale changes to Spanish
        final updatedPreferences = await repository.getPreferences();
        expect(updatedPreferences.locale, equals(const Locale('es', 'ES')));
        expect(
          updatedPreferences.themeMode,
          equals(ThemeMode.system),
        ); // Theme unchanged
      },
    );

    test(
      'Given preferences changes, When listening to stream, Then stream emits updates',
      () async {
        // Given - listening to preferences stream
        final streamUpdates = <UserPreferences>[];
        final subscription = repository.preferencesStream.listen(
          streamUpdates.add,
        );

        // When - changing preferences
        final current = await repository.getPreferences();
        final updated = current.copyWith(themeMode: ThemeMode.dark);
        await repository.savePreferences(updated);

        // Then - stream emits updates
        await Future.delayed(const Duration(milliseconds: 10)); // Wait for stream
        expect(streamUpdates.length, equals(1));
        expect(streamUpdates.first.themeMode, equals(ThemeMode.dark));

        await subscription.cancel();
      },
    );

    test(
      'Given multiple preference changes, When applied in sequence, Then all changes persist',
      () async {
        // Given - default preferences
        // When - applying multiple changes
        var prefs = await repository.getPreferences();
        prefs = prefs.copyWith(themeMode: ThemeMode.dark);
        await repository.savePreferences(prefs);
        prefs = prefs.copyWith(locale: const Locale('fr', 'FR'));
        await repository.savePreferences(prefs);
        prefs = prefs.copyWith(themeMode: ThemeMode.light);
        await repository.savePreferences(prefs);

        // Then - all changes persist
        final finalPreferences = await repository.getPreferences();
        expect(finalPreferences.themeMode, equals(ThemeMode.light));
        expect(finalPreferences.locale, equals(const Locale('fr', 'FR')));
      },
    );
  });
}

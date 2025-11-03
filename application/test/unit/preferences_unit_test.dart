import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:trick_or_treat_finder/domain/entities/user_preferences.dart';
import 'package:trick_or_treat_finder/infrastructure/repositories/in_memory_preferences_repository.dart';
import 'package:trick_or_treat_finder/application/use_cases/preferences_use_case.dart';

void main() {
  group('Unit Tests: User Preferences Logic', () {
    late InMemoryPreferencesRepository repository;
    late PreferencesUseCase useCase;

    setUp(() {
      repository = InMemoryPreferencesRepository();
      useCase = PreferencesUseCase(repository);
    });

    tearDown(() {
      repository.dispose();
    });

    test(
      'Given default preferences, When getting preferences, Then returns system theme and EN locale',
      () async {
        // Given - default preferences
        // When - getting preferences
        final preferences = await useCase.getPreferences();

        // Then - returns system theme and EN locale
        expect(preferences.themeMode, equals(ThemeMode.system));
        expect(preferences.locale, equals(const Locale('en', 'US')));
      },
    );

    test(
      'Given system theme, When updating to dark theme, Then theme mode changes to dark',
      () async {
        // Given - system theme (default)
        final initialPreferences = await useCase.getPreferences();
        expect(initialPreferences.themeMode, equals(ThemeMode.system));

        // When - updating to dark theme
        await useCase.updateThemeMode(ThemeMode.dark);

        // Then - theme mode changes to dark
        final updatedPreferences = await useCase.getPreferences();
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
        final initialPreferences = await useCase.getPreferences();
        expect(initialPreferences.locale, equals(const Locale('en', 'US')));

        // When - updating to ES locale
        await useCase.updateLocale(const Locale('es', 'ES'));

        // Then - locale changes to Spanish
        final updatedPreferences = await useCase.getPreferences();
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
        final subscription = useCase.preferencesStream.listen(
          streamUpdates.add,
        );

        // When - changing preferences
        await useCase.updateThemeMode(ThemeMode.dark);

        // Then - stream emits updates
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
        await useCase.updateThemeMode(ThemeMode.dark);
        await useCase.updateLocale(const Locale('fr', 'FR'));
        await useCase.updateThemeMode(ThemeMode.light);

        // Then - all changes persist
        final finalPreferences = await useCase.getPreferences();
        expect(finalPreferences.themeMode, equals(ThemeMode.light));
        expect(finalPreferences.locale, equals(const Locale('fr', 'FR')));
      },
    );
  });
}

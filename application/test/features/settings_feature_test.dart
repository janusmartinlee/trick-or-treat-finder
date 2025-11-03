import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:trick_or_treat_finder/domain/entities/user_preferences.dart';
import 'package:trick_or_treat_finder/domain/repositories/preferences_repository.dart';
import 'package:trick_or_treat_finder/infrastructure/repositories/in_memory_preferences_repository.dart';
import 'package:trick_or_treat_finder/application/use_cases/preferences_use_case.dart';

void main() {
  group('Feature: User preferences management', () {
    late PreferencesRepository repository;
    late PreferencesUseCase useCase;

    setUp(() {
      repository = InMemoryPreferencesRepository();
      useCase = PreferencesUseCase(repository);
    });

    group('Scenario: User changes theme preference', () {
      test(
        'Given default preferences, When user changes to dark theme, Then preferences are updated',
        () async {
          // Given - default preferences
          final initialPreferences = await useCase.getPreferences();
          expect(initialPreferences.themeMode, equals(ThemeMode.system));

          // When - user changes to dark theme
          await useCase.updateThemeMode(ThemeMode.dark);

          // Then - preferences are updated
          final updatedPreferences = await useCase.getPreferences();
          expect(updatedPreferences.themeMode, equals(ThemeMode.dark));
        },
      );

      test(
        'Given dark theme selected, When user changes to light theme, Then preferences are updated',
        () async {
          // Given - dark theme selected
          await useCase.updateThemeMode(ThemeMode.dark);

          // When - user changes to light theme
          await useCase.updateThemeMode(ThemeMode.light);

          // Then - preferences are updated
          final updatedPreferences = await useCase.getPreferences();
          expect(updatedPreferences.themeMode, equals(ThemeMode.light));
        },
      );
    });

    group('Scenario: User changes language preference', () {
      test(
        'Given default locale, When user changes to Spanish, Then preferences are updated',
        () async {
          // Given - default locale
          final initialPreferences = await useCase.getPreferences();
          expect(initialPreferences.locale, equals(const Locale('en', 'US')));

          // When - user changes to Spanish
          await useCase.updateLocale(const Locale('es', 'ES'));

          // Then - preferences are updated
          final updatedPreferences = await useCase.getPreferences();
          expect(updatedPreferences.locale, equals(const Locale('es', 'ES')));
        },
      );

      test(
        'Given English locale, When user changes to Danish, Then preferences are updated',
        () async {
          // Given - English locale (default)
          final initialPreferences = await useCase.getPreferences();
          expect(initialPreferences.locale, equals(const Locale('en', 'US')));

          // When - user changes to Danish
          await useCase.updateLocale(const Locale('da', 'DK'));

          // Then - preferences are updated
          final updatedPreferences = await useCase.getPreferences();
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
          await useCase.updatePreferences(testPreferences);

          // When - retrieving preferences
          final retrievedPreferences = await useCase.getPreferences();

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

          final subscription = useCase.preferencesStream.listen((preferences) {
            streamEvents.add(preferences);
          });

          // When - preferences change
          await useCase.updateThemeMode(ThemeMode.dark);

          // Then - stream should have emitted at least one event
          expect(streamEvents.length, greaterThanOrEqualTo(1));
          expect(streamEvents.last.themeMode, equals(ThemeMode.dark));

          await subscription.cancel();
        },
      );
    });
  });
}

// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:trick_or_treat_finder/main.dart';
import 'package:trick_or_treat_finder/core/dependency_injection.dart';
import 'package:trick_or_treat_finder/features/preferences/domain/preferences_repository.dart';

void main() {
  setUp(() async {
    // Initialize dependencies for testing
    await initializeDependencies();
  });

  /// Helper to wrap app in ProviderScope for tests
  Widget createTestApp() {
    return const ProviderScope(child: TrickOrTreatApp());
  }

  testWidgets('App starts and displays welcome message', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(createTestApp());

    // Wait for the app to build completely
    await tester.pumpAndSettle();

    // Verify that our welcome message is displayed.
    expect(find.text('Welcome to Trick or Treat Finder!'), findsOneWidget);
    expect(find.text('Trick or Treat Finder'), findsOneWidget);
  });

  testWidgets('App supports Danish language', (WidgetTester tester) async {
    // Set language to Danish
    final repository = serviceLocator<PreferencesRepository>();
    final prefs = await repository.getPreferences();
    await repository.savePreferences(prefs.copyWith(locale: const Locale('da', 'DK')));

    // Build our app and trigger a frame.
    await tester.pumpWidget(createTestApp());

    // Wait for the app to build completely (since AppBloc is async)
    await tester.pumpAndSettle();

    // Verify that Danish welcome message is displayed.
    expect(find.text('Velkommen til Trick or Treat Finder!'), findsOneWidget);
    expect(
      find.text('Find det bedste Halloween slik i dit nabolag'),
      findsOneWidget,
    );
  });
}

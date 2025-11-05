import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trick_or_treat_finder/main.dart';
import 'package:trick_or_treat_finder/core/dependency_injection.dart';

/// Widget tests for HomePage
/// 
/// Tests cover:
/// - Initial rendering and welcome message display
/// - Navigation to settings page
/// - Find Treats button presence
/// - App bar title display
/// - Theme application
void main() {
  setUpAll(() async {
    // Initialize dependencies once for all tests
    await initializeDependencies();
  });

  /// Helper to wrap app in ProviderScope for tests
  Widget createTestApp() {
    return const ProviderScope(child: TrickOrTreatApp());
  }

  group('HomePage Widget Tests', () {
    testWidgets('displays welcome message and app title', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Trick or Treat Finder'), findsOneWidget);
      expect(find.text('Welcome to Trick or Treat Finder!'), findsOneWidget);
      expect(
        find.text('Find the best Halloween treats in your neighborhood'),
        findsOneWidget,
      );
    });

    testWidgets('displays location icon', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      // Assert
      expect(find.byIcon(Icons.location_on), findsOneWidget);
    });

    testWidgets('displays settings button in app bar', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      // Assert
      expect(find.byIcon(Icons.settings), findsOneWidget);
    });

    testWidgets('displays Find Treats floating action button', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('navigates to settings page when settings button tapped',
        (tester) async {
      // Arrange
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      // Act
      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle();

      // Assert - Settings page should be visible
      expect(find.text('Settings'), findsWidgets);
      expect(find.text('Theme'), findsOneWidget);
      expect(find.text('Language'), findsOneWidget);
    });

    testWidgets('can navigate back from settings to home', (tester) async {
      // Arrange
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      // Navigate to settings
      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle();

      // Act - Navigate back
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      // Assert - Should be back on home page
      expect(find.text('Welcome to Trick or Treat Finder!'), findsOneWidget);
    });

    testWidgets('Find Treats button is tappable but does nothing yet',
        (tester) async {
      // Arrange
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      // Act
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      // Assert - Should remain on home page (no navigation implemented yet)
      expect(find.text('Welcome to Trick or Treat Finder!'), findsOneWidget);
    });

    testWidgets('respects system theme mode during initialization',
        (tester) async {
      // Arrange & Act
      await tester.pumpWidget(createTestApp());

      // Assert - Loading indicator should be visible initially
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Wait for preferences to load
      await tester.pumpAndSettle();

      // Assert - App should be rendered
      expect(find.text('Welcome to Trick or Treat Finder!'), findsOneWidget);
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trick_or_treat_finder/core/dependency_injection.dart';
import 'package:trick_or_treat_finder/features/auth/presentation/login_page.dart';

void main() {
  setUpAll(() async {
    await initializeDependencies();
  });

  tearDownAll(() {
    disposeDependencies();
  });

  group('LoginPage Widget Tests', () {
    testWidgets('displays login page with required elements', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      // Should show app title
      expect(find.text('Trick or Treat Finder'), findsOneWidget);

      // Should have email and password fields
      expect(find.byKey(const Key('email_field')), findsOneWidget);
      expect(find.byKey(const Key('password_field')), findsOneWidget);

      // Should have sign-in buttons
      expect(find.text('Sign In'), findsOneWidget);
      expect(find.byKey(const Key('google_button')), findsOneWidget);
    });

    testWidgets('successful sign-in with valid credentials', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      // Enter valid credentials
      await tester.enterText(
        find.byKey(const Key('email_field')),
        'test@example.com',
      );
      await tester.enterText(
        find.byKey(const Key('password_field')),
        'password',
      );

      // Tap sign-in button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Should not show error (successful sign-in)
      expect(find.textContaining('Invalid'), findsNothing);
    });

    testWidgets('handles invalid credentials', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      // Enter invalid credentials
      await tester.enterText(
        find.byKey(const Key('email_field')),
        'wrong@example.com',
      );
      await tester.enterText(
        find.byKey(const Key('password_field')),
        'wrong',
      );

      // Tap sign-in button - should handle error without crashing
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // App should still be on login page (not crashed)
      expect(find.byType(LoginPage), findsOneWidget);
    });

    testWidgets('Google sign-in button works', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      // Tap Google button
      await tester.tap(find.byKey(const Key('google_button')));
      await tester.pumpAndSettle();

      // Should not show error (successful Google sign-in with mock)
      expect(find.textContaining('Invalid'), findsNothing);
    });
  });
}

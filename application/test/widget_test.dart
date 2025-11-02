// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:trick_or_treat_finder/main.dart';
import 'package:trick_or_treat_finder/core/dependency_injection.dart';

void main() {
  testWidgets('App starts and displays welcome message', (WidgetTester tester) async {
    // Initialize dependencies for testing
    await initializeDependencies();
    
    // Build our app and trigger a frame.
    await tester.pumpWidget(const TrickOrTreatApp());

    // Wait for the app to build completely (since AppBloc is async)
    await tester.pumpAndSettle();

    // Verify that our welcome message is displayed.
    expect(find.text('Welcome to Trick or Treat Finder!'), findsOneWidget);
    expect(find.text('Trick or Treat Finder'), findsOneWidget);
  });
}

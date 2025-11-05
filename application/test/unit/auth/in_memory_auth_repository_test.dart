import 'package:flutter_test/flutter_test.dart';
import 'package:trick_or_treat_finder/features/auth/domain/auth_exceptions.dart';
import 'package:trick_or_treat_finder/features/auth/domain/user.dart';
import 'package:trick_or_treat_finder/features/auth/infrastructure/in_memory_auth_repository.dart';

void main() {
  group('InMemoryAuthRepository', () {
    late InMemoryAuthRepository repository;

    setUp(() {
      repository = InMemoryAuthRepository();
    });

    tearDown(() {
      repository.dispose();
    });

    group('getCurrentUser', () {
      test('returns null when no user is signed in', () async {
        final user = await repository.getCurrentUser();
        expect(user, isNull);
      });

      test('returns current user when signed in', () async {
        await repository.signInWithEmailAndPassword(
          email: 'test@example.com',
          password: 'password',
        );

        final user = await repository.getCurrentUser();
        expect(user, isNotNull);
        expect(user?.email, 'test@example.com');
      });
    });

    group('signInWithEmailAndPassword', () {
      test('signs in successfully with valid credentials', () async {
        final user = await repository.signInWithEmailAndPassword(
          email: 'test@example.com',
          password: 'password',
        );

        expect(user.id, 'test-user-1');
        expect(user.email, 'test@example.com');
        expect(user.displayName, 'Test User');
      });

      test('throws AuthException with invalid email', () async {
        expect(
          () => repository.signInWithEmailAndPassword(
            email: 'wrong@example.com',
            password: 'password',
          ),
          throwsA(isA<AuthException>()),
        );
      });

      test('throws AuthException with invalid password', () async {
        expect(
          () => repository.signInWithEmailAndPassword(
            email: 'test@example.com',
            password: 'wrong-password',
          ),
          throwsA(isA<AuthException>()),
        );
      });

      test('updates current user after successful sign-in', () async {
        await repository.signInWithEmailAndPassword(
          email: 'test@example.com',
          password: 'password',
        );

        final currentUser = await repository.getCurrentUser();
        expect(currentUser?.email, 'test@example.com');
      });
    });

    group('signInWithGoogle', () {
      test('signs in successfully', () async {
        final user = await repository.signInWithGoogle();

        expect(user.id, 'google-user-1');
        expect(user.email, 'google.user@gmail.com');
        expect(user.displayName, 'Google User');
        expect(user.photoUrl, 'https://example.com/photo.jpg');
      });

      test('updates current user after successful sign-in', () async {
        await repository.signInWithGoogle();

        final currentUser = await repository.getCurrentUser();
        expect(currentUser?.email, 'google.user@gmail.com');
      });
    });

    group('signOut', () {
      test('clears current user', () async {
        await repository.signInWithEmailAndPassword(
          email: 'test@example.com',
          password: 'password',
        );

        await repository.signOut();

        final user = await repository.getCurrentUser();
        expect(user, isNull);
      });

      test('does nothing when no user is signed in', () async {
        await repository.signOut();

        final user = await repository.getCurrentUser();
        expect(user, isNull);
      });
    });

    group('authStateChanges', () {
      test('emits null initially', () {
        expect(
          repository.authStateChanges,
          emits(isNull),
        );
      });

      test('emits user when signed in', () async {
        expect(
          repository.authStateChanges,
          emitsInOrder([
            isNull, // Initial state
            isA<User>(), // After sign-in
          ]),
        );

        await repository.signInWithEmailAndPassword(
          email: 'test@example.com',
          password: 'password',
        );
      });

      test('emits null when signed out', () async {
        await repository.signInWithEmailAndPassword(
          email: 'test@example.com',
          password: 'password',
        );

        expect(
          repository.authStateChanges,
          emitsInOrder([
            isA<User>(), // Current state
            isNull, // After sign-out
          ]),
        );

        await repository.signOut();
      });
    });

    group('setCurrentUser (test helper)', () {
      test('sets current user without sign-in flow', () async {
        const testUser = User(
          id: 'test-id',
          email: 'test@example.com',
          displayName: 'Test',
        );

        repository.setCurrentUser(testUser);

        final user = await repository.getCurrentUser();
        expect(user, testUser);
      });

      test('emits user in auth state stream', () {
        const testUser = User(
          id: 'test-id',
          email: 'test@example.com',
        );

        expect(
          repository.authStateChanges,
          emitsInOrder([
            isNull, // Initial
            testUser, // After setCurrentUser
          ]),
        );

        repository.setCurrentUser(testUser);
      });
    });
  });
}

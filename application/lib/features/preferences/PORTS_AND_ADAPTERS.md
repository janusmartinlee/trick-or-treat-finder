# Ports & Adapters Architecture

## Overview

This feature demonstrates the **Ports & Adapters** pattern (also known as **Hexagonal Architecture**), which is a key part of our Clean Architecture implementation.

## Pattern Explanation

### What Are Ports?

**Ports** are interfaces defined in the domain layer that declare what the application needs:

```dart
// Port (interface in domain layer)
abstract class PreferencesRepository {
  Future<UserPreferences> getPreferences();
  Future<void> savePreferences(UserPreferences preferences);
  Stream<UserPreferences> get preferencesStream;
}
```

### What Are Adapters?

**Adapters** are implementations in the infrastructure layer that provide the "how":

```dart
// Adapter (implementation in infrastructure layer)
class SharedPreferencesAdapter implements PreferencesRepository {
  // Implementation details...
}
```

## Architecture Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                         Presentation Layer                       │
│                      (Riverpod ConsumerWidgets)                  │
└────────────────────────────┬────────────────────────────────────┘
                             │ uses
┌────────────────────────────▼────────────────────────────────────┐
│                        Application Layer                         │
│                     (Riverpod Providers/Notifiers)               │
│                     Uses Port interfaces only                    │
└────────────────────────────┬────────────────────────────────────┘
                             │ depends on
┌────────────────────────────▼────────────────────────────────────┐
│                          Domain Layer                            │
│                    (Entities + Port Interfaces)                  │
│                    ┌──────────────────────┐                      │
│                    │ PreferencesRepository│  ← PORT (interface)  │
│                    └──────────────────────┘                      │
└─────────────────────────────────────────────────────────────────┘
                             ▲
                             │ implements
┌────────────────────────────┴────────────────────────────────────┐
│                      Infrastructure Layer                        │
│                          (Adapters)                              │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │ InMemoryPreferencesRepository        ← ADAPTER          │    │
│  │ SharedPreferencesAdapter             ← ADAPTER          │    │
│  │ FirebasePreferencesAdapter           ← ADAPTER (future) │    │
│  └─────────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────────┘
```

## Benefits

### 1. **Testability**
- Domain logic can be tested without real storage
- Easy to create mock implementations
- Tests run fast (no I/O operations)

### 2. **Flexibility**
- Swap implementations without changing domain code
- Support multiple storage backends
- Easy to add cloud sync later

### 3. **Independence**
- Domain doesn't know about infrastructure details
- No Flutter/platform dependencies in domain
- Pure business logic

### 4. **Maintainability**
- Changes to storage don't affect domain
- Clear separation of concerns
- Each adapter is isolated

## Current Implementation

### Port (Domain Layer)

**File**: `domain/preferences_repository.dart`

```dart
abstract class PreferencesRepository {
  Future<UserPreferences> getPreferences();
  Future<void> savePreferences(UserPreferences preferences);
  Stream<UserPreferences> get preferencesStream;
}
```

### Adapters (Infrastructure Layer)

#### 1. InMemoryPreferencesRepository (Development/Testing)

**File**: `infrastructure/in_memory_preferences_repository.dart`

- Stores data in memory
- Lost on app restart
- Fast and simple
- Perfect for tests

#### 2. SharedPreferencesAdapter (Production)

**File**: `infrastructure/shared_preferences_adapter.dart`

- Persists data to device storage
- Survives app restarts
- Platform-specific implementation
- Ready for production

## How to Swap Adapters

In `lib/core/dependency_injection.dart`:

```dart
// Development (in-memory)
serviceLocator.registerLazySingleton<PreferencesRepository>(
  () => InMemoryPreferencesRepository(),
);

// Production (persistent)
serviceLocator.registerLazySingleton<PreferencesRepository>(
  () async => await SharedPreferencesAdapter.create(),
);
```

**That's it!** No other code needs to change. The application and domain layers only know about the `PreferencesRepository` port, not the specific adapter.

## Usage in Application Layer

Riverpod providers use the port through dependency injection:

```dart
@riverpod
PreferencesRepository preferencesRepository(PreferencesRepositoryRef ref) {
  // Gets whatever adapter is registered, doesn't care which one
  return serviceLocator<PreferencesRepository>();
}

@riverpod
class PreferencesNotifier extends _$PreferencesNotifier {
  @override
  Future<UserPreferences> build() async {
    // Uses the port interface, not a specific adapter
    final repository = ref.watch(preferencesRepositoryProvider);
    return repository.getPreferences();
  }
}
```

## Adding New Adapters

To add a new storage backend:

1. Create a new class in `infrastructure/`
2. Implement the `PreferencesRepository` interface
3. Update `dependency_injection.dart` to use your adapter
4. No changes needed to domain or application layers!

Example future adapters:

```dart
// Cloud sync with Firebase
class FirebasePreferencesAdapter implements PreferencesRepository { }

// SQLite for structured storage
class SqlitePreferencesAdapter implements PreferencesRepository { }

// Custom backend API
class ApiPreferencesAdapter implements PreferencesRepository { }
```

## Relationship to Clean Architecture

Ports & Adapters is the mechanism by which we achieve Clean Architecture's dependency rule:

> **Dependency Rule**: Source code dependencies must point inward toward higher-level policies.

```
Infrastructure (outer) → Domain (inner)
     Adapter          →    Port
```

The domain defines what it needs (port), and infrastructure provides it (adapter). Never the reverse!

## Testing Strategy

### Unit Tests (Domain Logic)

Use mock implementations:

```dart
class MockPreferencesRepository extends Mock implements PreferencesRepository {}

test('preferences logic works', () {
  final mockRepo = MockPreferencesRepository();
  when(() => mockRepo.getPreferences()).thenAnswer((_) => /* ... */);
  // Test domain logic
});
```

### Integration Tests (Adapters)

Test each adapter independently:

```dart
test('SharedPreferencesAdapter persists data', () async {
  final adapter = await SharedPreferencesAdapter.create();
  final prefs = UserPreferences(/* ... */);
  
  await adapter.savePreferences(prefs);
  final loaded = await adapter.getPreferences();
  
  expect(loaded, equals(prefs));
});
```

### Widget Tests (Full Stack)

Use real or mock adapters:

```dart
testWidgets('settings page updates theme', (tester) async {
  // Can use InMemoryPreferencesRepository for fast tests
  await initializeDependencies();
  
  await tester.pumpWidget(ProviderScope(child: TrickOrTreatApp()));
  // Test the full flow
});
```

## Next Steps

1. ✅ Document the pattern (this file)
2. ✅ Create SharedPreferencesAdapter
3. ⏳ Create adapter tests
4. ⏳ Switch to SharedPreferencesAdapter in production
5. ⏳ Apply pattern to auth feature

## References

- [Hexagonal Architecture](https://alistair.cockburn.us/hexagonal-architecture/)
- [Clean Architecture by Robert C. Martin](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Ports and Adapters Pattern](https://softwareontheroad.com/ideal-nodejs-project-structure/)

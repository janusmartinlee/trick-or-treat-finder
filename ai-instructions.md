# AI Assistant Instructions

## Code Implementation Explanations

When generating code, the assistant should provide:

### 1. Design Context

- How the implementation fits into the DDD/Clean Architecture approach
- Which bounded context it belongs to
- What domain concepts it represents

### 2. Implementation Rationale

- Why specific patterns/approaches were chosen
- How it aligns with Flutter/Dart idioms
- How it supports the BDD scenarios
- Relationship to existing components

### 3. Alternatives Considered

- Other potential implementation approaches
- Trade-offs between different solutions

### 4. Testing Approach

- What behavior should be tested
- How to structure the tests
- Key test scenarios to cover

### 5. Code Structure

- Feature/domain concept organization
- Key dependencies and their direction
- Interface boundaries
- Component responsibilities and interactions

## Design Principles

### Primary Focus

- Strong separation of concerns between layers and components
- High cohesion within modules (things that change together stay together)
- Clear boundaries between bounded contexts
- Domain logic isolation from infrastructure concerns

### Secondary Considerations

- Pragmatic approach to implementation details
- Focus on behavior correctness over code aesthetics
- Performance considerations where relevant
- Flutter/Dart idioms where they don't conflict with primary concerns

### Code Organization Philosophy

- Group by feature/domain concept rather than technical layer
- Keep related code close together
- Minimize dependencies between modules
- Infrastructure code should depend on domain, never vice versa

### High Cohesion Examples in Flutter/Dart

#### Good Cohesion ✅

```dart
// Feature-based organization
treating_location/
  ├── domain/
  │   ├── treating_location.dart       // Core domain entity
  │   ├── treating_period.dart         // Value object
  │   └── location_repository.dart     // Repository interface
  ├── infrastructure/
  │   └── firebase_location_repo.dart  // Implementation
  ├── application/
  │   └── location_service.dart        // Use cases
  └── presentation/
      ├── location_page.dart           // UI
      ├── location_state.dart          // Local state
      └── widgets/                     // Location-specific widgets
```

#### Poor Cohesion ❌

```dart
lib/
  ├── models/                    // Mixed domain concepts
  │   ├── location.dart
  │   ├── user.dart
  │   └── session.dart
  ├── repositories/             // Mixed infrastructure
  │   ├── location_repo.dart
  │   └── user_repo.dart
  └── screens/                  // Mixed UI
      ├── location_screen.dart
      └── user_screen.dart
```

#### Cohesion Guidelines

1. **State Management**

   - State lives with its feature, not globally
   - UI and state updates stay within feature boundaries
   - Cross-feature communication via domain events

2. **Widget Organization**

   - Widgets that change together live together
   - Shared widgets only if truly reusable across features
   - Feature-specific widgets stay in feature folder

3. **Domain Logic**

   - Business rules stay with their entity
   - Validation close to data structures
   - Use cases orchestrate domain objects

4. **Infrastructure Code**

   - Implementation details isolated per feature
   - Shared infrastructure behind interfaces
   - Feature-specific adapters with feature code

### Testing Priorities

- Focus on behavior and integration tests
- Unit tests for complex domain logic
- Less emphasis on test aesthetics, more on coverage of critical paths
- Tests should validate boundaries between contexts
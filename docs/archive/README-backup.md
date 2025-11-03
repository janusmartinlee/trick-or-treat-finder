# Trick or Treat Finder

## Project Context
This application helps connect Halloween trick-or-treaters with homes offering treats. Built using Flutter for the mobile frontend and .NET backend (using .NET Aspire), this project follows Domain-Driven Design principles and test-driven development practices.

## Development Approach
- **Trunk Based Development**: Main branch is always deployable
- **Continuous Integration**: Automated builds and tests on every commit
- **BDD First**: Behavior-driven development driving both implementation and test coverage
- **Idiomatic Code**: Following Flutter/Dart style guidelines and best practices
- **.NET Aspire**: Cloud-native application platform for backend services

## Core Domain Concepts
- **TreatingLocation**: A registered home offering treats
- **TrickOrTreater**: A user looking for treating locations
- **TreatingStatus**: Current status of a location (Open/Closed/OutOfCandy)
- **TreatingSession**: A time-bounded period when treating is active

## Features

### MVP (Phase 1)
1. **Location Registration**
   - Register home as treating location
   - Set treating status (Open/Closed/OutOfCandy)
   - Basic location details (address, description)

2. **Treat Finding**
   - View map of active treating locations
   - Filter by status
   - Basic navigation support

3. **Real-time Updates**
   - Status changes reflect immediately
   - Basic notification system

### Future Enhancements (Phase 2+)
1. **Safety Features**
   - Verified locations
   - Community ratings
   - Safe route planning

2. **Enhanced Experience**
   - Candy type listings
   - Crowd levels
   - Wait time estimates

3. **Community Features**
   - Event scheduling
   - Community guidelines
   - Local halloween events

## Technical Architecture

### Frontend (Flutter)
- **Clean Architecture** with layers:
  - Presentation (Widgets/Pages)
  - Application (Use Cases)
  - Domain (Entities/Business Logic)
  - Infrastructure (APIs/Storage)

- **State Management**
  - Riverpod for dependency injection and state
  - Repository pattern for data access
  - Event-driven updates using Streams

### Testing Strategy
1. **Unit Tests**
   - Domain logic
   - Use cases
   - Repository implementations

2. **Widget Tests**
   - Component rendering
   - User interactions
   - State management

3. **Integration Tests**
   - Full user flows
   - API integration
   - Performance metrics

### Design Patterns
- **Repository Pattern**: Data access abstraction
- **Factory Pattern**: Object creation
- **Observer Pattern**: Real-time updates
- **Command Pattern**: User actions
- **Strategy Pattern**: Map providers and navigation

## Development Workflow

1. TDD Workflow:
   - Write failing test
   - Implement feature
   - Refactor
2. BDD Scenarios driving development
3. Continuous trunk-based development

## Getting Started
(Development setup instructions will go here)

## Project Structure
```
lib/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── use_cases/
├── application/
│   ├── services/
│   └── state/
├── presentation/
│   ├── pages/
│   ├── widgets/
│   └── themes/
└── infrastructure/
    ├── repositories/
    ├── services/
    └── api/
```

## Conventions
- Feature-first organization
- Consistent naming patterns
- Clear separation of concerns
- Comprehensive documentation
- Test coverage requirements

## Quality Standards

- Idiomatic Dart/Flutter code style
- Performance benchmarks
- Accessibility requirements
- Security scanning
- Comprehensive BDD test coverage
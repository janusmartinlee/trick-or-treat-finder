# Trick or Treat Finder

A Flutter app that helps connect Halloween trick-or-treaters with homes offering treats. Built with Clean Architecture, Danish internationalization, and a community-funded API model.

## Features

- **Location Registration**: Homes can register as treat-giving locations
- **Real-time Status**: Open/Closed/OutOfCandy status updates
- **Route Planning**: Help trick-or-treaters plan efficient routes
- **Safety Features**: Parental controls and safety measures
- **Queue Management**: Handle popular locations efficiently
- **Group Coordination**: Coordinate with friends and family
- **Multilingual Support**: Danish and English localization

## Architecture

This project follows Clean Architecture principles with:

- **Core Layer**: Cross-cutting concerns (telemetry, error handling, logging, theming)
- **Domain Layer**: Business logic, entities, and value objects
- **Application Layer**: Use cases and application services
- **Infrastructure Layer**: External services and data sources
- **Presentation Layer**: UI components and state management

## Getting Started

### Prerequisites

- Flutter SDK (3.9.2 or higher)
- Dart SDK
- VS Code with Flutter/Dart extensions

### Installation

1. Clone the repository

2. Install dependencies:

   ```bash
   flutter pub get
   ```

3. Run the app:

   ```bash
   flutter run
   ```

### Development

- Use VS Code tasks for building and running
- Follow Clean Architecture guidelines
- Implement proper error handling and logging
- Write tests for core features

## Dependencies

- **flutter_bloc**: State management
- **get_it**: Dependency injection
- **logger**: Logging functionality
- **opentelemetry**: Distributed tracing (simplified implementation)
- **flutter_localizations**: Official Flutter internationalization
- **intl**: Internationalization utilities

## Testing Philosophy

This project uses **interfaces and test doubles** instead of mocking frameworks:

- Define clear interfaces for all external dependencies
- Create test double implementations for testing
- Use dependency injection to swap implementations
- Write BDD-style tests using regular Flutter test framework

## Testing

Run tests with:

```bash
flutter test
```

## Contributing

Follow the established architecture patterns and ensure all tests pass before submitting changes.

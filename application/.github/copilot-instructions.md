# Trick or Treat Finder - Flutter App

This Flutter app helps connect Halloween trick-or-treaters with homes offering treats.

## Architecture
- Clean Architecture implementation
- Domain-Driven Design (DDD) principles
- Cross-cutting concerns: telemetry, error handling, logging, testing, localization

## Key Technologies
- Flutter & Dart
- OpenTelemetry for tracing (simplified implementation)
- BDD methodology with regular Flutter tests
- Material Design theming
- Official Flutter localization (flutter_localizations, intl)

## Project Structure
- `lib/core/` - Cross-cutting concerns (telemetry, error handling, logging, localization)
- `lib/domain/` - Business logic, entities, value objects
- `lib/application/` - Use cases and application services
- `lib/infrastructure/` - External services and data sources
- `lib/presentation/` - UI components and state management
- `lib/l10n/` - Localization ARB files
- `test/` - BDD-style tests using regular Flutter test framework
- `platforms/` - Platform-specific code (android, ios, windows, etc.)
- `l10n.yaml` - Localization configuration

## Development Guidelines
- Follow Clean Architecture principles
- Implement proper error handling and logging
- Use OpenTelemetry for distributed tracing
- Write BDD-style tests using regular Flutter test framework
- Use interfaces and test doubles instead of mocking frameworks
- Prefer official and well-maintained packages only
- Follow Material Design guidelines
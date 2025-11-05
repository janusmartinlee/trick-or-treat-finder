# Trick or Treat Finder

A Flutter app that helps connect Halloween trick-or-treaters with homes offering treats. Built with Clean Architecture, Danish internationalization, and a community-funded API model.

## Overview

Trick or Treat Finder bridges the gap between Halloween trick-or-treaters and treat-giving homes, creating a safer and more efficient Halloween experience for everyone in the community.

**For Trick-or-Treaters:**

- Find active treat locations on an interactive map
- Plan optimal routes and get real-time status updates
- Coordinate with friends and family groups
- Access safety features and parental controls

**For Treat Givers:**

- Register your location and manage availability status
- Handle crowds with queue management tools
- Connect with your local Halloween community
- Provide a better experience for visiting families

## Key Features

- **Interactive Map**: Real-time location status and filtering
- **Smart Routing**: Optimized paths with safety considerations  
- **Group Coordination**: Plan and coordinate with friends and family
- **Safety First**: Comprehensive parental controls and emergency features
- **Community Funded**: Transparent, community-supported sustainability model
- **Multilingual**: Full Danish and English localization

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

### Quick Start

```bash
flutter pub get
flutter run
```

### Development

- Use VS Code tasks for building and testing
- Follow Clean Architecture patterns
- Write tests for all business logic
- Check GitHub Issues for development roadmap

## Project Details

**Dependencies**: flutter_bloc, get_it, logger, opentelemetry, flutter_localizations, intl

**Testing**: BDD-style feature tests with interfaces and test doubles (no mocking frameworks)

**Contributing**: Follow established architecture patterns and ensure all tests pass

---

For detailed feature specifications and development roadmap, see [GitHub Issues](https://github.com/janusmartinlee/trick-or-treat-finder/issues).

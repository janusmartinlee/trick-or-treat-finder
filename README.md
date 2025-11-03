# Trick or Treat Finder

## Project Overview
A Flutter app that helps connect Halloween trick-or-treaters with homes offering treats. Built with Clean Architecture, Danish internationalization, and a community-funded API model.

## Development Approach
- **Trunk Based Development**: Main branch is always deployable
- **Continuous Integration**: Automated builds and tests on every commit
- **BDD First**: Behavior-driven development driving implementation and test coverage
- **Clean Architecture**: Domain-driven design with clear separation of concerns

## Technical Stack
- **Frontend**: Flutter with Clean Architecture
- **State Management**: Riverpod for dependency injection and state
- **Testing**: BDD-style tests with comprehensive coverage
- **Backend**: .NET Aspire (planned)
- **CI/CD**: GitHub Actions with semantic release

## Architecture Principles
- Domain-driven design with bounded contexts
- Repository pattern for data access
- Event-driven updates using Streams
- Comprehensive test coverage
- Idiomatic Dart/Flutter code

## Project Structure
`
 .github/           # GitHub workflows and development standards
 docs/              # Technical documentation and architecture
 scripts/           # Development automation and release testing
 application/       # Flutter app implementation
 README.md          # This overview document
`

## Development Workflow
1. **BDD-First**: Write failing tests describing behavior
2. **TDD Cycle**: Red  Green  Refactor
3. **Trunk-Based**: Continuous integration on main branch
4. **Quality Gates**: Automated testing and code quality checks

## Getting Started
See pplication/README.md for development setup instructions.

## Feature Roadmap
For detailed feature specifications and development roadmap, see [GitHub Issues](https://github.com/janusmartinlee/trick-or-treat-finder/issues).

## Documentation
- pplication/ - Flutter app implementation and setup
- docs/ - Technical documentation and architecture guides
- .github/ - Development standards and CI/CD configuration
- scripts/ - Development automation and release testing tools

## Release Testing
To test the latest release build:
`powershell
PowerShell -ExecutionPolicy Bypass -File "scripts\quick-serve-final.ps1"
`

---

**Note**: Detailed feature requirements have been migrated to GitHub Issues for better project management and collaboration.

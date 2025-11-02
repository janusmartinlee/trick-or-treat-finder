# Testing Guide

## Running Tests

### Quick Commands

```powershell
# Run all tests in parallel (fastest)
flutter test --concurrency=4

# Run only unit tests (super fast)
flutter test test/unit/ --concurrency=8

# Run only feature tests
flutter test test/features/ --concurrency=4

# Run widget tests (minimal concurrency needed)
flutter test test/widget_test.dart
```

### Performance Optimization

Our test suite is optimized for speed:

- **Unit Tests**: Lightning fast business logic tests
- **Feature Tests**: BDD-style scenario tests using `test()` instead of `testWidgets()`
- **Widget Tests**: Minimal UI tests only where necessary

### Expected Performance

- **All Tests (11 total)**: ~2-3 seconds with parallel execution
- **Unit Tests (5 tests)**: ~1 second
- **Feature Tests (5 tests)**: ~1 second  
- **Widget Tests (1 test)**: ~1 second

### VS Code Tasks

Use Ctrl+Shift+P → "Tasks: Run Task" and select:

- **Test All Fast**: Run all tests with optimal concurrency
- **Test Unit Only**: Run just the unit tests
- **Test Features Only**: Run just the BDD feature tests

### Configuration

Test settings are configured in `dart_test.yaml`:
- Default concurrency: 4 workers
- Timeout: 30 seconds
- Optimized for parallel execution

### Best Practices

1. **Use `test()` for business logic** - Much faster than `testWidgets()`
2. **Use `testWidgets()` only for UI** - When you need widget interaction testing
3. **Avoid artificial delays** - Let async operations complete naturally
4. **Run tests frequently** - They're fast enough for TDD workflow
5. **Use specific test paths** - Run only what you're working on during development

## Test Types

### Unit Tests (`test/unit/`)
- Pure business logic testing
- No UI dependencies
- Fastest execution
- Perfect for TDD

### Feature Tests (`test/features/`)
- BDD-style scenario testing
- End-to-end use case validation
- Business-readable test names
- Integration testing without UI

### Widget Tests (`test/widget_test.dart`)
- UI component testing
- User interaction simulation
- Visual regression testing
- Keep minimal for performance
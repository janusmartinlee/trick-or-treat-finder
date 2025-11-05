import 'package:get_it/get_it.dart';
import 'telemetry/telemetry_service.dart';
import '../features/preferences/domain/preferences_repository.dart';
import '../features/preferences/infrastructure/in_memory_preferences_repository.dart';

/// Service locator for dependency injection
/// 
/// Used by Riverpod providers to access infrastructure implementations.
/// Riverpod handles the application and presentation layers, while
/// get_it manages infrastructure dependencies.
final GetIt serviceLocator = GetIt.instance;

/// Initialize all dependencies
Future<void> initializeDependencies() async {
  // Check if already initialized
  if (serviceLocator.isRegistered<TelemetryService>()) {
    return;
  }

  // Core services
  serviceLocator.registerLazySingleton<TelemetryService>(
    () => TelemetryService.instance,
  );

  // Preferences feature - Infrastructure layer only
  // Application logic is now handled by Riverpod providers
  serviceLocator.registerLazySingleton<PreferencesRepository>(
    () => InMemoryPreferencesRepository(),
  );
}

/// Clean up dependencies
void disposeDependencies() {
  serviceLocator.get<TelemetryService>().dispose();
  serviceLocator.reset();
}

import 'package:get_it/get_it.dart';
import 'telemetry/telemetry_service.dart';
import '../domain/repositories/preferences_repository.dart';
import '../infrastructure/repositories/in_memory_preferences_repository.dart';
import '../application/use_cases/preferences_use_case.dart';

/// Service locator for dependency injection
final GetIt serviceLocator = GetIt.instance;

/// Initialize all dependencies
Future<void> initializeDependencies() async {
  // Core services
  serviceLocator.registerLazySingleton<TelemetryService>(
    () => TelemetryService.instance,
  );

  // Repositories
  serviceLocator.registerLazySingleton<PreferencesRepository>(
    () => InMemoryPreferencesRepository(),
  );

  // Use cases
  serviceLocator.registerLazySingleton<PreferencesUseCase>(
    () => PreferencesUseCase(serviceLocator<PreferencesRepository>()),
  );
}

/// Clean up dependencies
void disposeDependencies() {
  serviceLocator.get<TelemetryService>().dispose();
  serviceLocator.reset();
}
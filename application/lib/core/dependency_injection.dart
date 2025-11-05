import 'package:get_it/get_it.dart';
import 'telemetry/telemetry_service.dart';
import '../features/preferences/domain/preferences_repository.dart';
import '../features/preferences/infrastructure/in_memory_preferences_repository.dart';
import '../features/auth/domain/auth_repository.dart';
import '../features/auth/infrastructure/in_memory_auth_repository.dart';

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

  // Preferences feature - Infrastructure layer only (Ports & Adapters pattern)
  // 
  // Port: PreferencesRepository interface (defined in domain)
  // Adapter: Choose implementation (infrastructure):
  //   - InMemoryPreferencesRepository (development/testing)
  //   - SharedPreferencesAdapter (persistent storage)
  // 
  // Application logic is handled by Riverpod providers that use the port,
  // never knowing which adapter is being used.
  serviceLocator.registerLazySingleton<PreferencesRepository>(
    () => InMemoryPreferencesRepository(),
    // To swap to persistent storage, simply change the adapter:
    // () async => await SharedPreferencesAdapter.create(),
  );

  // Auth feature - Infrastructure layer only (Ports & Adapters pattern)
  // 
  // Port: AuthRepository interface (defined in domain)
  // Adapter: Choose implementation (infrastructure):
  //   - InMemoryAuthRepository (development/testing with fake users)
  //   - FirebaseAuthAdapter (production OAuth - when implemented)
  // 
  // Application logic uses the port through Riverpod providers.
  serviceLocator.registerLazySingleton<AuthRepository>(
    () => InMemoryAuthRepository(),
    // To swap to Firebase auth:
    // () => FirebaseAuthAdapter(),
  );
}

/// Clean up dependencies
void disposeDependencies() {
  serviceLocator.get<TelemetryService>().dispose();
  serviceLocator.reset();
}

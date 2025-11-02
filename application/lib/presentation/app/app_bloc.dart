import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user_preferences.dart';
import '../../application/use_cases/preferences_use_case.dart';

/// App-level events
abstract class AppEvent {}

class AppStarted extends AppEvent {}

class PreferencesChanged extends AppEvent {
  final UserPreferences preferences;
  PreferencesChanged(this.preferences);
}

/// App-level state
abstract class AppState {}

class AppInitial extends AppState {}

class AppReady extends AppState {
  final UserPreferences preferences;
  AppReady(this.preferences);
}

/// App BLoC to manage global app state including theme and locale
class AppBloc extends Bloc<AppEvent, AppState> {
  final PreferencesUseCase _preferencesUseCase;

  AppBloc(this._preferencesUseCase) : super(AppInitial()) {
    on<AppStarted>(_onAppStarted);
    on<PreferencesChanged>(_onPreferencesChanged);
    
    // Listen to preferences changes
    _preferencesUseCase.preferencesStream.listen((preferences) {
      add(PreferencesChanged(preferences));
    });
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AppState> emit) async {
    try {
      final preferences = await _preferencesUseCase.getPreferences();
      emit(AppReady(preferences));
    } catch (e) {
      // For now, emit default preferences on error
      emit(AppReady(UserPreferences.defaultPreferences));
    }
  }

  Future<void> _onPreferencesChanged(PreferencesChanged event, Emitter<AppState> emit) async {
    emit(AppReady(event.preferences));
  }
}
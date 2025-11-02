import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user_preferences.dart';
import '../../application/use_cases/preferences_use_case.dart';

/// Settings events
abstract class SettingsEvent {}

class LoadSettings extends SettingsEvent {}

class UpdateThemeMode extends SettingsEvent {
  final ThemeMode themeMode;
  UpdateThemeMode(this.themeMode);
}

class UpdateLocale extends SettingsEvent {
  final Locale locale;
  UpdateLocale(this.locale);
}

/// Settings state
abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final UserPreferences preferences;
  SettingsLoaded(this.preferences);
}

class SettingsError extends SettingsState {
  final String message;
  SettingsError(this.message);
}

/// Settings BLoC
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final PreferencesUseCase _preferencesUseCase;

  SettingsBloc(this._preferencesUseCase) : super(SettingsInitial()) {
    on<LoadSettings>(_onLoadSettings);
    on<UpdateThemeMode>(_onUpdateThemeMode);
    on<UpdateLocale>(_onUpdateLocale);
  }

  Future<void> _onLoadSettings(LoadSettings event, Emitter<SettingsState> emit) async {
    emit(SettingsLoading());
    try {
      final preferences = await _preferencesUseCase.getPreferences();
      emit(SettingsLoaded(preferences));
    } catch (e) {
      emit(SettingsError('Failed to load settings: $e'));
    }
  }

  Future<void> _onUpdateThemeMode(UpdateThemeMode event, Emitter<SettingsState> emit) async {
    try {
      await _preferencesUseCase.updateThemeMode(event.themeMode);
      final preferences = await _preferencesUseCase.getPreferences();
      emit(SettingsLoaded(preferences));
    } catch (e) {
      emit(SettingsError('Failed to update theme: $e'));
    }
  }

  Future<void> _onUpdateLocale(UpdateLocale event, Emitter<SettingsState> emit) async {
    try {
      await _preferencesUseCase.updateLocale(event.locale);
      final preferences = await _preferencesUseCase.getPreferences();
      emit(SettingsLoaded(preferences));
    } catch (e) {
      emit(SettingsError('Failed to update language: $e'));
    }
  }
}
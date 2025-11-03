import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/dependency_injection.dart';
import '../../application/use_cases/preferences_use_case.dart';
import '../../l10n/app_localizations.dart';
import 'settings_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SettingsBloc(serviceLocator<PreferencesUseCase>())
            ..add(LoadSettings()),
      child: const SettingsView(),
    );
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(localizations.settings)),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SettingsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading settings',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<SettingsBloc>().add(LoadSettings());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is SettingsLoaded) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildThemeSection(context, state),
                const SizedBox(height: 24),
                _buildLanguageSection(context, state),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildThemeSection(BuildContext context, SettingsLoaded state) {
    final localizations = AppLocalizations.of(context)!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.palette_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Text(
                  localizations.theme,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildThemeOption(
              context,
              'System Default',
              'Follow device theme',
              ThemeMode.system,
              state.preferences.themeMode,
              Icons.settings_system_daydream,
            ),
            _buildThemeOption(
              context,
              'Light',
              'Light theme',
              ThemeMode.light,
              state.preferences.themeMode,
              Icons.light_mode,
            ),
            _buildThemeOption(
              context,
              'Dark',
              'Dark theme',
              ThemeMode.dark,
              state.preferences.themeMode,
              Icons.dark_mode,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    String title,
    String subtitle,
    ThemeMode themeMode,
    ThemeMode currentTheme,
    IconData icon,
  ) {
    return ListTile(
      leading: Radio<ThemeMode>(
        value: themeMode,
        // ignore: deprecated_member_use
        groupValue: currentTheme,
        // ignore: deprecated_member_use
        onChanged: (value) {
          if (value != null) {
            context.read<SettingsBloc>().add(UpdateThemeMode(value));
          }
        },
      ),
      title: Row(
        children: [Icon(icon, size: 20), const SizedBox(width: 8), Text(title)],
      ),
      subtitle: Text(subtitle),
      onTap: () {
        context.read<SettingsBloc>().add(UpdateThemeMode(themeMode));
      },
    );
  }

  Widget _buildLanguageSection(BuildContext context, SettingsLoaded state) {
    final localizations = AppLocalizations.of(context)!;

    const supportedLocales = [
      Locale('en', 'US'),
      Locale('da', 'DK'),
      // Add more locales when translations are available
      // Locale('es', 'ES'),
      // Locale('fr', 'FR'),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.language,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Text(
                  localizations.language,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...supportedLocales.map(
              (locale) => _buildLanguageOption(
                context,
                _getLanguageName(locale),
                locale,
                state.preferences.locale,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(
    BuildContext context,
    String title,
    Locale locale,
    Locale currentLocale,
  ) {
    return ListTile(
      leading: Radio<Locale>(
        value: locale,
        // ignore: deprecated_member_use
        groupValue: currentLocale,
        // ignore: deprecated_member_use
        onChanged: (value) {
          if (value != null) {
            context.read<SettingsBloc>().add(UpdateLocale(value));
          }
        },
      ),
      title: Row(
        children: [
          Text(_getFlagEmoji(locale), style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Text(title),
        ],
      ),
      subtitle: Text(
        '${locale.languageCode.toUpperCase()} - ${locale.countryCode}',
      ),
      onTap: () {
        context.read<SettingsBloc>().add(UpdateLocale(locale));
      },
    );
  }

  String _getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'da':
        return 'Dansk';
      case 'es':
        return 'Español';
      case 'fr':
        return 'Français';
      default:
        return locale.languageCode.toUpperCase();
    }
  }

  String _getFlagEmoji(Locale locale) {
    switch (locale.countryCode) {
      case 'US':
        return '🇺🇸';
      case 'DK':
        return '🇩🇰';
      case 'ES':
        return '🇪🇸';
      case 'FR':
        return '🇫🇷';
      default:
        return '🌍'; // Globe emoji as fallback
    }
  }
}

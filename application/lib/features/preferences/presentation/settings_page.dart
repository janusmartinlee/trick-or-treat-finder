import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../l10n/app_localizations.dart';
import '../application/preferences_providers.dart';

/// Settings page for managing user preferences
/// 
/// Uses Riverpod for state management:
/// - Watches preferencesNotifierProvider for current preferences
/// - Calls notifier methods to update preferences
/// - Automatically rebuilds when preferences change
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final preferencesAsync = ref.watch(preferencesNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: Text(localizations.settings)),
      body: preferencesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
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
                error.toString(),
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Trigger reload by invalidating the provider
                  ref.invalidate(preferencesNotifierProvider);
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (preferences) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildThemeSection(context, ref, preferences),
            const SizedBox(height: 24),
            _buildLanguageSection(context, ref, preferences),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeSection(
    BuildContext context,
    WidgetRef ref,
    preferences,
  ) {
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
              ref,
              'System Default',
              'Follow device theme',
              ThemeMode.system,
              preferences.themeMode,
              Icons.settings_system_daydream,
            ),
            _buildThemeOption(
              context,
              ref,
              'Light',
              'Light theme',
              ThemeMode.light,
              preferences.themeMode,
              Icons.light_mode,
            ),
            _buildThemeOption(
              context,
              ref,
              'Dark',
              'Dark theme',
              ThemeMode.dark,
              preferences.themeMode,
              Icons.dark_mode,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    WidgetRef ref,
    String title,
    String subtitle,
    ThemeMode themeMode,
    ThemeMode currentTheme,
    IconData icon,
  ) {
    return ListTile(
      leading: Radio<ThemeMode>(
        value: themeMode,
        groupValue: currentTheme,
        onChanged: (value) {
          if (value != null) {
            ref.read(preferencesNotifierProvider.notifier).updateThemeMode(value);
          }
        },
      ),
      title: Row(
        children: [Icon(icon, size: 20), const SizedBox(width: 8), Text(title)],
      ),
      subtitle: Text(subtitle),
      onTap: () {
        ref.read(preferencesNotifierProvider.notifier).updateThemeMode(themeMode);
      },
    );
  }

  Widget _buildLanguageSection(
    BuildContext context,
    WidgetRef ref,
    preferences,
  ) {
    final localizations = AppLocalizations.of(context)!;

    const supportedLocales = [
      Locale('en', 'US'),
      Locale('da', 'DK'),
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
                ref,
                _getLanguageName(locale),
                locale,
                preferences.locale,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(
    BuildContext context,
    WidgetRef ref,
    String title,
    Locale locale,
    Locale currentLocale,
  ) {
    return ListTile(
      leading: Radio<Locale>(
        value: locale,
        groupValue: currentLocale,
        onChanged: (value) {
          if (value != null) {
            ref.read(preferencesNotifierProvider.notifier).updateLocale(value);
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
        ref.read(preferencesNotifierProvider.notifier).updateLocale(locale);
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
        return '🌍';
    }
  }
}

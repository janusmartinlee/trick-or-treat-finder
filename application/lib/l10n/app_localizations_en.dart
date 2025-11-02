// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Trick or Treat Finder';

  @override
  String get welcomeMessage => 'Welcome to Trick or Treat Finder!';

  @override
  String get welcomeSubtitle =>
      'Find the best Halloween treats in your neighborhood';

  @override
  String get settings => 'Settings';

  @override
  String get theme => 'Theme';

  @override
  String get language => 'Language';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageDanish => 'Danish';

  @override
  String get findTreats => 'Find Treats';
}

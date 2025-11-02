// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get appTitle => 'Trick or Treat Finder';

  @override
  String get welcomeMessage => 'Velkommen til Trick or Treat Finder!';

  @override
  String get welcomeSubtitle =>
      'Find de bedste Halloween godbidder i dit nabolag';

  @override
  String get settings => 'Indstillinger';

  @override
  String get theme => 'Tema';

  @override
  String get language => 'Sprog';

  @override
  String get themeLight => 'Lys';

  @override
  String get themeDark => 'Mørk';

  @override
  String get themeSystem => 'System';

  @override
  String get languageEnglish => 'Engelsk';

  @override
  String get languageDanish => 'Dansk';

  @override
  String get findTreats => 'Find Godbidder';
}

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Atomik Spor';

  @override
  String get counterDescription => 'Tap the button to increase the counter.';

  @override
  String counterLabel(int count) {
    return 'Current count: $count';
  }

  @override
  String get incrementTooltip => 'Increment counter';
}

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
    final countString =
        intl.NumberFormat.decimalPattern(localeName).format(count);
    return 'Current count: $countString';
  }

  @override
  String get incrementTooltip => 'Increment counter';
}

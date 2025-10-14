<<<<<<< HEAD
// ignore: unused_import
=======
>>>>>>> 20e8b8e1f85acd5d59510a9545a6cc9a53118d4d
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
<<<<<<< HEAD
  String get appTitle => 'Atomic Sports';

  @override
  String get counterDescription =>
      'You have pushed the button this many times:';

  @override
  String get incrementTooltip => 'Increment';
=======
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
>>>>>>> 20e8b8e1f85acd5d59510a9545a6cc9a53118d4d
}

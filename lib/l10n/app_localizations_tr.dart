import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Atomik Spor';

  @override
  String get counterDescription => 'Butona bastıkça sayaç artar.';

  @override
  String counterLabel(int count) {
    final countString =
        intl.NumberFormat.decimalPattern(localeName).format(count);
    return 'Mevcut değer: $countString';
  }

  @override
  String get incrementTooltip => 'Sayaç artır';
}

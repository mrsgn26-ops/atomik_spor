// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Atomik Spor';

  @override
  String get showCalendarButton => 'Takvimimi Göster';

  @override
  String get habitTrackerTitle => 'Alışkanlık Takvimi';

  @override
  String get habitListTitle => 'Günlük Alışkanlıklar';

  @override
  String habitCompletionSummary(int completed, int total) {
    return '$total alışkanlığın $completed tanesi tamamlandı';
  }

  @override
  String get habitInstructions =>
      'Bir alışkanlığı tamamlandı olarak işaretlemek için üzerine dokunun.';

  @override
  String get habitMorningStretch => 'Sabah esnemesi';

  @override
  String get habitReading => '10 dakika oku';

  @override
  String get habitHydrate => 'Bir bardak su iç';
}

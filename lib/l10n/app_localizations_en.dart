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
  String get showCalendarButton => 'Show My Calendar';

  @override
  String get habitTrackerTitle => 'Habit Calendar';

  @override
  String get habitListTitle => 'Daily Habits';

  @override
  String habitCompletionSummary(int completed, int total) {
    return '$completed of $total habits completed';
  }

  @override
  String get habitInstructions => 'Tap a habit to mark it as done.';

  @override
  String get habitMorningStretch => 'Morning stretch';

  @override
  String get habitReading => 'Read for 10 minutes';

  @override
  String get habitHydrate => 'Drink a glass of water';
}

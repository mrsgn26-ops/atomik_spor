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

  @override
  String get navHome => 'Ana Sayfa';

  @override
  String get navOnboarding => 'Onboarding';

  @override
  String get navWorkout => 'Antrenman';

  @override
  String get navSettings => 'Ayarlar';

  @override
  String get headlineSystemNotGoals => 'Hedef değil, sistem.';

  @override
  String get sub6minStart => 'Bugün 6 dk ile başla';

  @override
  String get btnStart => 'Başla';

  @override
  String get btnChangeLang => 'Dili Değiştir';

  @override
  String get homeWelcomeIllustrationDescription =>
      'Dört kişinin esneme hareketi yaptığı illüstrasyon';

  @override
  String get labelCurrentStreak => 'Güncel zincir';

  @override
  String get labelBestStreak => 'En uzun zincir';

  @override
  String get labelPerfectStreak => 'Mükemmel zincir';

  @override
  String get onboardingTitle1 => 'Hedef değil, sistem';

  @override
  String get onboardingTitle2 => 'Tetikleyicini seç';

  @override
  String get onboardingTitle3 => 'Hatırlatma saatini seç';

  @override
  String get done => 'Bitti';
}

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'habit_tracker_screen.dart';
import 'ui/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/giris1',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/giris1': (context) => const WelcomeScreen(),
        '/habitTracker': (context) => const HabitTrackerScreen(),
      },
      onUnknownRoute: (settings) => MaterialPageRoute<void>(
        builder: (_) => const WelcomeScreen(),
        settings: settings,
      ),
    );
  }
}


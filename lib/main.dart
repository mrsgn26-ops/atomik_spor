import 'package:flutter/material.dart';
import 'package:atomik_spor/l10n/app_localizations.dart';
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
      onGenerateRoute: (settings) {
        if (settings.name == '/giris1' || settings.name == '/') {
          return MaterialPageRoute<void>(
            builder: (_) => const WelcomeScreen(),
            settings: settings,
          );
        }

        if (settings.name == '/habitTracker') {
          return MaterialPageRoute<void>(
            builder: (_) => const HabitTrackerScreen(),
            settings: settings,
          );
        }

        return MaterialPageRoute<void>(
          builder: (_) => const WelcomeScreen(),
          settings: settings,
        );
      },
    );
  }
}


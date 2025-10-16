import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'habit_tracker_screen.dart';
import 'settings_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void _handleLocaleChanged(Locale? locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: _locale,
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
      home: MyHomePage(
        onLocaleChanged: _handleLocaleChanged,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.onLocaleChanged});

  final ValueChanged<Locale?> onLocaleChanged;

  void _openHabitTracker(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HabitTrackerScreen(),
      ),
    );
  }

  void _openSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SettingsPage(
          onLocaleChanged: onLocaleChanged,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.appTitle),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              key: const Key('showCalendarButton'),
              onPressed: () => _openHabitTracker(context),
              child: Text(localizations.btnStart),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              key: const Key('changeLanguageButton'),
              onPressed: () => _openSettings(context),
              child: Text(localizations.btnChangeLang),
            ),
          ],
        ),
      ),
    );
  }
}

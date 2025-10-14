import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';
import 'habit_tracker_screen.dart'; // YENİ EKRANIMIZI BURAYA DAHİL EDİYORUZ

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
      ),
      body: Center(
        // Artık ortada bir butonumuz var
        child: ElevatedButton(
          child: const Text('Takvimimi Göster'),
          onPressed: () {
            // Butona basıldığında yapılacak eylem:
            // Yeni takvim ekranına git.
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HabitTrackerScreen()),
            );
          },
        ),
      ),
    );
  }
}
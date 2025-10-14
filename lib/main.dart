import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart'; // Bu import satırı en önemlisi

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Sağ üstteki "DEBUG" etiketini kaldırır
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

// DİKKAT: Artık bu bölüm değişiyor. "Stateless" yerine
// "Stateful" bir widget kullanıyoruz, çünkü artık bir sayıyı aklında tutması gerekiyor.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Bu, ekranın aklında tutacağı sayıdır.
  int _counter = 0;

  // Bu fonksiyon, butona basıldığında sayıyı bir artırır.
  void _incrementCounter() {
    // setState, Flutter'a "bir veri değişti, ekranı yeniden çiz" demenin sihirli yoludur.
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Dil dosyalarını daha kolay kullanmak için bir değişkene atayalım.
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(localizations.appTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              localizations.counterDescription,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: localizations.incrementTooltip,
        child: const Icon(Icons.add),
      ),
    );
  }
}
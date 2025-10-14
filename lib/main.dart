import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'l10n/app_localizations.dart'; // Bu import satırı en önemlisi
=======
import 'package:atomik_spor/l10n/app_localizations.dart';
>>>>>>> 20e8b8e1f85acd5d59510a9545a6cc9a53118d4d

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

<<<<<<< HEAD
// DİKKAT: Artık bu bölüm değişiyor. "Stateless" yerine
// "Stateful" bir widget kullanıyoruz, çünkü artık bir sayıyı aklında tutması gerekiyor.
=======
>>>>>>> 20e8b8e1f85acd5d59510a9545a6cc9a53118d4d
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
<<<<<<< HEAD
  // Bu, ekranın aklında tutacağı sayıdır.
  int _counter = 0;

  // Bu fonksiyon, butona basıldığında sayıyı bir artırır.
  void _incrementCounter() {
    // setState, Flutter'a "bir veri değişti, ekranı yeniden çiz" demenin sihirli yoludur.
=======
  int _counter = 0;

  void _incrementCounter() {
>>>>>>> 20e8b8e1f85acd5d59510a9545a6cc9a53118d4d
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    // Dil dosyalarını daha kolay kullanmak için bir değişkene atayalım.
=======
>>>>>>> 20e8b8e1f85acd5d59510a9545a6cc9a53118d4d
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
=======
>>>>>>> 20e8b8e1f85acd5d59510a9545a6cc9a53118d4d
        title: Text(localizations.appTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              localizations.counterDescription,
<<<<<<< HEAD
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
=======
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              localizations.counterLabel(_counter),
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
>>>>>>> 20e8b8e1f85acd5d59510a9545a6cc9a53118d4d
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

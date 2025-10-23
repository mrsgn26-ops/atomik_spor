import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key, required this.onLocaleChanged});

  final ValueChanged<Locale?> onLocaleChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final hasTr =
        AppLocalizations.supportedLocales.contains(const Locale('tr'));

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navSettings),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.btnChangeLang,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ElevatedButton(
                  onPressed: () {
                    onLocaleChanged(const Locale('en'));
                    Navigator.pop(context);
                  },
                  child: const Text('English'),
                ),
                if (hasTr)
                  ElevatedButton(
                    onPressed: () {
                      onLocaleChanged(const Locale('tr'));
                      Navigator.pop(context);
                    },
                    child: const Text('Türkçe'),
                  ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(l10n.done),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:atomik_spor/l10n/app_localizations.dart';

import '../../logic/streak_service.dart';

class ChainCard extends StatelessWidget {
  const ChainCard({super.key, required this.service, required this.today});

  final StreakService service;
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final counts = service.getCounts(today);

    return Card(
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _Tile(
              label: localizations.labelCurrentStreak,
              value: counts.currentGrace.toString(),
            ),
            _Tile(
              label: localizations.labelBestStreak,
              value: counts.bestGrace.toString(),
            ),
            _Tile(
              label: localizations.labelPerfectStreak,
              value: counts.currentPerfect.toString(),
            ),
          ],
        ),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}

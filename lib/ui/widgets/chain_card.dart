import 'package:flutter/material.dart';
import '../../logic/streak_service.dart';


class ChainCard extends StatelessWidget {
final StreakService service;
final DateTime today;
const ChainCard({super.key, required this.service, required this.today});


@override
Widget build(BuildContext context) {
final c = service.getCounts(today);
return Card(
margin: const EdgeInsets.all(12),
child: Padding(
padding: const EdgeInsets.all(16),
child: Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
_tile('Zincir', c.currentGrace.toString()),
_tile('Rekor', c.bestGrace.toString()),
_tile('Mükemmel', c.currentPerfect.toString()),
],
),
),
);
}


Widget _tile(String label, String value) {
return Column(
mainAxisSize: MainAxisSize.min,
children: [
Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
const SizedBox(height: 4),
Text(label),
],
);
}
}
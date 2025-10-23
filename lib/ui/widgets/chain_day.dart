import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import 'package:atomik_spor/domain/streak.dart';

class ChainDay extends StatelessWidget {
  final DayVisual v;
  const ChainDay({super.key, required this.v});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final dateLabel = DateFormat.yMMMMEEEEd(l10n.localeName).format(v.day);
    final statusLabel = v.done ? l10n.chainDayCompleted : l10n.chainDayNotCompleted;

    return Semantics(
      label: '$dateLabel · $statusLabel',
      selected: v.done,
      child: CustomPaint(
        painter: _ChainPainter(v),
        child: Center(
          child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: v.done
                  ? (v.inMonth
                      ? Colors.green.shade600
                      : Colors.green.shade300)
                  : Colors.transparent,
              border: Border.all(
                color: v.inMonth ? Colors.green.shade700 : Colors.grey.shade400,
                width: 2,
              ),
            ),
            child: v.isToday
                ? Container(
                    // bugünü ince bir halka ile vurgula
                    margin: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.orange, width: 2),
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}

class _ChainPainter extends CustomPainter {
  final DayVisual v;
  _ChainPainter(this.v);

  @override
  void paint(Canvas canvas, Size size) {
    final centerY = size.height / 2;
    final paintSolid = Paint()
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round
      ..color = v.inMonth ? Colors.green.shade700 : Colors.grey.shade400;

    // soldan bağlantı (bir sonraki hücre sağa çizmeyecek; tekrar yok)
    final start = Offset(0, centerY);
    final endX = size.width / 2 - 16;
    if (endX <= 0) {
      return;
    }
    final end = Offset(endX, centerY);

    switch (v.linkFromLeft) {
      case ChainLink.solid:
        canvas.drawLine(start, end, paintSolid);
        break;
      case ChainLink.dashed:
        _drawDashed(canvas, start, end, paintSolid);
        break;
      case ChainLink.none:
        break;
    }
  }

  void _drawDashed(Canvas c, Offset a, Offset b, Paint p) {
    const dash = 6.0, gap = 5.0;
    final vector = b - a;
    final dist = vector.distance;
    if (dist == 0) {
      return;
    }
    final dir = vector / dist;
    double traveled = 0;
    while (traveled < dist) {
      final start = a + dir * traveled;
      final segmentEnd = traveled + dash;
      final end = a + dir * segmentEnd.clamp(0, dist).toDouble();
      c.drawLine(start, end, p);
      traveled += dash + gap;
    }
  }

  @override
  bool shouldRepaint(covariant _ChainPainter oldDelegate) => oldDelegate.v != v;
}

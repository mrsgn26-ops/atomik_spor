import 'package:flutter/material.dart';
import '../../domain/streak.dart';

class ChainDay extends StatelessWidget {
  final DayVisual v;
  const ChainDay({super.key, required this.v});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ChainPainter(v),
      child: Center(
        child: Container(
          width: 28, height: 28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: v.done ? (v.inMonth ? Colors.green.shade600 : Colors.green.shade300)
                          : Colors.transparent,
            border: Border.all(
              color: v.inMonth ? Colors.green.shade700 : Colors.grey.shade400,
              width: 2,
            ),
          ),
          child: v.isToday
              ? Container( // bugünü ince bir halka ile vurgula
                  margin: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.orange, width: 2),
                  ),
                )
              : null,
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
      ..color = (v.inMonth ? Colors.green.shade700 : Colors.grey.shade400);

    // soldan bağlantı (bir sonraki hücre sağa çizmeyecek; tekrar yok)
    switch (v.linkFromLeft) {
      case ChainLink.solid:
        canvas.drawLine(Offset(0, centerY), Offset(size.width/2 - 16, centerY), paintSolid);
        break;
      case ChainLink.dashed:
        _drawDashed(canvas, Offset(0, centerY), Offset(size.width/2 - 16, centerY), paintSolid);
        break;
      case ChainLink.none:
        break;
    }
  }

  void _drawDashed(Canvas c, Offset a, Offset b, Paint p) {
    const dash = 6.0, gap = 5.0;
    final dx = b.dx - a.dx, dy = b.dy - a.dy;
    final dist = (dx*dx + dy*dy).sqrt();
    final dir = Offset(dx/dist, dy/dist);
    double traveled = 0;
    while (traveled < dist) {
      final start = a + dir * traveled;
      final end = a + dir * (traveled + dash).clamp(0, dist);
      c.drawLine(start, end, p);
      traveled += dash + gap;
    }
  }

  @override
  bool shouldRepaint(covariant _ChainPainter old) => old.v != v;
}

extension on double {
  double clamp(double min, double max) => this < min ? min : (this > max ? max : this);
}

import 'datex.dart';
final days = completed.map(DateX.normalize).toList()..sort();
var best = 1;
var cur = 1;
for (var i = 1; i < days.length; i++) {
final diff = days[i].difference(days[i - 1]).inDays;
if (diff == 1) {
cur += 1;
} else {
if (cur > best) best = cur;
cur = 1;
}
}
if (cur > best) best = cur;
return best;
}


StreakCounts computeStreakCounts(Set<DateTime> completed, DateTime today) {
final cg = computeCurrentGrace(completed, today);
final cp = computeCurrentPerfect(completed, today);
final bg = computeBestGrace(completed);
final bp = computeBestPerfect(completed);
return StreakCounts(
currentGrace: cg,
bestGrace: bg,
currentPerfect: cp,
bestPerfect: bp,
);
}


/// Görselleştirme yardımcıları — ay içindeki "grace" boşluklarını ve bağlantıları bul.
class ChainVisuals {
final Set<int> solidLinks; // d→d+1 (ay günü indeks)
final Set<int> dashedLinks; // d→d+2, aradaki gün boş
final Set<int> graceHoles; // tek boş gün konumu (ay günü indeks)
ChainVisuals(this.solidLinks, this.dashedLinks, this.graceHoles);
}


/// Ay içi görselleştirme: day=1..N indeksleri kullanılır.
ChainVisuals buildLegacyMonthVisuals(
  Set<DateTime> completed,
  int year,
  int month,
) {
  final daysInMonth = DateTime(year, month + 1, 0).day;
  final done = completed
      .map(DateX.normalize)
      .where((d) => d.year == year && d.month == month)
      .toSet();

  final solid = <int>{};
  final dashed = <int>{};
  final holes = <int>{};

  bool isDone(int d) => done.contains(DateTime(year, month, d));

  for (int d = 1; d <= daysInMonth; d++) {
    if (d < daysInMonth && isDone(d) && isDone(d + 1)) {
      solid.add(d); // d → d+1 solid
    }
    if (d + 2 <= daysInMonth && isDone(d) && !isDone(d + 1) && isDone(d + 2)) {
      dashed.add(d); // d → d+2 dashed
      holes.add(d + 1);
    }
  }
  return ChainVisuals(solid, dashed, holes);
}

enum ChainLink { none, solid, dashed }

class DayVisual {
  final DateTime day;
  final bool inMonth;
  final bool done;
  final bool isToday;
  final ChainLink linkFromLeft; // prev -> this
  const DayVisual({
    required this.day,
    required this.inMonth,
    required this.done,
    required this.isToday,
    required this.linkFromLeft,
  });
}

DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

/// Ay görünümündeki (hafta taşmaları dahil) tüm günler için hücre görsellerini üretir.
Map<DateTime, DayVisual> buildMonthVisuals(
  Set<DateTime> completed, {
  required DateTime firstDay, // takvimin sol-üst görünen günü
  required DateTime lastDay, // takvimin sağ-alt görünen günü
  required DateTime month, // odaklanan ay (inMonth hesaplamak için)
  DateTime? today,
}) {
  today ??= DateTime.now();
  final done = completed.map(_dateOnly).toSet();

  final map = <DateTime, DayVisual>{};
  DateTime d = _dateOnly(firstDay);
  final end = _dateOnly(lastDay);

  while (!d.isAfter(end)) {
    final prev = d.subtract(const Duration(days: 1));
    final next = d.add(const Duration(days: 1));

    final prevDone = done.contains(prev);
    final curDone = done.contains(d);
    final nextDone = done.contains(next);

    ChainLink fromLeft = ChainLink.none;

    // Aynı haftadaysa (Pzt–Paz) yatay bağ kur.
    final sameWeekAsPrev = prev.weekday < d.weekday; // basit hafta kontrolü
    if (sameWeekAsPrev) {
      if (prevDone && curDone) {
        fromLeft = ChainLink.solid;
      } else if (prevDone && !curDone && nextDone) {
        // tek gün kaçak köprüsü
        fromLeft = ChainLink.dashed;
      }
    }

    map[d] = DayVisual(
      day: d,
      inMonth: d.month == month.month && d.year == month.year,
      done: curDone,
      isToday: _dateOnly(today) == d,
      linkFromLeft: fromLeft,
    );

    d = d.add(const Duration(days: 1));
  }
  return map;
}

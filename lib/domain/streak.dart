import 'package:atomik_spor/domain/datex.dart';

class StreakCounts {
  final int currentGrace;
  final int bestGrace;
  final int currentPerfect;
  final int bestPerfect;

  const StreakCounts({
    required this.currentGrace,
    required this.bestGrace,
    required this.currentPerfect,
    required this.bestPerfect,
  });
}

StreakCounts computeStreakCounts(Set<DateTime> completed, DateTime today) {
  final normalized = _normalizeSet(completed);
  return StreakCounts(
    currentGrace: _computeCurrentGrace(normalized, today),
    bestGrace: computeBestGrace(normalized),
    currentPerfect: _computeCurrentPerfect(normalized, today),
    bestPerfect: computeBestPerfect(normalized),
  );
}

int computeCurrentPerfect(Set<DateTime> completed, DateTime today) {
  if (completed.isEmpty) {
    return 0;
  }

  final normalized = _normalizeSet(completed);
  return _computeCurrentPerfect(normalized, today);
}

int _computeCurrentPerfect(Set<DateTime> normalized, DateTime today) {
  final day = _dateOnly(today);
  var cursor = day;
  var streak = 0;

  while (normalized.contains(cursor)) {
    streak += 1;
    cursor = cursor.subtract(const Duration(days: 1));
  }

  return streak;
}

int computeCurrentGrace(Set<DateTime> completed, DateTime today) {
  if (completed.isEmpty) {
    return 0;
  }

  final normalized = _normalizeSet(completed);
  return _computeCurrentGrace(normalized, today);
}

int _computeCurrentGrace(Set<DateTime> normalized, DateTime today) {
  final day = _dateOnly(today);
  var cursor = day;
  var streak = 0;
  var consecutiveMisses = 0;

  while (true) {
    if (normalized.contains(cursor)) {
      streak += 1;
      consecutiveMisses = 0;
    } else {
      consecutiveMisses += 1;
      if (consecutiveMisses > 1) {
        break;
      }
    }

    cursor = cursor.subtract(const Duration(days: 1));
  }

  return streak;
}

int computeBestPerfect(Set<DateTime> completed) {
  final days = _sortedDays(completed);
  if (days.isEmpty) {
    return 0;
  }

  var best = 1;
  var current = 1;

  for (var i = 1; i < days.length; i++) {
    final diff = days[i].difference(days[i - 1]).inDays;
    if (diff == 0) {
      continue;
    }

    if (diff == 1) {
      current += 1;
    } else {
      current = 1;
    }

    if (current > best) {
      best = current;
    }
  }

  return best;
}

int computeBestGrace(Set<DateTime> completed) {
  final days = _sortedDays(completed);
  if (days.isEmpty) {
    return 0;
  }

  var best = 1;
  var current = 1;

  for (var i = 1; i < days.length; i++) {
    final diff = days[i].difference(days[i - 1]).inDays;
    if (diff == 0) {
      continue;
    }

    if (diff == 1 || diff == 2) {
      current += 1;
    } else {
      current = 1;
    }

    if (current > best) {
      best = current;
    }
  }

  return best;
}

List<DateTime> _sortedDays(Set<DateTime> completed) {
  final list = _normalizeSet(completed).toList();
  list.sort();
  return list;
}

Set<DateTime> _normalizeSet(Set<DateTime> completed) =>
    completed.map(_dateOnly).toSet();

DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

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

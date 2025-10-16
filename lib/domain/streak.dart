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
ChainVisuals buildMonthVisuals(Set<DateTime> completed, int year, int month) {
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
/// Basit tarih yardımcıları — saat/dakika yok sayılır, yerel güne göre çalışır.
class DateX {
static DateTime normalize(DateTime d) => DateTime(d.year, d.month, d.day);


/// YYYY-MM-DD anahtarı (yerel)
static String ymd(DateTime d) {
final n = normalize(d);
final mm = n.month.toString().padLeft(2, '0');
final dd = n.day.toString().padLeft(2, '0');
return '${n.year}-$mm-$dd';
}


static DateTime parseYmd(String s) {
final p = s.split('-').map(int.parse).toList();
return DateTime(p[0], p[1], p[2]);
}


/// [from]..[to] (dahil) aralığında gün gün ilerler.
static Iterable<DateTime> daysBetween(DateTime from, DateTime to) sync* {
var cur = normalize(from);
final end = normalize(to);
while (!cur.isAfter(end)) {
yield cur;
cur = cur.add(const Duration(days: 1));
}
}
}
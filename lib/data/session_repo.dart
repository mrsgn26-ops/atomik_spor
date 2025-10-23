import 'package:atomik_spor/domain/datex.dart';

/// Şimdilik basit bellek‑içi repo. Sonra Hive/Drift ile kalıcı yaparız.
class SessionRepo {
  final Set<String> _doneYmd = <String>{}; // 'YYYY-MM-DD'

  bool isCompleted(DateTime day) => _doneYmd.contains(DateX.ymd(day));

  void markCompleted(DateTime day, {int? durationMin}) {
    _doneYmd.add(DateX.ymd(day));
  }

  void unmark(DateTime day) {
    _doneYmd.remove(DateX.ymd(day));
  }

  /// Tüm tamamlananlar (normalize edilmiş)
  Set<DateTime> allCompleted() => _doneYmd.map(DateX.parseYmd).toSet();

  /// Ay içindeki tamamlananlar
  Set<DateTime> completedInMonth(int year, int month) {
    return _doneYmd
        .map(DateX.parseYmd)
        .where((d) => d.year == year && d.month == month)
        .toSet();
  }

  /// Sıralı (eskiye → yeni) liste
  List<DateTime> sortedCompleted() {
    final list = _doneYmd.map(DateX.parseYmd).toList();
    list.sort((a, b) => a.compareTo(b));
    return list;
  }
}

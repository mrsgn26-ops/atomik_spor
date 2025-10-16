import '../data/session_repo.dart';
import '../domain/streak.dart';


class StreakService {
final SessionRepo repo;
StreakService(this.repo);


void onWorkoutCompleted(DateTime date, {int? durationMin}) {
repo.markCompleted(date, durationMin: durationMin);
}


StreakCounts getCounts(DateTime today) {
return computeStreakCounts(repo.allCompleted(), today);
}
}
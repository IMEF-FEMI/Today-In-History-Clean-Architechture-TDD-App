
abstract class TodayInHistoryRepository {
  Future<Either<Failure, TodayEvents>> getEventsForToday();
  Future<Either<Failure, TodayEvents>> getEventsForDate(int month, int day);
}

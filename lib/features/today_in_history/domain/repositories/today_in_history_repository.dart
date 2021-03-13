
import 'package:dartz/dartz.dart';

import 'package:today_in_history/core/error/failures.dart';
import 'package:today_in_history/features/today_in_history/domain/entities/today_events.dart';

abstract class TodayInHistoryRepository {
  Future<Either<Failure, TodayEvents>> getEventsForToday();
  Future<Either<Failure, TodayEvents>> getEventsForDate(int month, int day);
}

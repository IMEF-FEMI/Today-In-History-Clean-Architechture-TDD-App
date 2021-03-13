import 'package:today_in_history/features/today_in_history/data/models/today_events_model.dart';
import 'package:today_in_history/features/today_in_history/domain/entities/today_events.dart';


abstract class TIHLocalDataSource {
  ///cache today in history (TIH events)
  Future cacheTIHEvents(TodayEventsModel eventsToCache);
  Future<TodayEvents> getLastTIHEvent();
}

abstract class TIHRemoteDataSource {
  Future<TodayEvents> getEventsForToday();
  Future<TodayEvents> getEventsForDate(int month, int day);
}

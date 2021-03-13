part of 'today_in_history_bloc.dart';

@immutable
abstract class TodayInHistoryEvent {}

class GetTIHForSpecificDay extends TodayInHistoryEvent {
  final int month;
  final int day;

  GetTIHForSpecificDay({
    @required this.month,
    @required this.day,
  });
}

class GetTIHForToday extends TodayInHistoryEvent {}

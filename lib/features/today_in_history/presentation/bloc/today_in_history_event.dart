part of 'today_in_history_bloc.dart';

@immutable
abstract class TodayInHistoryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetTIHForSpecificDay extends TodayInHistoryEvent {
  final int month;
  final int day;

  GetTIHForSpecificDay({
    @required this.month,
    @required this.day,
  });

  @override
  List<Object> get props => [month, day];
}

class GetTIHForToday extends TodayInHistoryEvent {
  @override
  List<Object> get props => ['GetTIHForToday'];
}

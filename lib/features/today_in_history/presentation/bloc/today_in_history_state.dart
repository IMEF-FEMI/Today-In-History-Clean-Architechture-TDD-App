part of 'today_in_history_bloc.dart';

@immutable
abstract class TodayInHistoryState extends Equatable {}

class Empty extends TodayInHistoryState {
  @override
  List<Object> get props => ["Empty"];
}

class Loading extends TodayInHistoryState {
  @override
  List<Object> get props => ["Loading"];
}

class Loaded extends TodayInHistoryState {
  final TodayEventsModel eventsModel;

  Loaded({@required this.eventsModel});
  @override
  List<Object> get props => [eventsModel];
}

class Error extends TodayInHistoryState {
  final String message;

  Error({@required this.message});
  @override
  List<Object> get props => [message];
}

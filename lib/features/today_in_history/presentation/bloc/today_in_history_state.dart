part of 'today_in_history_bloc.dart';

@immutable
abstract class TodayInHistoryState extends Equatable{
   @override
  List<Object> get props => [];
}

class Empty extends TodayInHistoryState {
  
}

class Loading extends TodayInHistoryState {}

class Loaded extends TodayInHistoryState {
  final TodayEventsModel eventsModel;

  Loaded({@required this.eventsModel});
}

class Error extends TodayInHistoryState {
  final String message;

  Error({@required this.message});
}

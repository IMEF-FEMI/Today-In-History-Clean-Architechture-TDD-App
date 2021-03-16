part of 'date_selector_bloc.dart';

abstract class DateSelectorEvent extends Equatable {
  const DateSelectorEvent();

  @override
  List<Object> get props => [];
}

class ChangeSelectedDate extends DateSelectorEvent {
  final DateTime selectedDate;

  ChangeSelectedDate({@required this.selectedDate});

}

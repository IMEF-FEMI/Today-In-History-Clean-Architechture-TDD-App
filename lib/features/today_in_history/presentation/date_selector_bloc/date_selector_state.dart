part of 'date_selector_bloc.dart';

abstract class DateSelectorState extends Equatable {
  const DateSelectorState();

  @override
  List<Object> get props => [];
}

class DateSelectorInitial extends DateSelectorState {
  final DateTime selectedDate;

  DateSelectorInitial({
   @required  this.selectedDate,
  });
}

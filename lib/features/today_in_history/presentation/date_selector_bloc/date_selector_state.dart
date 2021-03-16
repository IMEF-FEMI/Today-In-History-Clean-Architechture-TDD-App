part of 'date_selector_bloc.dart';

class DateSelectorState extends Equatable {
  final DateTime selectedDate;

  DateSelectorState({
    @required this.selectedDate,
  });

  @override
  List<Object> get props => [selectedDate];
}

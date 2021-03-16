import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'date_selector_event.dart';
part 'date_selector_state.dart';

class DateSelectorBloc extends Bloc<DateSelectorEvent, DateSelectorState> {
  DateSelectorBloc() : super(DateSelectorInitial());

  @override
  Stream<DateSelectorState> mapEventToState(
    DateSelectorEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}

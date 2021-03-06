import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'date_selector_event.dart';
part 'date_selector_state.dart';

class DateSelectorBloc extends Bloc<DateSelectorEvent, DateSelectorState> {
  DateSelectorBloc()
      : super(DateSelectorState(
          selectedDate: DateTime.now(),
        ));

  @override
  Stream<DateSelectorState> mapEventToState(
    DateSelectorEvent event,
  ) async* {
    if (event is ChangeSelectedDate) {
      yield DateSelectorState(selectedDate: event.selectedDate);
    }
  }


  @override
  Future<void> close() {
    return super.close();
  }

}

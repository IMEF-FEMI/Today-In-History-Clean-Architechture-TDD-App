import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:today_in_history/core/error/failures.dart';
import 'package:today_in_history/core/usecase/usecase.dart';
import 'package:today_in_history/features/today_in_history/data/models/today_events_model.dart';
import 'package:today_in_history/features/today_in_history/domain/entities/today_events.dart';
import 'package:today_in_history/features/today_in_history/domain/usecases/get_events_for_date.dart';
import 'package:today_in_history/features/today_in_history/domain/usecases/get_events_for_today.dart';
import 'package:dartz/dartz.dart';
import 'package:today_in_history/features/today_in_history/presentation/date_selector_bloc/date_selector_bloc.dart';

part 'today_in_history_event.dart';
part 'today_in_history_state.dart';

const String SERVER_FAILURE_MESSAGE = "Server Failure";
const String CACHE_FAILURE_MESSAGE = "Cache Failure";

class TodayInHistoryBloc
    extends Bloc<TodayInHistoryEvent, TodayInHistoryState> {
  GetEventsForDate getEventsForDate;
  GetEventsForToday getEventsForToday;
  DateSelectorBloc dateSelectorBloc;
  StreamSubscription dateSelectorSubscription;

  TodayInHistoryBloc({
    @required GetEventsForDate date,
    @required GetEventsForToday today,
    @required DateSelectorBloc dateBloc,
  }) : super(Empty()) {
    assert(date != null);
    assert(today != null);
    assert(dateBloc != null);
    getEventsForDate = date;
    getEventsForToday = today;
    dateSelectorBloc = dateBloc;

    dateSelectorSubscription = dateBloc.listen((dateSelectorState) {
      print("---------------");
      print("-----------");
      print("--------");
      print("-----");
      print("--");
      print("New date has been selected");
      add(GetTIHForSpecificDay(
          day: dateSelectorState.selectedDate.day,
          month: dateSelectorState.selectedDate.month));
    });
  }

  @override
  Future<void> close() {
    dateSelectorSubscription.cancel();
    return super.close();
  }

  @override
  Stream<TodayInHistoryState> mapEventToState(
    TodayInHistoryEvent event,
  ) async* {
    if (event is GetTIHForSpecificDay) {
      yield Loading();
      final failureOrEvent = await getEventsForDate(Params(
        month: event.month,
        day: event.day,
      ));

      yield* _eitherLoadedOrErrorState(failureOrEvent);
    } else if (event is GetTIHForToday) {
      yield Loading();
      final failureOrEvent = await getEventsForToday(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrEvent);
    } else if (event is Retry) {
      add(GetTIHForSpecificDay(
          day: dateSelectorBloc.state.selectedDate.day,
          month: dateSelectorBloc.state.selectedDate.month));
    }
  }

  Stream<TodayInHistoryState> _eitherLoadedOrErrorState(
      Either<Failure, TodayEvents> failureOrTrivia) async* {
    yield failureOrTrivia.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (eventsModel) => Loaded(eventsModel: eventsModel),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}

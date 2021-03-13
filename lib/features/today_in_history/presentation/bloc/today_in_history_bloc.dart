import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:today_in_history/core/error/failures.dart';
import 'package:today_in_history/core/usecase/usecase.dart';
import 'package:today_in_history/features/today_in_history/data/models/today_events_model.dart';
import 'package:today_in_history/features/today_in_history/domain/usecases/get_events_for_date.dart';
import 'package:today_in_history/features/today_in_history/domain/usecases/get_events_for_today.dart';

part 'today_in_history_event.dart';
part 'today_in_history_state.dart';

const String SERVER_FAILURE_MESSAGE = "Server Failure";
const String CACHE_FAILURE_MESSAGE = "Cache Failure";

class TodayInHistoryBloc
    extends Bloc<TodayInHistoryEvent, TodayInHistoryState> {
  final GetEventsForDate getEventsForDate;
  final GetEventsForToday getEventsForToday;

  TodayInHistoryBloc({
    @required GetEventsForDate date,
    @required GetEventsForToday today,
  })  : assert(date != null),
        assert(today != null),
        getEventsForDate = date,
        getEventsForToday = today;

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
    }
  }

  Stream<TodayInHistoryState> _eitherLoadedOrErrorState(
      Either<Failure, TodayEventsModel> failureOrTrivia) async* {
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

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:today_in_history/core/error/failures.dart';
import 'package:today_in_history/core/usecase/usecase.dart';
import 'package:today_in_history/features/today_in_history/domain/entities/today_events.dart';
import 'package:today_in_history/features/today_in_history/domain/repositories/today_in_history_repository.dart';

class GetEventsForDate implements UseCase<TodayEvents, Params> {
  final TodayInHistoryRepository repository;

  GetEventsForDate({this.repository});

  @override
  Future<Either<Failure, TodayEvents>> call(Params params) async {
    return await repository.getEventsForDate(params.month, params.day);
  }
}

class Params {
  final int month;
  final int day;

  Params({@required this.month, @required this.day});
}

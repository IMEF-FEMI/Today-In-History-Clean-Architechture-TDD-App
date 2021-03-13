import 'package:dartz/dartz.dart';
import 'package:today_in_history/core/error/failures.dart';
import 'package:today_in_history/core/usecase/usecase.dart';
import 'package:today_in_history/features/today_in_history/domain/repositories/today_in_history_repository.dart';
import 'package:today_in_history/features/today_in_history/domain/entities/today_events.dart';

class GetEventsForToday implements UseCase<TodayEvents, NoParams> {
  final TodayInHistoryRepository repository;

  GetEventsForToday({this.repository});

  @override
  Future<Either<Failure, TodayEvents>> call(NoParams noParams) async {
    return await repository.getEventsForToday();
  }
}

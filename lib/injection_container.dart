import 'package:get_it/get_it.dart';
import 'package:today_in_history/features/today_in_history/presentation/bloc/today_in_history_bloc.dart';

import 'features/today_in_history/domain/usecases/get_events_for_date.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc
  serviceLocator.registerFactory(
    () => TodayInHistoryBloc(
      date: serviceLocator(),
      today: serviceLocator(),
    ),
  );

    // use cases
      serviceLocator.registerLazySingleton(
    () => GetEventsForDate(
      repository: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => GetEventsForToday(
      repository: serviceLocator(),
    ),
  );
}

import 'package:get_it/get_it.dart';
import 'package:today_in_history/features/today_in_history/presentation/bloc/today_in_history_bloc.dart';

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
    
}

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:today_in_history/core/network/network_info.dart';
import 'package:today_in_history/features/today_in_history/domain/repositories/today_in_history_repository.dart';
import 'package:today_in_history/features/today_in_history/presentation/bloc/today_in_history_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:today_in_history/features/today_in_history/presentation/date_selector_bloc/date_selector_bloc.dart';
import 'features/today_in_history/data/datasources/datasources.dart';
import 'features/today_in_history/data/datasources/tih_local_data_source.dart';
import 'features/today_in_history/data/datasources/tih_remote_data_source.dart';
import 'features/today_in_history/data/repositories/today_in_history_repository_impl.dart';
import 'features/today_in_history/domain/usecases/get_events_for_date.dart';
import 'features/today_in_history/domain/usecases/get_events_for_today.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc
  serviceLocator.registerFactory(
    () => TodayInHistoryBloc(
      date: serviceLocator(),
      today: serviceLocator(),
      dateBloc: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => DateSelectorBloc(),
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

  // repository
  serviceLocator.registerLazySingleton<TodayInHistoryRepository>(
    () => TodayInHistoryRepositoryImpl(
      localDataSource: serviceLocator(),
      remoteDataSource: serviceLocator(),
      networkInfo: serviceLocator(),
    ),
  );

  // Data sources
  serviceLocator.registerLazySingleton<TIHLocalDataSource>(
    () => TIHLocalDataSourceImpl(
      sharedPreferences: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<TIHRemoteDataSource>(
    () => TIHRemoteDataSourceImpl(
      client: serviceLocator(),
    ),
  );

  //! Core

  serviceLocator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(serviceLocator()),
  );
  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);
  serviceLocator.registerLazySingleton(() => http.Client());
  serviceLocator.registerLazySingleton(() => DataConnectionChecker());
}

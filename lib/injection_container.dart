import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc
  serviceLocator.registerFactory(
    () => TIH(
      concrete: sl(),
      inputConverter: sl(),
      random: sl(),
    ),
  );

}

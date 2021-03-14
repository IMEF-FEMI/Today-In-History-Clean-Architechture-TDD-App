import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:today_in_history/core/error/failures.dart';
import 'package:today_in_history/core/usecase/usecase.dart';
import 'package:today_in_history/features/today_in_history/data/models/today_events_model.dart';
import 'package:today_in_history/features/today_in_history/domain/entities/today_events.dart';
import 'package:today_in_history/features/today_in_history/domain/usecases/get_events_for_date.dart';
import 'package:today_in_history/features/today_in_history/domain/usecases/get_events_for_today.dart';
import 'package:today_in_history/features/today_in_history/presentation/bloc/today_in_history_bloc.dart';

class MockGetEventsForDate extends Mock implements GetEventsForDate {}

class MockGetEventsForToday extends Mock implements GetEventsForToday {}

void main() {
  TodayInHistoryBloc bloc;
  MockGetEventsForDate mockGetEventsForDate;
  MockGetEventsForToday mockGetEventsForToday;

  setUp(() {
    mockGetEventsForDate = MockGetEventsForDate();
    mockGetEventsForToday = MockGetEventsForToday();

    bloc = TodayInHistoryBloc(
      date: mockGetEventsForDate,
      today: mockGetEventsForToday,
    );
  });

  test('initialState should be empty', () {
    // assert
    expect(bloc.state, equals(Empty()));
  });

  group('get TIH for specific date', () {
    final tMonth = 2;
    final tDay = 14;
    final tEventsForDay = TodayEventsModel(
      date: "March 12",
      url: "https://wikipedia.org/wiki/March_12",
      events: <Event>[
        Event(
          link: "https://wikipedia.org/wiki/Vitiges",
          text:
              "Vitiges, king of the Ostrogoths ends his siege of Rome and retreats to Ravenna, leaving the city in the hands of the victorious Byzantine general",
          year: "538",
        ),
        Event(
          link: "https://wikipedia.org/wiki/Ignatius_of_Loyola",
          text:
              "Ignatius of Loyola and Francis Xavier, founders of the Society of Jesus, are canonized by the Roman Catholic Church.",
          year: "1622",
        ),
      ],
    );

    test('Should emit [Loading, Loaded] when data is gotten successfully',
        () async {
      // arrange
      when(mockGetEventsForDate(any)).thenAnswer((_) async {
        return Right(tEventsForDay);
      });

      // assert later
      final expected = [
        // Empty(),
        Loading(),
        Loaded(eventsModel: tEventsForDay),
      ];

      expectLater(bloc, emitsInOrder(expected));

      // act
      bloc.add(GetTIHForSpecificDay(month: tMonth, day: tDay));
      // await untilCalled(mockGetEventsForDate(Params(month: tMonth, day: tDay)));
    });

    test('Should emit [Loading, Error] when getting data fails', () async {
      // arrange
      when(mockGetEventsForDate(any))
          .thenReturn(Left(ServerFailure());

      // assert later
      final expected = [
        Empty(),
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ];

      expectLater(bloc, emitsInOrder(expected));

      // act
      bloc.add(GetTIHForSpecificDay(month: tMonth, day: tDay));
      // await untilCalled(mockGetEventsForDate(Params(month: tMonth, day: tDay)));
    });
  });

  group('get TIH for today', () {
    final tMonth = 2;
    final tDay = 14;
    final tEventsForDay = TodayEventsModel(
      date: "March 12",
      url: "https://wikipedia.org/wiki/March_12",
      events: <Event>[
        Event(
          link: "https://wikipedia.org/wiki/Vitiges",
          text:
              "Vitiges, king of the Ostrogoths ends his siege of Rome and retreats to Ravenna, leaving the city in the hands of the victorious Byzantine general",
          year: "538",
        ),
        Event(
          link: "https://wikipedia.org/wiki/Ignatius_of_Loyola",
          text:
              "Ignatius of Loyola and Francis Xavier, founders of the Society of Jesus, are canonized by the Roman Catholic Church.",
          year: "1622",
        ),
      ],
    );

    test('Should emit [Loading, Loaded] when data is gotten successfully',
        () async {
      // arrange
      when(mockGetEventsForToday(any))
          .thenAnswer((_) async => Right(tEventsForDay));

      // assert later
      final expected = [
        Empty(),
        Loading(),
        Loaded(eventsModel: tEventsForDay),
      ];

      expectLater(bloc, emitsInOrder(expected));

      // act
      bloc.add(GetTIHForSpecificDay(month: tMonth, day: tDay));
      await untilCalled(mockGetEventsForToday(NoParams()));
    });

    test('Should emit [Loading, Error] when getting data fails', () async {
      // arrange
      when(mockGetEventsForToday(NoParams()))
          .thenAnswer((_) async => Left(ServerFailure()));

      // assert later
      final expected = [
        Empty(),
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ];

      expectLater(bloc, emitsInOrder(expected));

      // act
      bloc.add(GetTIHForToday());
      await untilCalled(mockGetEventsForToday(NoParams()));
    });
  });
}

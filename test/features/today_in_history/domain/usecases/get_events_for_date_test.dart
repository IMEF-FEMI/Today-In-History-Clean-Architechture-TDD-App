import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:today_in_history/features/today_in_history/domain/entities/today_events.dart';
import 'package:today_in_history/features/today_in_history/domain/repositories/today_in_history_repository.dart';
import 'package:today_in_history/features/today_in_history/domain/usecases/get_events_for_date.dart';

class MockTodayInHistoryRepository extends Mock
    implements TodayInHistoryRepository {}

void main() {
  GetEventsForDate usecase;
  MockTodayInHistoryRepository mockTodayInHistoryRepository;

  setUp(() {
    mockTodayInHistoryRepository = MockTodayInHistoryRepository();
    usecase = GetEventsForDate(repository: mockTodayInHistoryRepository);
  });

  final tMonth = 1;
  final tDay = 12;
  final tEventsForDay = TodayEvents(
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

  test('Should get events for the specified date', () async {
// arrange
    when(mockTodayInHistoryRepository.getEventsForDate(any, any))
        .thenAnswer((_) async => Right(tEventsForDay));
// act
    final result = await usecase(Params(month: tMonth, day: tDay));

// assert

    expect(result, Right(tEventsForDay));
    verify(mockTodayInHistoryRepository.getEventsForDate(tMonth, tDay));
    verifyNoMoreInteractions(mockTodayInHistoryRepository);
  });
}

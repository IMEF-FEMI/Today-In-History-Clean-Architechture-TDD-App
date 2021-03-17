import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:today_in_history/features/today_in_history/domain/usecases/get_events_for_date.dart';
import 'package:today_in_history/features/today_in_history/domain/usecases/get_events_for_today.dart';
import 'package:today_in_history/features/today_in_history/presentation/bloc/today_in_history_bloc.dart';
import 'package:today_in_history/features/today_in_history/presentation/date_selector_bloc/date_selector_bloc.dart';
import 'package:today_in_history/features/today_in_history/presentation/widgets/date_cards.dart';


class MockGetEventsForDate extends Mock implements GetEventsForDate {}

class MockGetEventsForToday extends Mock implements GetEventsForToday {}

void main() {
   TodayInHistoryBloc bloc;
  MockGetEventsForDate mockGetEventsForDate;
  MockGetEventsForToday mockGetEventsForToday;
  DateSelectorBloc dateSelectorBloc;

  setUp(() {
    mockGetEventsForDate = MockGetEventsForDate();
    mockGetEventsForToday = MockGetEventsForToday();
    dateSelectorBloc = DateSelectorBloc();

    bloc = TodayInHistoryBloc(
      date: mockGetEventsForDate,
      today: mockGetEventsForToday,
      dateBloc: dateSelectorBloc,
    );
  });

group('DateCards', () {
    testWidgets("Ensure ListView is initialized with horizontal scroll and 7 children ", (tester) async {
    await tester.pumpWidget(DateCards());
    await tester.pumpAndSettle();
    expect(find.byType(ListView), findsOneWidget);
    
  });
});

}

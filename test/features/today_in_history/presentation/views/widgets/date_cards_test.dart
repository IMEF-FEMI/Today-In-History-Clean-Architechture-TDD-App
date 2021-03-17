import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  Widget initWidget(Widget child) => MediaQuery(
      data: new MediaQueryData(),
      child: new MaterialApp(
          home: Scaffold(
        body: BlocProvider<TodayInHistoryBloc>(
          create: (context) => bloc,
          child: BlocBuilder<TodayInHistoryBloc, TodayInHistoryState>(
            builder: (context, state) {
              return BlocProvider(
                create: (context) => dateSelectorBloc,
                child: BlocBuilder<DateSelectorBloc, DateSelectorState>(
                  builder: (context, state) {
                    return Column(
                      children: [child],
                    );
                  },
                ),
              );
            },
          ),
        ),
      )));
  group('DateCards', () {
    testWidgets("Ensure ListView is initialized", (tester) async {
      await tester.pumpWidget(initWidget(DateCards()));
      await tester.pumpAndSettle();
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets("ensure Listview scrolls horizontally", (tester) async {
      await tester.pumpWidget(initWidget(DateCards()));
      await tester.pumpAndSettle();
      final listView = find.byKey(Key('date_card_listview'));
      final dataCardListview = tester.firstWidget<ListView>(listView);

      expect(dataCardListview.scrollDirection, Axis.horizontal);
    });

    testWidgets("ensure Listview has seven children", (tester) async {
      await tester.pumpWidget(initWidget(DateCards()));
      await tester.pumpAndSettle();
      final dateCardItem = [
        Key("date_card_item_0"),
        Key("date_card_item_1"),
        Key("date_card_item_2"),
        Key("date_card_item_3"),
        Key("date_card_item_4"),
        Key("date_card_item_5"),
        Key("date_card_item_6"),
      ];
      for (var key in dateCardItem) {
        expect(find.byKey(key), findsOneWidget);
      }
    });

    testWidgets("ensure the child background colors are assigned accordingly",
        (tester) async {
      await tester.pumpWidget(initWidget(DateCards()));
      await tester.pumpAndSettle();
      final dateCard = find.byKey(Key('date_card_item_0'));
      final dateContainer = tester.firstWidget<Container>(dateCard);
      final initialDecoration = BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.withOpacity(.2),
        ),
        borderRadius: BorderRadius.circular(20.0),
      );
      // initial color is white
      expect(dateContainer.decoration, initialDecoration);

      final dateCard1 = find.byKey(Key('date_card_item_3'));
      final dateContainer1 = tester.firstWidget<Container>(dateCard1);

      final activeDecoration = BoxDecoration(
        color: Color(0xff09090f),
        border: Border.all(
          color: Colors.grey.withOpacity(.2),
        ),
        borderRadius: BorderRadius.circular(20.0),
      );

      // expect(dateContainer1.decoration, activeDecoration);
    });
  });
}

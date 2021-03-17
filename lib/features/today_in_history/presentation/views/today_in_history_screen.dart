import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:today_in_history/features/today_in_history/presentation/bloc/today_in_history_bloc.dart';
import 'package:today_in_history/features/today_in_history/presentation/date_selector_bloc/date_selector_bloc.dart';
import 'package:today_in_history/features/today_in_history/presentation/widgets/date_cards.dart';
import 'package:today_in_history/features/today_in_history/presentation/widgets/date_info_view.dart';
import 'package:today_in_history/features/today_in_history/presentation/widgets/history_views.dart';
import 'package:today_in_history/injection_container.dart';

class TodayInHistoryView extends StatefulWidget {
  @override
  _TodayInHistoryViewState createState() => _TodayInHistoryViewState();
}

class _TodayInHistoryViewState extends State<TodayInHistoryView> {
  DateTime today = DateTime.now();
  List<DateTime> selectableDates;
  // DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectableDates = [
      today.subtract(Duration(days: 3)),
      today.subtract(Duration(days: 2)),
      today.subtract(Duration(days: 1)),
      today,
      today.add(Duration(days: 1)),
      today.add(Duration(days: 2)),
      today.add(Duration(days: 3)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<DateSelectorBloc>(),
      child: BlocBuilder<DateSelectorBloc, DateSelectorState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Today in History"),
              centerTitle: true,
              backgroundColor: Color(0xff3c3395),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                DateCards(),
                SizedBox(height: 50),
                DateInfoView(),
                SizedBox(height: 20),
                Divider(),
                HistoryListView(),
              ],
            ),
          );
        },
      ),
    );
  }
}

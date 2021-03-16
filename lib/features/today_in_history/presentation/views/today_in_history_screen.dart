import 'package:flutter/material.dart';

class TodayInHistoryView extends StatefulWidget {
  @override
  _TodayInHistoryViewState createState() => _TodayInHistoryViewState();
}

class _TodayInHistoryViewState extends State<TodayInHistoryView> {
  DateTime today = DateTime.now();
  List<DateTime> selectableDates;

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
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            buildSelectableDateCards(),
            Center(
              child: Text("Today in History"),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSelectableDateCards() {
    return Container(
      child: ListView.builder(
        itemCount: selectableDates.length,
        itemBuilder: (context, index) {
          return Container(
            height: MediaQuery.of(context).size.height * .1,
            width: MediaQuery.of(context).size.width * .1,
          );
        },
      ),
    );
  }
}

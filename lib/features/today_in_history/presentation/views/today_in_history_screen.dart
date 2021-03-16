import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
            // Center(
            //   child: Text("Today in History"),
            // ),
          ],
        ),
      ),
    );
  }

  Widget buildSelectableDateCards() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        height: MediaQuery.of(context).size.height * .1,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: selectableDates.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {},
                child: Container(
                  height: MediaQuery.of(context).size.height * .1,
                  width: MediaQuery.of(context).size.width * .15,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        // red as border color
                      ),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(DateFormat("EEE").format(selectableDates[index]))
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

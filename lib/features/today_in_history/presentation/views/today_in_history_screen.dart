import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodayInHistoryView extends StatefulWidget {
  @override
  _TodayInHistoryViewState createState() => _TodayInHistoryViewState();
}

class _TodayInHistoryViewState extends State<TodayInHistoryView> {
  DateTime today = DateTime.now();
  List<DateTime> selectableDates;
  DateTime selectedDate;

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
    selectedDate = today;
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
                splashColor: Theme.of(context).primaryColor.withOpacity(.4),
                onTap: () {
                  setState(() {
                    selectedDate = selectableDates[index];
                  });
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * .1,
                  width: MediaQuery.of(context).size.width * .15,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.withOpacity(.2),
                      ),
                      color: selectedDate == selectableDates[index]
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat("EEE").format(selectableDates[index]),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: selectedDate == selectableDates[index]
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                          fontSize: 10,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        DateFormat("dd").format(selectableDates[index]),
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: selectedDate == selectableDates[index]
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        DateFormat("MMM").format(selectableDates[index]),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: selectedDate == selectableDates[index]
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                          fontSize: 10,
                        ),
                      ),
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

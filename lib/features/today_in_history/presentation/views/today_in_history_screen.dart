import 'package:flutter/material.dart';

class TodayInHistoryView extends StatefulWidget {
  @override
  _TodayInHistoryViewState createState() => _TodayInHistoryViewState();
}

class _TodayInHistoryViewState extends State<TodayInHistoryView> {
  @override
    void initState() {
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Today in History"),
      ),
    );
  }
}

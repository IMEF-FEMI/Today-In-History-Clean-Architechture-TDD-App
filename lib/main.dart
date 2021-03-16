import 'package:flutter/material.dart';
import 'package:today_in_history/features/today_in_history/presentation/views/today_in_history_screen.dart';
import 'injection_container.dart' as di;

void main() async {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      
        primaryColor: Color(0xff3c3395),
      ),
      home: TodayInHistoryView(),
    );
  }
}

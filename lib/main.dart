import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:today_in_history/features/today_in_history/presentation/views/today_in_history_screen.dart';
import 'features/today_in_history/presentation/bloc/today_in_history_bloc.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primaryColor: Color(0xff09090f),
        primaryColor: Color(0xff06112d),
      ),
      home: BlocProvider(
        create: (context) => di.serviceLocator<TodayInHistoryBloc>(),
        child: BlocBuilder<TodayInHistoryBloc, TodayInHistoryState>(
          builder: (context, state) {
            return TodayInHistoryView();
          },
        ),
      ),
    );
  }
}

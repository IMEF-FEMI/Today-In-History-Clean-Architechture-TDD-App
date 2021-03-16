import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:today_in_history/features/today_in_history/presentation/bloc/today_in_history_bloc.dart';
import 'package:today_in_history/injection_container.dart';

class HistoryListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodayInHistoryBloc>(
      create: (context) => serviceLocator<TodayInHistoryBloc>(),
      child: BlocBuilder<TodayInHistoryBloc, TodayInHistoryState>(
        builder: (context, state) {
          return Container();
        },
      )
      ,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:today_in_history/features/today_in_history/presentation/bloc/today_in_history_bloc.dart';
import 'package:today_in_history/injection_container.dart';
import 'package:lottie/lottie.dart';

class HistoryListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodayInHistoryBloc>(
      create: (context) => serviceLocator<TodayInHistoryBloc>(),
      child: BlocBuilder<TodayInHistoryBloc, TodayInHistoryState>(
        builder: (context, state) {
          return Expanded(
            child: LottieBuilder.asset(
              'assets/animations/lottie/loading-screen-loader-spinning-circle.json',
              width: MediaQuery.of(context).size.width * 0.35,
              repeat: true,
            ),
          );
        },
      ),
    );

    // return Expanded(
    //   child: LottieBuilder.asset(
    //     'assets/animations/lottie/loading-screen-loader-spinning-circle.json',
    //     width: MediaQuery.of(context).size.width * 0.35,
    //     repeat: true,
    //   ),
    // );
  }
}

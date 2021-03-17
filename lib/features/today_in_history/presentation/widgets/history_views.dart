import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:today_in_history/features/today_in_history/domain/entities/today_events.dart';
import 'package:today_in_history/features/today_in_history/presentation/bloc/today_in_history_bloc.dart';
import 'package:today_in_history/injection_container.dart';
import 'package:lottie/lottie.dart';

class HistoryListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodayInHistoryBloc>(
      create: (context) => serviceLocator<TodayInHistoryBloc>()..add(GetTIHForToday()),
      child: BlocBuilder<TodayInHistoryBloc, TodayInHistoryState>(
        builder: (context, state) {
          print(state);
          if (state is Loaded) {
            return Expanded(
              child: ListView.builder(
                itemCount: state.eventsModel.events.length,
                itemBuilder: (context, index) {
                  Event event = state.eventsModel.events[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(event.text),
                  );
                },
              ),
            );
          }
          if (state is Error) {
            return Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(state.message),
                  SizedBox(height: 10),
                  LottieBuilder.asset(
                    'assets/animations/lottie/error.json',
                    // width: MediaQuery.of(context).size.width * 0.35,
                    repeat: true,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff3c3395),
                        // minimumSize: Size(
                        //   MediaQuery.of(context).size.width * .3,
                        //   MediaQuery.of(context).size.height * .06,
                        // ),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                        ),
                      ),
                      onPressed: () async {
                        BlocProvider.of<TodayInHistoryBloc>(context)
                            .add(Retry());
                      },
                      child: Text("Try again")),
                ],
              ),
            );
          }
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

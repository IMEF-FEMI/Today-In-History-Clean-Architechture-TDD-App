import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:today_in_history/features/today_in_history/presentation/date_selector_bloc/date_selector_bloc.dart';

class DateInfoView extends StatefulWidget {
  @override
  _DateInfoViewState createState() => _DateInfoViewState();
}

class _DateInfoViewState extends State<DateInfoView> {
  DateSelectorBloc dateSelectorBloc;
  @override
  void initState() {
    super.initState();
    dateSelectorBloc = BlocProvider.of<DateSelectorBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    dateSelectorBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat("MMMM dd")
                    .format(dateSelectorBloc.state.selectedDate),
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Color(0xffb0afad),
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Date",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
                minimumSize: Size(
                  MediaQuery.of(context).size.width * .3,
                  MediaQuery.of(context).size.height * .06,
                ),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15.0),
                ),
              ),
              onPressed: () {},
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Select Date")
                ],
              )),
        ],
      ),
    );
  }
}

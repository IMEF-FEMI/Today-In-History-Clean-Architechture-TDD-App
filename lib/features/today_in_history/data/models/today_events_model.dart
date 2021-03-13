import 'package:flutter/foundation.dart';
import 'package:today_in_history/features/today_in_history/domain/entities/today_events.dart';

class TodayEventsModel extends TodayEvents {
  TodayEventsModel({
    @required String date,
    @required String url,
    @required List<Event> events,
  }) : super(
          date: date,
          events: events,
          url: url,
        );

  factory TodayEventsModel.fromJson(Map json) {
    return TodayEventsModel(
      date: json['date'],
      url: json['url'],
      events:
          json['data']['events'].map((event) => Event.fromJson(event)).toList(),
    );
  }
  factory TodayEventsModel.fromLocalJson(Map json) {
    return TodayEventsModel(
      date: json['date'],
      url: json['url'],
      events: json['events'].map((event) => Event.fromLocalJson(json)).toList(),
    );
  }
  
  Map toJson() => {
        "date": date,
        "url": url,
        "events": events.map((event) => event.toJson()).toList(),
      };
}

import 'package:equatable/equatable.dart';

class TodayEvents extends Equatable {
  final String date;
  final String url;
  final List events;

  TodayEvents({this.date, this.url, this.events});

  @override
  List<Object> get props => [date,url,events];
}

class Event {
  String year;
  String text;
  String link;

  Event({
    this.year,
    this.text,
    this.link,
  });

  Event.fromJson(Map json) {
    year = json['year'];
    text = json['text'];
    link = json['links'][0]['link'];
  }

  Event.fromLocalJson(Map json) {
    year = json['year'];
    text = json['text'];
    link = json['link'];
  }

  Map toJson() {
    return {
      'year': year,
      'text': text,
      'link': link,
    };
  }
}

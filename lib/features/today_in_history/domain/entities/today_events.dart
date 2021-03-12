class TodayEvents {
  final String date;
  final String url;
  final List<Event> events;

  TodayEvents({this.date, this.url, this.events});
}

class Event {
  final String year;
  final String text;
  final String url;

  Event({
    this.year,
    this.text,
    this.url,
  });
}

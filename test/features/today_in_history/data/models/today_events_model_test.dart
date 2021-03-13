import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:today_in_history/features/today_in_history/data/models/today_events_model.dart';
import 'package:today_in_history/features/today_in_history/domain/entities/today_events.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tEventsForDay = TodayEventsModel(
    date: "February 14",
    url: "https://wikipedia.org/wiki/February_14",
    events: <Event>[
      Event(
        link: "https://wikipedia.org/wiki/Kaysanites_Shia#History",
        text:
            "Abbasid Revolution: The Hashimi rebels under Abu Muslim Khorasani take Merv, capital of the Umayyad province Khorasan, marking the consolidation of the Abbasid revolt.",
        year: "748",
      ),
      Event(
        link: "https://wikipedia.org/wiki/Charles_the_Bald",
        text:
            "Charles the Bald and Louis the German swear the Oaths of Strasbourg in the French and German languages.",
        year: "842",
      ),
    ],
  );

  group('fromJson  - toJson', () {
    test('Should ensure the model parses the data returned from api correctly',
        () async {
      // act
      final result =
          TodayEventsModel.fromJson(json.decode(fixture("event.json")));

      // assert
      expect(result.toJson(), tEventsForDay.toJson());
    });

    test('Should ensure the model saves and retrieve in the same pattern',
        () async {
          
        // act
      final result1 =
          TodayEventsModel.fromJson(json.decode(fixture("event.json")))
              .toJson();

      final result2 = tEventsForDay.toJson();
        // assert
      expect(TodayEventsModel.fromLocalJson(result1).toJson(), TodayEventsModel.fromLocalJson(result2).toJson());

    });
  });
}

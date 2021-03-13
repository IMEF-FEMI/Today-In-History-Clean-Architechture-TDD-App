import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:today_in_history/features/today_in_history/data/datasources/tih_local_data_source.dart';
import 'package:today_in_history/features/today_in_history/data/models/today_events_model.dart';
import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  MockSharedPreferences mockSharedPreferences;
  TIHLocalDataSourceImpl dataSource;

  setUpAll(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource =
        TIHLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group("get last chached event", () {
    final tEventsModel = TodayEventsModel.fromLocalJson(
        json.decode(fixture('event_cached.json')));

    test(
        'Should return a TodayEventModel from local storage if there is one in the cache',
        () async {
      // arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture('event_cached.json'));
      // act
      final result = await dataSource.getLastTIHEvent();
      // assert
      verify(mockSharedPreferences.getString(CACHED_EVENTS));
      expect(result, equals(result));
    });
  });

  group('cache TIHEvent', () {
    final tEventsModel =
        TodayEventsModel.fromJson(json.decode(fixture('event.json')));

    test('Should call shared preferences to cache event', () async {
      // act
      dataSource.cacheTIHEvents(tEventsModel);

      // assert
      final expectedJsonString = json.encode(tEventsModel.toJson());
      verify(
          mockSharedPreferences.setString(CACHED_EVENTS, expectedJsonString));
    });
  });
}

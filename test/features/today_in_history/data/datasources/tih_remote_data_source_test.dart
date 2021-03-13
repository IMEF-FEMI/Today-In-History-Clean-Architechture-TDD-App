import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:today_in_history/core/error/exceptions.dart';
import 'package:today_in_history/features/today_in_history/data/datasources/tih_remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:today_in_history/features/today_in_history/data/models/today_events_model.dart';
import 'package:matcher/matcher.dart' as Matcher;
import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  TIHRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TIHRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture("event.json"), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('something went wrong', 404));
  }

  group('get Today in history for specific date', () {
    final tDay = 14;
    final tMonth = 2;
    final tTodayEventsModel =
        TodayEventsModel.fromJson(json.decode(fixture("event.json")));
    test('''Should perform a GET request on a URL with month/day being
    the endpoint query parameter with application/json header''', () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      dataSource.getEventsForDate(tMonth, tDay);

      // assert

      verify(
        mockHttpClient.get(
          Uri.parse('http://history.muffinlabs.com/date/$tMonth/$tDay'),
          headers: {'Content-Type': 'application/json'},
        ),
      );

    });
      test('Should return a TodayEventModel object when the response is 200',
          () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSource.getEventsForDate(tMonth, tDay);

        // assert
        expect(result., equals(tTodayEventsModel));
      });

      test('Should throw ServerException when the response is not 200',
          () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getEventsForDate;

        // assert
        expect(() => call(tMonth, tDay),
            throwsA(Matcher.TypeMatcher<ServerException>()));
      });
    
  });

  group('get Today in history for today', () {
    final tTodayEventsModel =
        TodayEventsModel.fromJson(json.decode(fixture("event.json")));
    test('''Should perform a GET request on a URL with month/day being
    the endpoint query parameter with application/json header''', () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      dataSource.getEventsForToday();

      // assert

      verify(
        mockHttpClient.get(
          Uri.parse('http://history.muffinlabs.com/date'),
          headers: {'Content-Type': 'application/json'},
        ),
      );

     });

       test('Should return a TodayEventModel object when the response is 200',
          () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = dataSource.getEventsForToday();

        // assert
        expect(result, equals(tTodayEventsModel));
      });

      test('Should throw ServerException when the response is not 200',
          () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getEventsForToday;

        // assert
        expect(() => call(), throwsA(Matcher.TypeMatcher<ServerException>()));
      });
   
  });
}

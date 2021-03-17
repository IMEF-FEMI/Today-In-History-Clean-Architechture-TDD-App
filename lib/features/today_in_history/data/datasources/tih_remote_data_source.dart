import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:today_in_history/core/error/exceptions.dart';
import 'package:today_in_history/features/today_in_history/data/models/today_events_model.dart';
import 'package:today_in_history/features/today_in_history/domain/entities/today_events.dart';
import 'package:http/http.dart' as http;
import 'datasources.dart';

class TIHRemoteDataSourceImpl extends TIHRemoteDataSource {
  final http.Client client;

  TIHRemoteDataSourceImpl({@required this.client});

  @override
  Future<TodayEvents> getEventsForDate(int month, int day) =>
      _getTodayInHistoryFromUrl(
          'https://history.muffinlabs.com/date/$month/$day');

  @override
  Future<TodayEvents> getEventsForToday() =>
      _getTodayInHistoryFromUrl('https://history.muffinlabs.com/date');

  Future<TodayEvents> _getTodayInHistoryFromUrl(String url) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return TodayEventsModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}

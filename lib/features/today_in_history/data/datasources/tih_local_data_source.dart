import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:today_in_history/core/error/exceptions.dart';
import 'package:today_in_history/features/today_in_history/data/models/today_events_model.dart';

import 'datasources.dart';

const CACHED_EVENTS = "CACHED_EVENTS";

class TIHLocalDataSourceImpl implements TIHLocalDataSource {
  final SharedPreferences sharedPreferences;

  TIHLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future cacheTIHEvents(TodayEventsModel eventsToCache) {
    return sharedPreferences.setString(
        CACHED_EVENTS, json.encode(eventsToCache.toJson()));
  }

  @override
  Future<TodayEventsModel> getLastTIHEvent() {
    final jsonString = sharedPreferences.getString(CACHED_EVENTS);

    if (jsonString != null) {
      return Future.value(TodayEventsModel.fromLocalJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }


  
}

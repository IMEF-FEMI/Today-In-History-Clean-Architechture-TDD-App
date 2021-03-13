import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:today_in_history/core/error/exceptions.dart';
import 'package:today_in_history/core/error/failures.dart';
import 'package:today_in_history/core/network/network_info.dart';
import 'package:today_in_history/features/today_in_history/data/datasources/datasources.dart';
import 'package:today_in_history/features/today_in_history/domain/entities/today_events.dart';
import 'package:today_in_history/features/today_in_history/domain/repositories/today_in_history_repository.dart';

typedef Future<TodayEvents> _TodayOrSpecificDay();

class TodayInHistoryRepositoryImpl implements TodayInHistoryRepository {
  final TIHRemoteDataSource remoteDataSource;
  final TIHLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  TodayInHistoryRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, TodayEvents>> getEventsForDate(int month, int day) {
    return  _getEvents(() {
      return remoteDataSource.getEventsForDate(month, day);
    });
  }

  @override
  Future<Either<Failure, TodayEvents>> getEventsForToday() async {
    return await _getEvents(() {
      return remoteDataSource.getEventsForToday();
    });
  }

  Future<Either<Failure, TodayEvents>> _getEvents(
      _TodayOrSpecificDay todayOrSpecificDay) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteEvent = await todayOrSpecificDay();
        return Right(remoteEvent);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localEvent = await localDataSource.getLastTIHEvent();
        return Right(localEvent);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:today_in_history/core/error/exceptions.dart';
import 'package:today_in_history/core/error/failures.dart';
import 'package:today_in_history/core/network/network_info.dart';
import 'package:today_in_history/features/today_in_history/data/datasources/tih_local_data_source.dart';
import 'package:today_in_history/features/today_in_history/data/datasources/tih_remote_data_source.dart';
import 'package:today_in_history/features/today_in_history/data/models/today_events_model.dart';
import 'package:today_in_history/features/today_in_history/data/repositories/today_in_history_repository_impl.dart';
import 'package:today_in_history/features/today_in_history/domain/entities/today_events.dart';
import 'package:today_in_history/features/today_in_history/domain/repositories/today_in_history_repository.dart';

class MockRemoteDataSource extends Mock implements TIHRemoteDataSourceImpl {}

class MockLocalDataSource extends Mock implements TIHLocalDataSourceImpl {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  TodayInHistoryRepository repository;
  MockLocalDataSource mockLocalDataSource;
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;
  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    mockRemoteDataSource = MockRemoteDataSource();
     mockNetworkInfo = MockNetworkInfo();
    repository = TodayInHistoryRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('get event for specific days', () {
    final tDay = 14;
    final tMonth = 2;
    final tTodayEventsModel = TodayEventsModel(
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
    final TodayEvents tTodayEvents = tTodayEventsModel;


      test(
        'should check if the device is online',
        () async {
          // arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          // act
           repository.getEventsForDate(tMonth, tDay);
          // assert
          verify(mockNetworkInfo.isConnected);
        },
      );

      runTestOnline(() {
        test(
            'should return remote data when the call to remote data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getEventsForDate(tMonth, tDay))
              .thenAnswer((_) async => tTodayEventsModel);
          // act
          final result = await repository.getEventsForDate(tMonth, tDay);

          // assert

          verify(mockRemoteDataSource.getEventsForDate(tMonth, tDay));
          expect(result, equals(Right(tTodayEvents)));
        });

        test(
            'should cache the data locally when the call to remote data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getEventsForDate(tMonth, tDay))
              .thenAnswer((_) async => tTodayEventsModel);
          // act
          await repository.getEventsForDate(tMonth, tDay);

          // assert
          verify(mockRemoteDataSource.getEventsForDate(tMonth, tDay));
          verify(mockLocalDataSource.cacheTIHEvents(tTodayEvents));
        });

        test(
            'should return server failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getEventsForDate(any, any))
              .thenThrow(ServerException());
          // act

          final result = await repository.getEventsForDate(tMonth, tDay);

          // assert
          verify(mockRemoteDataSource.getEventsForDate(tMonth, tDay));
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        });
      });

      runTestOffline(() {
        test(
            'should return last locally chached data, when the cached data is present',
            () async {
          // arrange
          when(mockLocalDataSource.getLastTIHEvent())
              .thenAnswer((_) async => tTodayEventsModel);
          // act
          final result = await repository.getEventsForDate(tMonth, tDay);
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastTIHEvent());
          expect(result, equals(Right(tTodayEvents)));
        });

         test('should return ChacheFailure when there is no chached data present',
          () async {
        // arrange
        when(mockLocalDataSource.getLastTIHEvent()).thenThrow(CacheException());

        // act
        final result = await repository.getEventsForDate(tMonth, tDay);

        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastTIHEvent());
        expect(result, equals(Left(CacheFailure())));
      });
    
      });

     
  });

  group('get event for today', () {
    final tTodayEventsModel = TodayEventsModel(
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
    final TodayEvents tTodayEvents = tTodayEventsModel;

    test('should check if device is online', () async {
      runTestOnline(() async {
        await repository.getEventsForToday();
        //  verify that isConnected is actually called
        verify(await mockNetworkInfo.isConnected);
      });

      runTestOnline(() {
        test(
            'should return remote data when the call to remote data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getEventsForToday())
              .thenAnswer((_) async => tTodayEventsModel);
          // act
          final result = await repository.getEventsForToday();

          // assert
          verify(mockRemoteDataSource.getEventsForToday());
          expect(result, equals(Right(tTodayEvents)));
        });

        test(
            'should cache the data locally when the call to remote data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getEventsForToday())
              .thenAnswer((_) async => tTodayEventsModel);
          // act
          await repository.getEventsForToday();

          // assert
          verify(mockRemoteDataSource.getEventsForToday());
          verify(mockLocalDataSource.cacheTIHEvents(tTodayEvents));
        });

        test(
            'should return server failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getEventsForToday())
              .thenThrow(ServerException());
          // act

          final result = await repository.getEventsForToday();

          // assert
          verify(mockRemoteDataSource.getEventsForToday());
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        });
      });

      runTestOffline(() {
        test(
            'should return last locally chached data, when the cached data is present',
            () async {
          // arrange
          when(mockLocalDataSource.getLastTIHEvent())
              .thenAnswer((_) async => tTodayEventsModel);
          // act
          final result = await repository.getEventsForToday();
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastTIHEvent());
          expect(result, equals(Right(tTodayEvents)));
        });
      });

      test('should return ChacheFailure when there is no chached data present',
          () async {
        // arrange
        when(mockLocalDataSource.getLastTIHEvent()).thenThrow(CacheException());

        // act
        final result = await repository.getEventsForToday();

        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastTIHEvent());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
}

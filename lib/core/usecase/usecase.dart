
import 'package:dartz/dartz.dart';
import 'package:today_in_history/core/error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams  {}

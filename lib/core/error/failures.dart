abstract class Failure{}

class ServerFailure extends Failure {
  String t
}

class CacheFailure extends Failure {}

abstract class Failure{}

class ServerFailure extends Failure {
  @override
    String toString()=>"Server Fail"
}

class CacheFailure extends Failure {}

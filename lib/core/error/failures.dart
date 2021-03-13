abstract class Failure{}

class ServerFailure extends Failure {
  @override
    String toString() {
      // TODO: implement toString
      return super.toString();
    }
}

class CacheFailure extends Failure {}

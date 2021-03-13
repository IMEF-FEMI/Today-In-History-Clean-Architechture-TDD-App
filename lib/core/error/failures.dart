abstract class Failure {}

class ServerFailure extends Failure {
  @override
  String toString() => "Server Failure";
}

class CacheFailure extends Failure {
    @override
  String toString() => "Server Failure";
}

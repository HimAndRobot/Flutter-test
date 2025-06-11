
abstract class Failure {}

class ServerFailure extends Failure {}
class NetworkFailure extends Failure {}

class InvalidFormatFailure extends Failure {}

abstract class ICpfVerificationRepository {
  Future<bool> verifyExists(String cpf);
}

import '../repositories/cpf_verification_repository.dart';
import '../validators/cpf_validator.dart';

class VerifyCpfExistsUsecase {
  final ICpfVerificationRepository repository;

  VerifyCpfExistsUsecase(this.repository);

  Future<bool> call(String cpf) async {
    try {
      if (CPFValidator.validate(cpf) != null) {
        return false;
      }

      final result = await repository.verifyExists(cpf);
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }
}
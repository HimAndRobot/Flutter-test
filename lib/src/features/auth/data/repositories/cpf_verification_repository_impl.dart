import '../../domain/repositories/cpf_verification_repository.dart'; 
import '../services/cpf_verification_service.dart'; 

abstract class Failure {}
class ServerFailure extends Failure {}
class NetworkFailure extends Failure {}


class CpfVerificationRepositoryImpl implements ICpfVerificationRepository {
  final ICpfVerificationService service;

  CpfVerificationRepositoryImpl(this.service);

  @override
  Future<bool> verifyExists(String cpf) async {
    try {
      final dto = await service.checkCpf(cpf);
      return dto.inUse;
      
    } catch (e) {
      throw Exception(e);
    }
  }
}
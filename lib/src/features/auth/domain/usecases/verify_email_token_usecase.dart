import 'package:fortunity_app/src/features/auth/domain/repositories/email_verification_repository.dart';
import '../../data/models/email_token_verificaiton_dto.dart';
class VerifyEmailTokenUsecase {
  final IEmailVerificationRepository emailVerificationRepository;

  VerifyEmailTokenUsecase(this.emailVerificationRepository);

  Future<EmailTokenVerificationDto> call(String email, String token) async {
    return await emailVerificationRepository.verifyEmailToken(email, token);
  }
}
import 'package:fortunity_app/src/features/auth/domain/repositories/email_verification_repository.dart';
import 'package:fortunity_app/src/features/auth/domain/validators/email_validator.dart';

class SendEmailTokenUsecase {
  final IEmailVerificationRepository emailVerificationRepository;

  SendEmailTokenUsecase(this.emailVerificationRepository);

  Future<void> call(String email) async {

    final error = EmailValidator.validate(email);
    if (error != null) {
      throw Exception(error);
    }

    await emailVerificationRepository.sendEmailToken(email);
  }
}
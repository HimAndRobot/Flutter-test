import 'package:fortunity_app/src/features/auth/domain/repositories/email_verification_repository.dart';
import 'package:fortunity_app/src/features/auth/data/services/email_verication_service.dart';
import '../../data/models/email_send_dto.dart';
import '../../data/models/email_token_verificaiton_dto.dart';

class EmailVerificationRepositoryImpl implements IEmailVerificationRepository {
  final EmailVerificationService _emailVerificationService;

  EmailVerificationRepositoryImpl(this._emailVerificationService); 

  @override
  Future<EmailSendDto> sendEmailToken(String email) async {
    final dto = await _emailVerificationService.sendEmailToken(email);
    print(dto.code);

    if (dto.code.isEmpty) {
      throw Exception('Falha ao enviar email de verificação');
    }

    return dto;
  }

  @override
  Future<EmailTokenVerificationDto> verifyEmailToken(String email, String token) async {
    final dto = await _emailVerificationService.verifyEmailToken(email, token);
    return dto;
  }
  
}
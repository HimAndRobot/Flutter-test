import '../../data/models/email_send_dto.dart';
import '../../data/models/email_token_verificaiton_dto.dart';

abstract class IEmailVerificationRepository {
  Future<EmailSendDto> sendEmailToken(String email);
  Future<EmailTokenVerificationDto> verifyEmailToken(String email, String token);
}
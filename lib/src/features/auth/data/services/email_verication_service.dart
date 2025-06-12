
import 'package:dio/dio.dart';
import '../models/email_send_dto.dart';
import '../models/email_token_verificaiton_dto.dart';

class EmailVerificationService  {
  final Dio _dio;

  EmailVerificationService(this._dio);

  Future<EmailSendDto> sendEmailToken(String email) async {
    const String apiUrl = 'https://api.fortunity.dev/auth/email-verification/send';

    try {
      final response = await _dio.post(apiUrl, data: {'email': email}, options: Options(
        headers: {
          'X-Encrypted-Content': 'true',
          'encryptedDev': 'true',
        },
      ));
      if (response.statusCode == 200) {
        return EmailSendDto.fromJson(response.data);
      } else {
        throw Exception('Falha ao enviar email de verificação');
      }
    } on DioException catch (e) {
      throw Exception('Erro ao conectar com o servidor');
    }
  }

  Future<EmailTokenVerificationDto> verifyEmailToken(String email, String token) async {
    const String apiUrl = 'https://api.fortunity.dev/auth/email-verification/verify';

    try {
      final response = await _dio.post(apiUrl, data: {'email': email, 'code': token}, options: Options(
        headers: {
          'X-Encrypted-Content': 'true',
          'encryptedDev': 'true',
        },
      ));
      if (response.statusCode == 200) {
        print(response.data);
        return EmailTokenVerificationDto.fromJson(response.data);
      } else {
        throw Exception('Falha ao verificar email de verificação');
      }
    } on DioException catch (e) {
      throw Exception('Erro ao conectar com o servidor');
    }
  }
}
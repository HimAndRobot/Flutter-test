import 'package:dio/dio.dart';
import '../models/cpf_verification_dto.dart'; 

abstract class ICpfVerificationService {
  Future<CpfVerificationDto> checkCpf(String cpf);
}

class CpfVerificationServiceImpl implements ICpfVerificationService {
  final Dio _dio;

  CpfVerificationServiceImpl(this._dio);

  @override
  Future<CpfVerificationDto> checkCpf(String cpf) async {
    const String apiUrl = 'https://api.fortunity.dev/auth/helpers/in-use/cpf';
    try {
      final response = await _dio.post(
        apiUrl,
        data: {'cpf': cpf},
        options: Options(
          headers: {
            'X-Encrypted-Content': 'true',
            'encryptedDev': 'true',
          },
        ),
      );
      if (response.statusCode == 200) {
        return CpfVerificationDto.fromJson(response.data);
      } else {
        throw Exception('Falha ao verificar CPF: Status ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Erro ao conectar com o servidor');
    }
  }
}
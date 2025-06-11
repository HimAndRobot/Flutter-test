import 'package:flutter/material.dart';
import 'step_handler.dart';

class TokenStepHandler implements StepHandler {
  final GlobalKey<FormState> formKey;
  final Map<String, dynamic> formData;
  
  TokenStepHandler(this.formKey, this.formData);

  @override
  bool validate() {
    return formKey.currentState?.validate() ?? false;
  }

  @override
  Future<bool> process() async {
    // 1. Valida o form
    if (!validate()) {
      return false;
    }

    // 2. Salva os dados (chama onSaved)
    formKey.currentState!.save();

    // 3. Agora formData['token'] está atualizado! Pega o valor
    final token = formData['token'] as String?;
    print('TokenStepHandler: token para API: $token');

    // 4. Chama API para validar token
    try {
      // Simula chamada da API
      await Future.delayed(const Duration(seconds: 1));
      
      // Aqui você chamaria seu repository/service
      // final success = await tokenRepository.validateToken(token);
      
      // Por enquanto, simula sucesso se token tem 6 dígitos
      if (token != null && token.length == 6) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // Log do erro se necessário
      debugPrint('Erro ao validar token: $e');
      return false;
    }
  }

  @override
  void reset() {
    // Limpa o form se necessário
    formKey.currentState?.reset();
  }
} 
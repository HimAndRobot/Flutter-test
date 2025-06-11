import 'package:flutter/material.dart';

/// Interface base para gerenciar steps do formulário de registro
abstract class StepHandler {
  /// Processa o step atual: valida + salva + chama API
  /// Retorna true se sucesso, false se erro
  Future<bool> process();
  
  /// Valida apenas o form (sem chamar API)
  /// Retorna true se válido, false se inválido
  bool validate();
  
  /// Limpa erros e reseta estado
  void reset();
} 
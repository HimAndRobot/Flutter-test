import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/register_user_state.dart';
import '../providers/form_providers.dart';

class RegisterUserNotifier extends StateNotifier<RegisterUserState> {
  RegisterUserNotifier(this._ref) : super(const RegisterUserState());

  final Ref _ref;

  /// Atualiza um campo específico do formulário
  void updateFormField({
    String? email,
    String? token,
    String? phone,
    String? phoneToken,
    String? name,
    String? rg,
    String? password,
  }) {
    state = state.copyWith(
      email: email,
      token: token,
      phone: phone,
      phoneToken: phoneToken,
      name: name,
      rg: rg,
      password: password,
      errorMessage: null, // Limpa erros ao atualizar dados
    );
  }

  /// Processa o próximo step
  Future<void> processNextStep() async {
    print('🚀 ProcessNextStep iniciado - Step atual: ${state.currentStep}');
    
    // Limpa mensagens de erro
    state = state.copyWith(errorMessage: null);
    print(state.errorMessage);

    // Valida o step atual
    if (!_validateCurrentStep()) {
      return;
    }

    // Salva os dados do formulário atual
    _saveCurrentStepData();

    // Processa lógica específica do step
    final success = await _processCurrentStepLogic();
    
    if (success && !state.isLastStep) {
      state = state.copyWith(
        currentStep: state.currentStep + 1,
        errorMessage: null, 
      );
    } else if (!success) {
      print('Processamento falhou, não avançando');
    } else if (state.isLastStep) {
      print('Último step alcançado');
    }
  }

  /// Volta para o step anterior
  void previousStep() {
    if (!state.isFirstStep) {
      state = state.copyWith(
        currentStep: state.currentStep - 1,
        errorMessage: null,
      );
    }
  }

  /// Valida o formulário do step atual
  bool _validateCurrentStep() {
    final formKey = _getCurrentFormKey();
    
    if (formKey == null) {
      return false;
    }
    
    if (formKey.currentState == null) {
      return true;
    }
    
    final isValid = formKey.currentState!.validate();
    return isValid;
  }

  /// Salva os dados do formulário atual
  void _saveCurrentStepData() {
    final formKey = _getCurrentFormKey();
    if (formKey?.currentState != null) {
      formKey!.currentState!.save();
      print('💾 Dados salvos do formulário');
    } else {
      print('⚠️ Nenhum formulário para salvar no step ${state.currentStep}');
    }
  }

  /// Processa a lógica específica de cada step
  Future<bool> _processCurrentStepLogic() async {
    state = state.copyWith(isLoading: true);
    
    try {
      switch (state.currentStep) {
        case 0: // Email
          return await _processEmailStep();
        case 1: // Token
          return await _processTokenStep();
        case 2: // Phone
          return await _processPhoneStep();
        case 3: // Phone Token
          return await _processPhoneTokenStep();
        case 4: // Name
          return await _processNameStep();
        case 5: // RG
          return await _processRgStep();
        case 6: // Password
          return await _processPasswordStep();
        default:
          return true;
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Erro inesperado. Tente novamente.',
      );
      debugPrint('Erro no processamento: $e');
      return false;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  /// Obtém a FormKey do step atual
  GlobalKey<FormState>? _getCurrentFormKey() {
    switch (state.currentStep) {
      case 0:
        return _ref.read(emailFormProvider);
      case 1:
        return _ref.read(tokenFormProvider);
      case 2:
        return _ref.read(phoneFormProvider);
      case 3:
        return _ref.read(phoneTokenFormProvider);
      case 4:
        return _ref.read(nameFormProvider);
      case 5:
        return _ref.read(rgFormProvider);
      case 6:
        return _ref.read(passwordFormProvider);
      default:
        return null;
    }
  }

  // Métodos para processar cada step específico
  Future<bool> _processEmailStep() async {
    try {
      await _ref.read(sendEmailTokenUsecase).call(state.email);
      return true;
    } catch (e) {
      state = state.copyWith(errorMessage: 'Erro ao enviar email de verificação');
      return false;
    }
  }

  Future<bool> _processTokenStep() async {
    try {
      final dto = await _ref.read(verifyEmailTokenUsecase).call(state.email, state.token);
      state = state.copyWith(emailVerificationToken: dto.token);
      print(state.emailVerificationToken);
      return true;
    } catch (e) {
      state = state.copyWith(errorMessage: 'Token is invalid, please try again');
      return false;
    }
  }

  Future<bool> _processPhoneStep() async {
    // Simula envio do token SMS
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  Future<bool> _processPhoneTokenStep() async {
    // Simula validação do token SMS
    await Future.delayed(const Duration(seconds: 1));
    return state.phoneToken.length == 6;
  }

  Future<bool> _processNameStep() async {
    // Validação simples do nome
    return state.name.trim().isNotEmpty;
  }

  Future<bool> _processRgStep() async {
    // Validação simples do RG
    return state.rg.trim().isNotEmpty;
  }

  Future<bool> _processPasswordStep() async {
    // Aqui faria o cadastro final
    await Future.delayed(const Duration(seconds: 2));
    
    // Simula cadastro completo
    // await authRepository.registerUser(state);
    
    return true;
  }

  /// Reseta o estado para o inicial
  void reset() {
    state = const RegisterUserState();
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

/// Provider do RegisterUserNotifier
final registerUserProvider = StateNotifierProvider<RegisterUserNotifier, RegisterUserState>((ref) {
  return RegisterUserNotifier(ref);
}); 
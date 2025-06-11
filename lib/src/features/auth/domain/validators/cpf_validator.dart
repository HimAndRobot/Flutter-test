class CPFValidator {
  static String? validate(String? cpf) {
    if (cpf == null || cpf.isEmpty) {
      return 'CPF é obrigatório';
    }

    final cleanCpf = cpf.replaceAll(RegExp(r'[^0-9]'), '');

    if (cleanCpf.length != 11) {
      return 'CPF deve ter 11 dígitos';
    }

    // Verifica se todos os dígitos são iguais
    if (_isAllSameDigit(cleanCpf)) {
      return 'CPF inválido';
    }

    // Validação do algoritmo do CPF
    if (!_isValidCPF(cleanCpf)) {
      return 'CPF inválido';
    }

    return null; // CPF válido
  }

  // Verifica se todos os dígitos são iguais (ex: 111.111.111-11)
  static bool _isAllSameDigit(String cpf) {
    return cpf.split('').every((digit) => digit == cpf[0]);
  }

  // Implementa o algoritmo de validação do CPF
  static bool _isValidCPF(String cpf) {
    // Calcula o primeiro dígito verificador
    int sum = 0;
    for (int i = 0; i < 9; i++) {
      sum += int.parse(cpf[i]) * (10 - i);
    }
    int firstDigit = 11 - (sum % 11);
    if (firstDigit >= 10) firstDigit = 0;

    // Calcula o segundo dígito verificador
    sum = 0;
    for (int i = 0; i < 10; i++) {
      sum += int.parse(cpf[i]) * (11 - i);
    }
    int secondDigit = 11 - (sum % 11);
    if (secondDigit >= 10) secondDigit = 0;

    // Verifica se os dígitos calculados conferem com os do CPF
    return int.parse(cpf[9]) == firstDigit && int.parse(cpf[10]) == secondDigit;
  }

  // Método utilitário para formatar CPF (xxx.xxx.xxx-xx)
  static String format(String cpf) {
    final cleanCpf = cpf.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleanCpf.length != 11) return cpf;
    
    return '${cleanCpf.substring(0, 3)}.${cleanCpf.substring(3, 6)}.${cleanCpf.substring(6, 9)}-${cleanCpf.substring(9)}';
  }
} 
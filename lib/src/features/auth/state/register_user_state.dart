class RegisterUserState {
  const RegisterUserState({
    this.currentStep = 0,
    this.isLoading = false,
    this.email = '',
    this.token = '',
    this.phone = '',
    this.phoneToken = '',
    this.name = '',
    this.rg = '',
    this.password = '',
    this.errorMessage,
    this.emailVerificationToken,
  });

  final int currentStep;
  final bool isLoading;
  final String email;
  final String token;
  final String phone;
  final String phoneToken;
  final String name;
  final String rg;
  final String password;
  final String? errorMessage;
  final String? emailVerificationToken;

  /// Total de steps no processo de registro
  static const int totalSteps = 7;

  /// Mensagens para cada step
  List<String> get stepMessages => [
    'E-mail para acesso',
    'Confirme o token enviado para o seu e-mail',
    'Informe o seu telefone',
    'Confirme o token enviado para o seu telefone',
    'Informe o seu nome',
    'Informe o seu RG',
    'Informe a sua senha',
  ];

  /// Mensagem atual baseada no step
  String get currentMessage => stepMessages[currentStep];

  /// Progresso atual (0.0 a 1.0)
  double get progress => (currentStep + 1) / totalSteps;

  /// Se é o último step
  bool get isLastStep => currentStep == totalSteps - 1;

  /// Se é o primeiro step
  bool get isFirstStep => currentStep == 0;

  /// Método copyWith para criar novas instâncias com valores alterados
  RegisterUserState copyWith({
    int? currentStep,
    bool? isLoading,
    String? email,
    String? token,
    String? phone,
    String? phoneToken,
    String? name,
    String? rg,
    String? password,
    String? errorMessage,
    String? emailVerificationToken,
  }) {
    return RegisterUserState(
      currentStep: currentStep ?? this.currentStep,
      isLoading: isLoading ?? this.isLoading,
      email: email ?? this.email,
      token: token ?? this.token,
      phone: phone ?? this.phone,
      phoneToken: phoneToken ?? this.phoneToken,
      name: name ?? this.name,
      rg: rg ?? this.rg,
      password: password ?? this.password,
      errorMessage: errorMessage,
      emailVerificationToken: emailVerificationToken ?? this.emailVerificationToken,
    );
  }
} 
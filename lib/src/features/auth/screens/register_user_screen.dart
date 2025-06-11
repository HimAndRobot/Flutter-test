import 'package:flutter/material.dart';
import 'package:fortunity_app/src/features/auth/widgets/header_percent.dart';
import 'package:fortunity_app/src/features/auth/widgets/regist_user/email_page.dart';
import 'package:fortunity_app/src/features/auth/widgets/regist_user/token_page.dart';
import 'package:fortunity_app/src/features/auth/widgets/regist_user/phone_page.dart';
import 'package:fortunity_app/src/features/auth/widgets/regist_user/phone_token_page.dart';
import 'package:fortunity_app/src/features/auth/widgets/regist_user/name_page.dart';
import 'package:fortunity_app/src/features/auth/widgets/regist_user/rg_page.dart';
import 'package:fortunity_app/src/features/auth/widgets/regist_user/password_page.dart';
import 'package:fortunity_app/src/shared/widgets/custom_button.dart';
import 'package:fortunity_app/src/features/auth/handlers/token_step_handler.dart';
import 'package:fortunity_app/src/features/auth/handlers/step_handler.dart';

class RegisterUserScreen extends StatefulWidget {
  const RegisterUserScreen({super.key});

  @override
  State<RegisterUserScreen> createState() => _RegisterUserScreenState();
}

class _RegisterUserScreenState extends State<RegisterUserScreen> {
  final PageController _pageController = PageController();
  final _tokenKey = GlobalKey<FormState>();

  late final Map<int, StepHandler> _stepHandlers = {
    1: TokenStepHandler(_tokenKey, _formData),
  };

  late final List<Widget> _steps = [
    const EmailPage(),
    TokenPage(formKey: _tokenKey, onTokenSaved: (token) {
      setState(() {
        _formData['token'] = token;
      });
    }),
    const PhonePage(),
    const PhoneTokenPage(),
    const NamePage(),
    const RgPage(),
    const PasswordPage(),
  ];
  
  final Map<String, dynamic> _formData = {
    'token': '',
  };
  int _currentStep = 0;
  bool _isLoading = false;
  final List<String> _messages = [
    'E-mail para acesso',
    'Confirme o token enviado para o seu e-mail',
    'Informe o seu telefone',
    'Confirme o token enviado para o seu telefone',
    'Informe o seu nome',
    'Informe o seu RG',
    'Informe a sua senha',
  ];


  void _nextStep() async {
    if (_currentStep < _steps.length - 1) {
      if (_stepHandlers.containsKey(_currentStep)) {
        final handler = _stepHandlers[_currentStep]!;
        setState(() {
          _isLoading = true;
        });
        final success = await handler.process(); // ← Faz validação + API
        setState(() {
          _isLoading = false;
        });
        if (success) {
          _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
        }
      } else {
        _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
      }
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HeaderPercent(
            title: 'Cadastro de usuário',
            message: _messages[_currentStep],
            percent: (_currentStep + 1) / _steps.length,
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentStep = index;
                });
              },
              itemCount: _steps.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 32),
                  child: _steps[index],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 48, right: 24, bottom: 34),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentStep > 0)
                  TextButton(
                    onPressed: _previousStep,
                    child: const Text('Voltar'),
                  )
                else
                  const SizedBox.shrink(),
                if (_currentStep < _steps.length - 1)
                  CustomButton(
                    isLoading: _isLoading,
                    onPressed: _nextStep,
                    icon: Icons.arrow_forward,
                    text: 'Próximo',
                  )
                else
                  CustomButton(
                    onPressed: () {},
                    text: 'Finalizar',
                    icon: Icons.arrow_forward,
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

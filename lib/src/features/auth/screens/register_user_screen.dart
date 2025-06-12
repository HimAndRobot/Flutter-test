import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fortunity_app/src/features/auth/widgets/header_percent.dart';
import 'package:fortunity_app/src/features/auth/widgets/regist_user/email_page.dart';
import 'package:fortunity_app/src/features/auth/widgets/regist_user/token_page.dart';
import 'package:fortunity_app/src/features/auth/widgets/regist_user/phone_page.dart';
import 'package:fortunity_app/src/features/auth/widgets/regist_user/phone_token_page.dart';
import 'package:fortunity_app/src/features/auth/widgets/regist_user/name_page.dart';
import 'package:fortunity_app/src/features/auth/widgets/regist_user/rg_page.dart';
import 'package:fortunity_app/src/features/auth/widgets/regist_user/password_page.dart';
import 'package:fortunity_app/src/shared/widgets/custom_button.dart';
import 'package:fortunity_app/src/features/auth/notifiers/register_user_notifier.dart';

class RegisterUserScreen extends ConsumerStatefulWidget {
  const RegisterUserScreen({super.key});

  @override
  ConsumerState<RegisterUserScreen> createState() => _RegisterUserScreenState();
}

class _RegisterUserScreenState extends ConsumerState<RegisterUserScreen> {
  final PageController _pageController = PageController();

  final List<Widget> _steps = const [
    EmailPage(),
    TokenPage(),
    PhonePage(),
    PhoneTokenPage(),
    NamePage(),
    RgPage(),
    PasswordPage(),
  ];

  void _nextStep() async {
    print('nextStep');
    await ref.read(registerUserProvider.notifier).processNextStep();
  }

  void _previousStep() {
    ref.read(registerUserProvider.notifier).previousStep();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(registerUserProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_pageController.hasClients && 
          _pageController.page?.round() != state.currentStep) {
        _pageController.animateToPage(
          state.currentStep,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });

    ref.listen(registerUserProvider, (previous, next) {
      if (next.errorMessage != null) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.errorMessage!), backgroundColor: Colors.red, behavior: SnackBarBehavior.floating, duration: const Duration(seconds: 2),),
        );
      }
    });

    return Scaffold(
      body: Column(
        children: [
          HeaderPercent(
            title: 'Cadastro de usuário',
            message: state.currentMessage,
            percent: state.progress,
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _steps.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 32),
                  child: _steps[index],
                );
              },
            ),
          ),
          //  if (state.errorMessage != null)
          //   Container(
          //     margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          //     padding: const EdgeInsets.all(12),
          //     decoration: BoxDecoration(
          //       color: Colors.red.shade50,
          //       borderRadius: BorderRadius.circular(8),
          //       border: Border.all(color: Colors.red.shade200),
          //     ),
          //     child: Row(
          //       children: [
          //         Icon(Icons.error_outline, color: Colors.red.shade600, size: 20),
          //         const SizedBox(width: 8),
          //         Expanded(
          //           child: Text(
          //             state.errorMessage!,
          //             style: TextStyle(color: Colors.red.shade700, fontSize: 14),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          Padding(
            padding: const EdgeInsets.only(left: 48, right: 24, bottom: 34),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (!state.isFirstStep)
                  TextButton(
                    onPressed: state.isLoading ? null : _previousStep,
                    child: const Text('Voltar'),
                  )
                else
                  const SizedBox.shrink(),
                if (!state.isLastStep)
                  CustomButton(
                    isLoading: state.isLoading,
                    onPressed: _nextStep,
                    icon: Icons.arrow_forward,
                    text: 'Próximo',
                  )
                else
                  CustomButton(
                    isLoading: state.isLoading,
                    onPressed: _nextStep,
                    text: 'Finalizar',
                    icon: Icons.check,
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

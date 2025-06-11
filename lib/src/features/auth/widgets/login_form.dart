import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fortunity_app/src/shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_input.dart';
import '../../../shared/widgets/custom_modal.dart';
import '../domain/validators/cpf_validator.dart';
import '../../../core/providers/dependency_providers.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../screens/register_user_screen.dart';


class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String _cpf = '';
  bool _isLoading = false;
  final maskFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  Future<void> _handleSubmit() async {
    _formKey.currentState!.save();
    
    setState(() {
      _isLoading = true;
    });

    try {
      final useCase = ref.read(cpfUseCaseProvider);
      final result = await useCase.call(maskFormatter.getUnmaskedText());
      
      if (mounted) {
        if (result) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text('CPF encontrado!'),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          // Mostra modal para CPF não cadastrado
          _showCreateAccountModal();
        }
      }
      
      print('Resultado para CPF $_cpf: $result');
      
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  String? cpfValidator(String? value) {
    return CPFValidator.validate(value);
  }

  void _showCreateAccountModal() {
    CustomModal.show(
      context,
      title: 'CPF não cadastrado',
      message: 'Toque no botão para criar sua conta na Fortunity',
      primaryButtonText: 'Criar conta',
      icon: const Icon(
        Icons.error_outline,
        color: Colors.black,
        size: 50,
      ),
      onPrimaryPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterUserScreen()));
      },
      onSecondaryPressed: () {
        Navigator.pop(context); // Só fecha modal
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomInput(
              label: 'CPF',
              hint: 'Apenas números',
              keyboardType: TextInputType.number,
              inputFormatters: [maskFormatter],
              validator: (value) => cpfValidator(value ?? ''),
              onSaved: (value) {
                _cpf = value ?? '';
              },
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancelar',
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                  ),
                ),
                CustomButton(
                  text: _isLoading ? 'Verificando...' : 'Verificar',
                  onPressed: () {
                    if (!_isLoading && _formKey.currentState!.validate()) {
                      _handleSubmit();
                    }
                  },
                  isLoading: _isLoading,
                  icon: Icons.search,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

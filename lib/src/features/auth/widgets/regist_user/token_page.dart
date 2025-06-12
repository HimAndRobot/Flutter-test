import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fortunity_app/src/shared/widgets/custom_token.dart';
import '../../providers/form_providers.dart';
import '../../notifiers/register_user_notifier.dart';

class TokenPage extends ConsumerWidget {
  const TokenPage({super.key});

  String? _validateToken(String? value) {
    if (value == null || value.length != 6) {
      return 'The token must be 6 digits';
    }
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = ref.watch(tokenFormProvider);
    
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomToken(
            label: 'Token', 
            onCodeChanged: (code) {
              // Opcional: atualizar em tempo real
              // ref.read(registerUserProvider.notifier).updateFormField(token: code);
            },
            validator: _validateToken,
            onSaved: (newValue) {
              ref.read(registerUserProvider.notifier).updateFormField(
                token: newValue ?? '',
              );
            },
          ),
        ],
      ),
    );
  }
}
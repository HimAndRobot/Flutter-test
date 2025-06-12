import 'package:flutter/material.dart';
import 'package:fortunity_app/src/shared/widgets/custom_input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/form_providers.dart';
import '../../notifiers/register_user_notifier.dart';
import '../../domain/validators/email_validator.dart';

class EmailPage extends ConsumerWidget {
  const EmailPage({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = ref.watch(emailFormProvider);
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomInput(
            label: 'Email', 
            hint: 'Ex: nome@mail.com', 
            onSaved: (value) {
              ref.read(registerUserProvider.notifier).updateFormField(email: value);
            }, 
            validator: EmailValidator.validate,
          ),
        ],
      ),
    );
  }
}
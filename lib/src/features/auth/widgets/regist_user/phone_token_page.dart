import 'package:flutter/material.dart';
import 'package:fortunity_app/src/shared/widgets/custom_input.dart';

class PhoneTokenPage extends StatelessWidget {
  const PhoneTokenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          CustomInput(label: 'Token', hint: 'Digite o token',),
        ],
      ),
    );
  }
}
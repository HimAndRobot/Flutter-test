import 'package:flutter/material.dart';
import 'package:fortunity_app/src/shared/widgets/custom_input.dart';

class NamePage extends StatelessWidget {
  const NamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          CustomInput(label: 'Nome', hint: 'Digite o seu nome',),
        ],
      ),
    );
  }
}
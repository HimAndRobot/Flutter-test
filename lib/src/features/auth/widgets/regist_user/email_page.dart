import 'package:flutter/material.dart';
import 'package:fortunity_app/src/shared/widgets/custom_input.dart';

class EmailPage extends StatelessWidget {
  const EmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          CustomInput(label: 'Email', hint: 'Ex: nome@mail.com',),
        ],
      ),
    );
  }
}
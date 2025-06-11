import 'package:flutter/material.dart';
import 'package:fortunity_app/src/shared/widgets/custom_input.dart';

class RgPage extends StatelessWidget {
  const RgPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          CustomInput(label: 'Número do RG', hint: 'Digite o número do seu RG',),
          Padding(padding:  EdgeInsets.only(top: 32), child: CustomInput(label: 'Orgão emissor', hint: 'Digite o orgão emissor do seu RG',),),
          Padding(padding:  EdgeInsets.only(top: 32), child: CustomInput(label: 'Data de emissão', hint: 'Digite a data de emissão do seu RG',),),
          Padding(padding:  EdgeInsets.only(top: 32), child: CustomInput(label: 'Data de nascimento', hint: 'Digite a data de nascimento do seu RG',),),
          Padding(padding:  EdgeInsets.only(top: 32), child: CustomInput(label: 'UF', hint: 'Digite a UF do seu RG',),),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 24, top: 48),
      color: Colors.black,
      width: double.infinity,
      height: 260,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Verificar CPF',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 24),
                  child: Text('Olá!  Seja bem-vindo', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),)
                ),
                Image(image: AssetImage('assets/images/logoAuth.png'), width: 124, height: 124,),
              ],
            ),
          )

        ],
      ),
    );
  }
} 
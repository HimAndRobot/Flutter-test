import 'package:flutter/material.dart';
import 'package:fortunity_app/src/features/auth/widgets/login_header.dart';
import 'package:fortunity_app/src/features/auth/widgets/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Column(
          children: [
            LoginHeader(),
            Expanded(
              child: LoginForm(),
            ),
          ],
        ),
    );
  }
} 
import 'package:flutter/material.dart';
import 'package:fortunity_app/src/features/auth/screens/login_screen.dart';
import '../widgets/welcome_header.dart';
import '../widgets/language_selector.dart';
import '../widgets/start_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _isLoading = false;

  void _handleStart() {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const WelcomeHeader(),
          const LanguageSelector(),
          Expanded(
            child: StartButton(
              isLoading: _isLoading,
              onPressed: _handleStart,
            ),
          ),
        ],
      ),
    );
  }
} 
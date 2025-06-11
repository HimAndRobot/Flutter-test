import 'package:flutter/material.dart';
import '../../../shared/widgets/custom_button.dart';

class StartButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const StartButton({
    required this.isLoading,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomButton(
            text: 'Começar',
            icon: Icons.arrow_forward,
            isLoading: isLoading,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
} 
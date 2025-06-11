import 'package:flutter/material.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 24, top: 32),
          child: const Row(
            children: [
              Icon(
                Icons.language,
                color: Colors.black,
                size: 24,
              ),
              Padding(
                padding: EdgeInsets.only(left: 12),
                child: Text(
                  'Idioma',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          margin: const EdgeInsets.only(top: 16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFFEEEEEE),
              ),
            ),
            child: DropdownButton<String>(
              value: 'pt',
              isExpanded: true,
              underline: Container(),
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.black,
              ),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              items: const [
                DropdownMenuItem(
                  value: 'pt',
                  child: Text('Portuguese'),
                ),
                DropdownMenuItem(
                  value: 'en',
                  child: Text('English'),
                ),
              ],
              onChanged: (value) {
                print(value);
              },
            ),
          ),
        ),
      ],
    );
  }
} 
import 'package:flutter/material.dart';

class HeaderPercent extends StatelessWidget {
  final String title;
  final String message;
  final double percent;
  const HeaderPercent({super.key, required this.title, required this.message, required this.percent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 24, top: 48, right: 24, bottom: 24),
      color: Colors.black,
      width: double.infinity,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 16),
            height: 8,
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(4),
            ),
            child: AnimatedFractionallySizedBox(
              duration: const Duration(milliseconds: 300),
              alignment: Alignment.centerLeft,
              widthFactor: percent,
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          Text(
            title,
            style: const TextStyle(
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
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Text(message, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),)
                )
              ],
            ),
          )

        ],
      ),
    );
  }
} 
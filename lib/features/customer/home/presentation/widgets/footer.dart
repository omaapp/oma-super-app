import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Icon(
          Icons.local_taxi,
          size: 42,
          color: Colors.blue.shade700,
        ),

        const SizedBox(height: 12),

        const Text(
          "Oma",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),

        const SizedBox(height: 6),

        const Text(
          "Safe • Fast • Smart",
          style: TextStyle(
            color: Colors.grey,
          ),
        ),

        const SizedBox(height: 20),

        Text(
          "Version 1.0.0",
          style: TextStyle(
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }
}
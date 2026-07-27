import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  final String? action;

  final VoidCallback? onPressed;

  const SectionTitle({
    super.key,
    required this.title,
    this.action,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Text(
          title,
          style: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),

        const Spacer(),

        if (action != null)

          TextButton(
            onPressed: onPressed,
            child: Text(action!),
          ),
      ],
    );
  }
}
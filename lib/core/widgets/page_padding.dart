import 'package:flutter/material.dart';

class PagePadding extends StatelessWidget {
  final Widget child;

  const PagePadding({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 14,
      ),
      child: child,
    );
  }
}
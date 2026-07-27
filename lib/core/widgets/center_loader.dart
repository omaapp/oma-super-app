import 'package:flutter/material.dart';

import 'oma_loader.dart';

class CenterLoader extends StatelessWidget {
  const CenterLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: OmaLoader(),
    );
  }
}
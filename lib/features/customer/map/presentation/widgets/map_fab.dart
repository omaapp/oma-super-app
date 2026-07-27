import 'package:flutter/material.dart';

class MapFab extends StatelessWidget {
  final VoidCallback onPressed;

  const MapFab({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: "location",
      backgroundColor: Colors.white,
      onPressed: onPressed,
      child: const Icon(
        Icons.my_location,
        color: Colors.blue,
      ),
    );
  }
}
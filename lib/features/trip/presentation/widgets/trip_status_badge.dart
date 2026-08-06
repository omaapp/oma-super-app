import 'package:flutter/material.dart';

class TripStatusBadge extends StatelessWidget {
  final String status;

  const TripStatusBadge({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color color;
    String text;

    switch (status) {
      case "completed":
        color = Colors.green;
        text = "مكتملة";
        break;

      case "cancelled":
        color = Colors.red;
        text = "ملغاة";
        break;

      case "accepted":
        color = Colors.orange;
        text = "تم قبولها";
        break;

      case "arrived":
        color = Colors.indigo;
        text = "وصل السائق";
        break;

      case "on_trip":
        color = Colors.blue;
        text = "قيد الرحلة";
        break;

      default:
        color = Colors.grey;
        text = "قيد الانتظار";
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .15),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
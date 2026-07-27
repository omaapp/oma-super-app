import 'package:flutter/material.dart';

class EmptyTripHistory extends StatelessWidget {
  const EmptyTripHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [

            Icon(
              Icons.history,
              size: 90,
              color: Colors.grey,
            ),

            SizedBox(height: 25),

            Text(
              "لا توجد رحلات حتى الآن",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(
              "ستظهر جميع رحلاتك هنا بعد أول طلب.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
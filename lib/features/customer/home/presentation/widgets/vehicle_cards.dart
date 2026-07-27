import 'package:flutter/material.dart';

class VehicleCards extends StatelessWidget {
  const VehicleCards({super.key});

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [

        Expanded(
          child: _card(
            "Taxi",
            "assets/images/taxi.png",
            Colors.blue,
          ),
        ),

        const SizedBox(width: 15),

        Expanded(
          child: _card(
            "Tuk Tuk",
            "assets/images/tuktuk.png",
            Colors.orange,
          ),
        ),
      ],
    );
  }

  Widget _card(
    String title,
    String image,
    Color color,
  ) {

    return Container(

      height: 180,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            blurRadius: 15,
            color: Colors.black12,
          ),
        ],
      ),

      child: Column(

        mainAxisAlignment:
            MainAxisAlignment.center,

        children: [

          Image.asset(
            image,
            height: 90,
          ),

          const SizedBox(height: 15),

          Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
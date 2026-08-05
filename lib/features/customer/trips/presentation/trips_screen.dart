import 'package:flutter/material.dart';

class TripsScreen extends StatelessWidget {
  const TripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("رحلاتي"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: const [

          _TripCard(
            from: "الرفاعي",
            to: "الجامعة",
            price: "2500 د.ع",
            status: "مكتملة",
            color: Colors.green,
          ),

          SizedBox(height: 16),

          _TripCard(
            from: "السوق",
            to: "المستشفى",
            price: "1500 د.ع",
            status: "ملغاة",
            color: Colors.red,
          ),

          SizedBox(height: 16),

          _TripCard(
            from: "المنزل",
            to: "العمل",
            price: "2000 د.ع",
            status: "قيد التنفيذ",
            color: Colors.orange,
          ),
        ],
      ),
    );
  }
}

class _TripCard extends StatelessWidget {

  final String from;
  final String to;
  final String price;
  final String status;
  final Color color;

  const _TripCard({
    required this.from,
    required this.to,
    required this.price,
    required this.status,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 12,
            offset: Offset(0,6),
          ),
        ],
      ),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Row(

            children: [

              CircleAvatar(
                backgroundColor:
                    color.withOpacity(.12),
                child: Icon(
                  Icons.local_taxi,
                  color: color,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(

                child: Text(
                  "$from  →  $to",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),

              Container(

                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),

                decoration: BoxDecoration(
                  color: color.withOpacity(.12),
                  borderRadius:
                      BorderRadius.circular(20),
                ),

                child: Text(
                  status,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Text(
            price,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

import 'trip_status_badge.dart';

class TripHistoryCard extends StatelessWidget {
  final String pickup;
  final String destination;
  final String status;
  final String date;
  final String distance;
  final String duration;
  final String price;
  final VoidCallback? onTap;

  const TripHistoryCard({
    super.key,
    required this.pickup,
    required this.destination,
    required this.status,
    required this.date,
    required this.distance,
    required this.duration,
    required this.price,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 10,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [

              Row(
                children: [

                  const CircleAvatar(
                    radius: 24,
                    backgroundColor: Color(0xffE3F2FD),
                    child: Icon(
                      Icons.local_taxi,
                      color: Color(0xff1565C0),
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [

                        Text(
                          pickup,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          destination,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  TripStatusBadge(
                    status: status,
                  ),
                ],
              ),

              const SizedBox(height: 18),

              const Divider(),

              const SizedBox(height: 10),

              Row(
                children: [

                  Expanded(
                    child: _Item(
                      Icons.route,
                      distance,
                    ),
                  ),

                  Expanded(
                    child: _Item(
                      Icons.access_time,
                      duration,
                    ),
                  ),

                  Expanded(
                    child: _Item(
                      Icons.payments,
                      price,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              Row(
                children: [

                  const Icon(
                    Icons.calendar_today,
                    size: 18,
                    color: Colors.grey,
                  ),

                  const SizedBox(width: 8),

                  Expanded(
                    child: Text(
                      date,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),

                  FilledButton.icon(
                    onPressed: onTap,
                    icon: const Icon(Icons.repeat),
                    label: const Text("إعادة الحجز"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {

  final IconData icon;
  final String text;

  const _Item(
    this.icon,
    this.text,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Icon(
          icon,
          color: Colors.blue,
        ),

        const SizedBox(height: 8),

        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
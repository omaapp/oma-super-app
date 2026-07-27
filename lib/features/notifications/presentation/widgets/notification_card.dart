import 'package:flutter/material.dart';

import '../../models/app_notification_model.dart';

class NotificationCard extends StatelessWidget {
  final AppNotificationModel notification;

  final VoidCallback? onTap;

  const NotificationCard({
    super.key,
    required this.notification,
    this.onTap,
  });

  IconData _icon() {
    switch (notification.type) {
      case "trip":
        return Icons.local_taxi;

      case "offer":
        return Icons.local_offer;

      case "wallet":
        return Icons.account_balance_wallet;

      case "warning":
        return Icons.warning_amber_rounded;

      case "driver":
        return Icons.person_pin_circle;

      default:
        return Icons.notifications;
    }
  }

  Color _color() {
    switch (notification.type) {
      case "trip":
        return Colors.blue;

      case "offer":
        return Colors.orange;

      case "wallet":
        return Colors.green;

      case "warning":
        return Colors.red;

      case "driver":
        return Colors.indigo;

      default:
        return Colors.grey;
    }
  }

  String _timeAgo() {
    final now = DateTime.now();

    final date =
        notification.createdAt.toDate();

    final diff =
        now.difference(date);

    if (diff.inMinutes < 1) {
      return "الآن";
    }

    if (diff.inMinutes < 60) {
      return "${diff.inMinutes} دقيقة";
    }

    if (diff.inHours < 24) {
      return "${diff.inHours} ساعة";
    }

    if (diff.inDays < 7) {
      return "${diff.inDays} يوم";
    }

    return "${date.day}/${date.month}/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: notification.isRead ? 1 : 5,
      color: notification.isRead
          ? Colors.white
          : Colors.blue.shade50,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: InkWell(
        borderRadius:
            BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding:
              const EdgeInsets.all(16),
          child: Row(
            children: [

              CircleAvatar(
                radius: 26,
                backgroundColor:
                    _color().withOpacity(.12),
                child: Icon(
                  _icon(),
                  color: _color(),
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    Text(
                      notification.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight:
                            notification.isRead
                                ? FontWeight.w600
                                : FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      notification.body,
                      style:
                          const TextStyle(
                        color: Colors.grey,
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      _timeAgo(),
                      style:
                          TextStyle(
                        fontSize: 12,
                        color:
                            Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),

              if (!notification.isRead)
                Container(
                  width: 12,
                  height: 12,
                  decoration:
                      const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../data/notification_service.dart';
import '../models/app_notification_model.dart';
import 'widgets/notification_card.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text("يجب تسجيل الدخول"),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("الإشعارات"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () async {
              final ok = await showDialog<bool>(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("حذف الكل"),
                  content: const Text(
                    "هل تريد حذف جميع الإشعارات؟",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () =>
                          Navigator.pop(context, false),
                      child: const Text("إلغاء"),
                    ),
                    ElevatedButton(
                      onPressed: () =>
                          Navigator.pop(context, true),
                      child: const Text("حذف"),
                    ),
                  ],
                ),
              );

              if (ok != true) return;

              await NotificationService.instance
                  .clearNotifications(user.uid);
            },
          ),
        ],
      ),

      body: StreamBuilder<List<AppNotificationModel>>(
        stream: NotificationService.instance
            .notifications(user.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final notifications =
              snapshot.data ?? [];

          if (notifications.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_none,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "لا توجد إشعارات",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding:
                const EdgeInsets.only(top: 10),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification =
                  notifications[index];

              return Dismissible(
                key: ValueKey(notification.id),

                direction:
                    DismissDirection.endToStart,

                background: Container(
                  alignment:
                      Alignment.centerRight,
                  padding:
                      const EdgeInsets.only(
                    right: 25,
                  ),
                  color: Colors.red,
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),

                onDismissed: (_) async {
                  await NotificationService
                      .instance
                      .deleteNotification(
                    userId: user.uid,
                    notificationId:
                        notification.id,
                  );
                },

                child: NotificationCard(
                  notification: notification,

                  onTap: () async {
                    if (!notification.isRead) {
                      await NotificationService
                          .instance
                          .markAsRead(
                        userId: user.uid,
                        notificationId:
                            notification.id,
                      );
                    }

                    /// لاحقاً سنفتح شاشة الرحلة
                    /// إذا كان notification.tripId != null
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../auth/presentation/login_screen.dart';
import '../../trip/presentation/trip_history_screen.dart';

import 'saved_addresses_screen.dart';
import 'help_center_screen.dart';
import 'privacy_policy_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: AppBar(
  elevation: 0,
  backgroundColor: Colors.transparent,
  foregroundColor: theme.colorScheme.onSurface,
  centerTitle: true,
  title: Text(
    "الحساب",
    style: TextStyle(
      fontWeight: FontWeight.bold,
      color: theme.colorScheme.onSurface,
    ),
  ),
),

      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [

          ///==========================
          /// بطاقة المستخدم
          ///==========================

          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xff1565C0),
                  Color(0xff42A5F5),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(.18),
                  blurRadius: 25,
                  offset: const Offset(0, 10),
                ),
              ],
            ),

            child: Column(
              children: [

                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
  color: theme.cardColor,
  shape: BoxShape.circle,
),
                  child: const Icon(
                    Icons.person,
                    color: Color(0xff1565C0),
                    size: 50,
                  ),
                ),

                const SizedBox(height: 18),

                Text(
                  user?.phoneNumber ?? "مستخدم",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius:
                        BorderRadius.circular(30),
                  ),
                  child: Text(
                    "عميل",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                Row(
                  children: [

                    Expanded(
                      child: _buildStat(
                        Icons.route,
                        "--",
                        "الرحلات",
                      ),
                    ),

                    Expanded(
                      child: _buildStat(
                        Icons.star,
                        "--",
                        "التقييم",
                      ),
                    ),

                    Expanded(
                      child: _buildStat(
                        Icons.payments,
                        "--",
                        "الإنفاق",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          Text(
  "رحلاتي",
  style: TextStyle(
    fontSize: 19,
    fontWeight: FontWeight.bold,
    color: theme.colorScheme.onSurface,
  ),
),
          const SizedBox(height: 15),
                    Card(
  color: theme.cardColor,
  elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [

                _buildTile(
                  context,
                  icon: Icons.history,
                  color: Colors.blue,
                  title: "سجل الرحلات",
                  subtitle: "عرض جميع الرحلات السابقة",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            TripHistoryScreen(),
                      ),
                    );
                  },
                ),

                Divider(
  height: 1,
  color: Theme.of(context).dividerColor,
),

                _buildTile(
                  context,
                  icon: Icons.home_work_rounded,
                  color: Colors.deepPurple,
                  title: "العناوين المحفوظة",
                  subtitle: "المنزل والعمل وغيرها",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const SavedAddressesScreen(),
                      ),
                    );
                  },
                ),

                Divider(
  height: 1,
  color: Theme.of(context).dividerColor,
),

                _buildTile(
                  context,
                  icon: Icons.discount_rounded,
                  color: Colors.orange,
                  title: "الكوبونات",
                  subtitle: "العروض والخصومات",
                  onTap: () {},
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          Text(
  "الإشعارات",
  style: TextStyle(
    fontSize: 19,
    fontWeight: FontWeight.bold,
    color: theme.colorScheme.onSurface,
  ),
),

          const SizedBox(height: 15),

          Card(
  color: theme.cardColor,
  elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: _buildTile(
              context,
              icon: Icons.notifications_active_rounded,
              color: Colors.red,
              title: "الإشعارات",
              subtitle: "جميع تنبيهات التطبيق",
              onTap: () {
                // سيتم ربط صفحة الإشعارات لاحقاً
              },
            ),
          ),

          const SizedBox(height: 28),

          Text(
  "الدعم",
  style: TextStyle(
    fontSize: 19,
    fontWeight: FontWeight.bold,
    color: theme.colorScheme.onSurface,
  ),
),

          const SizedBox(height: 15),
                    Card(
  color: theme.cardColor,
  elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [

                _buildTile(
                  context,
                  icon: Icons.help_center_rounded,
                  color: Colors.blue,
                  title: "مركز المساعدة",
                  subtitle: "الأسئلة الشائعة والدعم",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const HelpCenterScreen(),
                      ),
                    );
                  },
                ),

                Divider(
  height: 1,
  color: Theme.of(context).dividerColor,
),

                _buildTile(
                  context,
                  icon: Icons.privacy_tip_rounded,
                  color: Colors.green,
                  title: "سياسة الخصوصية",
                  subtitle: "كيف نحافظ على بياناتك",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const PrivacyPolicyScreen(),
                      ),
                    );
                  },
                ),

                Divider(
  height: 1,
  color: Theme.of(context).dividerColor,
),

                _buildTile(
                  context,
                  icon: Icons.description_rounded,
                  color: Colors.orange,
                  title: "الشروط والأحكام",
                  subtitle: "شروط استخدام التطبيق",
                  onTap: () {},
                ),

                Divider(
  height: 1,
  color: Theme.of(context).dividerColor,
),

                _buildTile(
                  context,
                  icon: Icons.info_rounded,
                  color: Colors.indigo,
                  title: "حول التطبيق",
                  subtitle: "الإصدار 1.0.0",
                  onTap: () {},
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          Container(
  decoration: BoxDecoration(
    color: theme.cardColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 12,
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 8,
              ),

              leading: Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.logout_rounded,
                  color: Colors.red,
                ),
              ),

              title: Text(
                "تسجيل الخروج",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),

              subtitle: const Text(
                "تسجيل الخروج من الحساب الحالي",
              ),

              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18,
              ),

              onTap: () async {

                final logout =
                    await showDialog<bool>(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("تسجيل الخروج"),
                    content: Text(
                      "هل تريد تسجيل الخروج؟",
                    ),
                    actions: [

                      TextButton(
                        onPressed: () =>
                            Navigator.pop(
                          context,
                          false,
                        ),
                        child: Text(
  "إلغاء",
  style: TextStyle(
    color: Theme.of(context).colorScheme.primary,
  ),
),
                      ),

                      ElevatedButton(
                        onPressed: () =>
                            Navigator.pop(
                          context,
                          true,
                        ),
                        child: Text("خروج"),
                      ),
                    ],
                  ),
                );

                if (logout != true) return;

                await FirebaseAuth.instance.signOut();

                if (!context.mounted) return;

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const LoginScreen(),
                  ),
                  (_) => false,
                );
              },
            ),
          ),

          const SizedBox(height: 35),

          Center(
            child: Column(
              children: [

                Icon(
  Icons.local_taxi,
  color: theme.colorScheme.primary,
  size: 34,
),

                const SizedBox(height: 12),

                Text(
  "OMA",
  style: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: theme.colorScheme.onSurface,
  ),
),
                const SizedBox(height: 6),

                Text(
                  "Version 1.0.0",
                  style: TextStyle(
                    color: theme.colorScheme.onSurface.withOpacity(.6),
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  "Made with ❤️ in Iraq",
                  style: TextStyle(
                    color: theme.colorScheme.onSurface.withOpacity(.6),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
    Widget _buildTile(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 8,
      ),
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: color.withOpacity(.12),
        child: Icon(
          icon,
          color: color,
        ),
      ),
      title: Text(
  title,
  style: TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Theme.of(context).textTheme.bodyLarge?.color,
  ),
),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(.7),
        ),
      ),
      trailing: Icon(
  Icons.arrow_forward_ios_rounded,
  size: 18,
  color: Theme.of(context).iconTheme.color,
),
      onTap: onTap,
    );
  }

  Widget _buildStat(
    IconData icon,
    String value,
    String title,
  ) {
    return Column(
      children: [

        Icon(
          icon,
          color: Colors.white,
          size: 26,
        ),

        const SizedBox(height: 8),

        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
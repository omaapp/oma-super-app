import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/services/app_settings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_gradients.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/oma_card.dart';
import '../../auth/presentation/login_screen.dart';
import '../../notifications/presentation/notifications_screen.dart';
import '../../trip/presentation/trip_history_screen.dart';
import '../../customer/wallet/presentation/wallet_screen.dart';
import 'help_center_screen.dart';
import 'privacy_policy_screen.dart';
import 'saved_addresses_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return AppScaffold(
      title: 'حسابي',
      body: ListView(padding: const EdgeInsets.all(AppSpacing.md), children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(gradient: AppGradients.primary, borderRadius: BorderRadius.circular(24)),
          child: Column(children: [
            const CircleAvatar(radius: 38, backgroundColor: Colors.white24, child: Icon(Icons.person, color: Colors.white, size: 42)),
            const SizedBox(height: AppSpacing.sm),
            Text(user?.phoneNumber ?? 'مستخدم OMA', style: AppTextStyles.titleMedium.copyWith(color: Colors.white)),
            Text('عميل', style: AppTextStyles.bodyMedium.copyWith(color: Colors.white70)),
          ]),
        ),
        const SizedBox(height: AppSpacing.lg),
        _Section(title: 'الحساب', children: [
          _Item(icon: Icons.person_outline, title: 'المعلومات الشخصية', onTap: () => _editProfile(context)),
          _Item(icon: Icons.edit_outlined, title: 'تعديل الملف الشخصي', onTap: () => _editProfile(context)),
          _Item(icon: Icons.history, title: 'سجل الرحلات', onTap: () => _push(context, const TripHistoryScreen())),
          _Item(icon: Icons.account_balance_wallet_outlined, title: 'المحفظة', onTap: () => _push(context, const WalletScreen())),
          _Item(icon: Icons.home_work_outlined, title: 'العناوين المحفوظة', onTap: () => _push(context, const SavedAddressesScreen())),
        ]),
        _Section(title: 'التفضيلات', children: [
          _Item(icon: Icons.language, title: 'اللغة', onTap: () => _language(context)),
          _ThemeItem(),
          _Item(icon: Icons.notifications_outlined, title: 'الإشعارات', onTap: () => _push(context, const NotificationsScreen())),
        ]),
        _Section(title: 'الدعم', children: [
          _Item(icon: Icons.help_outline, title: 'مركز المساعدة والأسئلة الشائعة', onTap: () => _push(context, const HelpCenterScreen())),
          _Item(icon: Icons.support_agent_outlined, title: 'تواصل معنا', onTap: () => _message(context, 'سيتم فتح قناة الدعم قريباً.')),
        ]),
        _Section(title: 'قانوني', children: [
          _Item(icon: Icons.privacy_tip_outlined, title: 'سياسة الخصوصية', onTap: () => _push(context, const PrivacyPolicyScreen())),
          _Item(icon: Icons.description_outlined, title: 'الشروط والأحكام', onTap: () => _about(context, 'الشروط والأحكام', 'باستخدامك OMA فإنك توافق على استخدام التطبيق بصورة آمنة ومسؤولة.')),
          _Item(icon: Icons.info_outline, title: 'حول OMA', onTap: () => _about(context, 'حول OMA', 'OMA منصة تنقل محلية سريعة وآمنة. الإصدار 1.0.0')),
        ]),
        _Section(title: 'الجلسة', children: [
          _Item(icon: Icons.logout, title: 'تسجيل الخروج', color: AppColors.error, onTap: () async {
            await FirebaseAuth.instance.signOut();
            if (!context.mounted) return;
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const LoginScreen()), (_) => false);
          }),
        ]),
      ]),
    );
  }
  static void _push(BuildContext c, Widget page) => Navigator.of(c).push(MaterialPageRoute(builder: (_) => page));
  static void _message(BuildContext c, String text) => ScaffoldMessenger.of(c).showSnackBar(SnackBar(content: Text(text)));
  static Future<void> _about(BuildContext c, String title, String text) => showDialog<void>(context: c, builder: (_) => AlertDialog(title: Text(title), content: Text(text), actions: [TextButton(onPressed: () => Navigator.pop(c), child: const Text('حسناً'))]));
  static Future<void> _language(BuildContext c) async { final s = c.read<AppSettings>(); final r = await showDialog<String>(context: c, builder: (_) => SimpleDialog(title: const Text('اختر اللغة'), children: [SimpleDialogOption(onPressed: () => Navigator.pop(c, 'ar'), child: const Text('العربية')), SimpleDialogOption(onPressed: () => Navigator.pop(c, 'en'), child: const Text('English'))])); if (r != null) await s.setLanguage(r); }
  static Future<void> _editProfile(BuildContext c) async {
    final controller = TextEditingController();
    final user = FirebaseAuth.instance.currentUser;
    final name = await showDialog<String>(
      context: c,
      builder: (dialogContext) => AlertDialog(
        title: const Text('تعديل الاسم'),
        content: TextField(controller: controller, autofocus: true, decoration: const InputDecoration(labelText: 'الاسم الكامل')),
        actions: [TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('إلغاء')), ElevatedButton(onPressed: () => Navigator.pop(dialogContext, controller.text.trim()), child: const Text('حفظ'))],
      ),
    );
    if (name == null || name.isEmpty || user == null) return;
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({'name': name, 'updatedAt': FieldValue.serverTimestamp()}, SetOptions(merge: true));
    if (c.mounted) _message(c, 'تم تحديث البيانات');
  }
}
class _Section extends StatelessWidget { final String title; final List<Widget> children; const _Section({required this.title, required this.children}); @override Widget build(BuildContext c) => Padding(padding: const EdgeInsets.only(top: AppSpacing.lg), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: AppTextStyles.titleSmall), const SizedBox(height: AppSpacing.sm), OmaCard(padding: EdgeInsets.zero, child: Column(children: children))])); }
class _Item extends StatelessWidget { final IconData icon; final String title; final VoidCallback onTap; final Color? color; const _Item({required this.icon, required this.title, required this.onTap, this.color}); @override Widget build(BuildContext c) { final v = color ?? AppColors.primary; return ListTile(leading: Icon(icon, color: v), title: Text(title), trailing: const Icon(Icons.chevron_right), onTap: onTap); } }
class _ThemeItem extends StatelessWidget { @override Widget build(BuildContext c) { final s = c.watch<AppSettings>(); return SwitchListTile(secondary: const Icon(Icons.dark_mode, color: AppColors.primary), title: const Text('الوضع الليلي'), value: s.themeMode == ThemeMode.dark, onChanged: s.setDarkMode); } }

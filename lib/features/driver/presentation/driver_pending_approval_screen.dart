import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/oma_card.dart';
import '../../../core/widgets/primary_button.dart';
import 'driver_home_screen.dart';

class DriverPendingApprovalScreen extends StatefulWidget {
  const DriverPendingApprovalScreen({super.key});
  @override
  State<DriverPendingApprovalScreen> createState() => _DriverPendingApprovalScreenState();
}

class _DriverPendingApprovalScreenState extends State<DriverPendingApprovalScreen> {
  bool _checking = false;
  Future<void> _checkStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    setState(() => _checking = true);
    final data = (await FirebaseFirestore.instance.collection('users').doc(user.uid).get()).data();
    if (!mounted) return;
    setState(() => _checking = false);
    if (data?['approvalStatus'] == 'approved') {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const DriverHomeScreen()), (_) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('طلبك ما زال قيد المراجعة')));
    }
  }
  @override
  Widget build(BuildContext context) => AppScaffold(
    title: 'مراجعة الحساب',
    body: Center(child: Padding(padding: const EdgeInsets.all(AppSpacing.lg), child: OmaCard(child: Column(mainAxisSize: MainAxisSize.min, children: [
      Container(width: 72, height: 72, decoration: BoxDecoration(color: AppColors.warning.withValues(alpha: .14), shape: BoxShape.circle), child: const Icon(Icons.hourglass_top_rounded, color: AppColors.warning, size: 38)),
      const SizedBox(height: AppSpacing.md), const Text('حسابك قيد المراجعة', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      const SizedBox(height: AppSpacing.sm), const Text('سنخبرك فور الموافقة على بياناتك ووثيقة التحقق.', textAlign: TextAlign.center),
      const SizedBox(height: AppSpacing.lg), PrimaryButton(text: 'التحقق من الحالة', loading: _checking, onPressed: _checkStatus),
    ]))),
  );
}

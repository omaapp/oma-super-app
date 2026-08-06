import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../app/app_routes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/oma_card.dart';
import '../../../core/widgets/primary_button.dart';

class CustomerProfileSetupScreen extends StatefulWidget {
  const CustomerProfileSetupScreen({super.key});
  @override
  State<CustomerProfileSetupScreen> createState() => _CustomerProfileSetupScreenState();
}
class _CustomerProfileSetupScreenState extends State<CustomerProfileSetupScreen> {
  final _controller = TextEditingController();
  bool _saving = false;
  @override void dispose() { _controller.dispose(); super.dispose(); }
  Future<void> _continue() async {
    final name = _controller.text.trim();
    final user = FirebaseAuth.instance.currentUser;
    if (name.isEmpty || user == null) return;
    setState(() => _saving = true);
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({'name': name, 'role': 'customer', 'phone': user.phoneNumber ?? '', 'updatedAt': FieldValue.serverTimestamp()}, SetOptions(merge: true));
    if (!mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.home, (_) => false);
  }
  @override Widget build(BuildContext context) => AppScaffold(title: 'إكمال الحساب', body: Center(child: Padding(padding: const EdgeInsets.all(AppSpacing.lg), child: OmaCard(child: Column(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.person_outline, size: 56), const SizedBox(height: AppSpacing.md), const Text('ما اسمك؟', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)), const SizedBox(height: AppSpacing.md), TextField(controller: _controller, textInputAction: TextInputAction.done, onSubmitted: (_) => _continue(), decoration: const InputDecoration(labelText: 'الاسم الكامل')), const SizedBox(height: AppSpacing.lg), PrimaryButton(text: 'متابعة', loading: _saving, onPressed: _continue)])))));
}

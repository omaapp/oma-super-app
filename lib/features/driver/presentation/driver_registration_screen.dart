import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/oma_card.dart';
import '../../../core/widgets/primary_button.dart';
import 'driver_pending_approval_screen.dart';

class DriverRegistrationScreen extends StatefulWidget {
  const DriverRegistrationScreen({super.key});
  @override
  State<DriverRegistrationScreen> createState() => _DriverRegistrationScreenState();
}

class _DriverRegistrationScreenState extends State<DriverRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _brand = TextEditingController();
  final _plate = TextEditingController();
  String _vehicle = 'taxi';
  String _document = 'national_id';
  bool _saving = false;
  @override void dispose() { _name.dispose(); _brand.dispose(); _plate.dispose(); super.dispose(); }
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    setState(() => _saving = true);
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'uid': user.uid, 'role': 'driver', 'name': _name.text.trim(), 'phone': user.phoneNumber ?? '',
      'vehicleType': _vehicle, 'vehicleBrand': _brand.text.trim(), 'plateNumber': _plate.text.trim(),
      'verificationDocumentType': _document, 'approvalStatus': 'pending', 'isOnline': false,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const DriverPendingApprovalScreen()), (_) => false);
  }
  @override Widget build(BuildContext context) => AppScaffold(title: 'تسجيل السائق', body: Form(key: _formKey, child: ListView(padding: const EdgeInsets.all(AppSpacing.md), children: [
    const Text('أكمل بياناتك للبدء', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), const SizedBox(height: AppSpacing.md),
    OmaCard(child: Column(children: [
      TextFormField(controller: _name, decoration: const InputDecoration(labelText: 'الاسم الكامل'), validator: (v) => v == null || v.trim().isEmpty ? 'أدخل الاسم' : null),
      const SizedBox(height: AppSpacing.md), Text('رقم الهاتف: ${FirebaseAuth.instance.currentUser?.phoneNumber ?? ''}'),
    ])), const SizedBox(height: AppSpacing.md),
    OmaCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('المركبة', style: TextStyle(fontWeight: FontWeight.bold)),
      SegmentedButton<String>(segments: const [ButtonSegment(value: 'taxi', label: Text('Taxi')), ButtonSegment(value: 'tuk_tuk', label: Text('Tuk Tuk'))], selected: {_vehicle}, onSelectionChanged: (v) => setState(() => _vehicle = v.first)),
      const SizedBox(height: AppSpacing.md), TextFormField(controller: _brand, decoration: const InputDecoration(labelText: 'ماركة المركبة'), validator: (v) => v == null || v.trim().isEmpty ? 'أدخل الماركة' : null),
      const SizedBox(height: AppSpacing.md), TextFormField(controller: _plate, decoration: const InputDecoration(labelText: 'رقم اللوحة'), validator: (v) => v == null || v.trim().isEmpty ? 'أدخل رقم اللوحة' : null),
    ])), const SizedBox(height: AppSpacing.md),
    OmaCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('وثيقة التحقق', style: TextStyle(fontWeight: FontWeight.bold)),
      RadioListTile(value: 'national_id', groupValue: _document, onChanged: (v) => setState(() => _document = v!), title: const Text('البطاقة الوطنية')),
      RadioListTile(value: 'driving_license', groupValue: _document, onChanged: (v) => setState(() => _document = v!), title: const Text('إجازة السوق')),
      const Text('ستتم مراجعة وثيقتك وبياناتك قبل التفعيل.', style: TextStyle(color: AppColors.textSecondary)),
    ])), const SizedBox(height: AppSpacing.lg),
    PrimaryButton(text: _saving ? 'جارٍ الإرسال...' : 'إرسال للمراجعة', loading: _saving, onPressed: _submit),
  ])));
}

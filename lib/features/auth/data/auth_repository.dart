import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/models/app_user.dart';
import '../../../core/services/firebase_auth_service.dart';

class AuthRepository {
  final FirebaseAuthService _authService = FirebaseAuthService.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendOtp({
    required String phone,
    required Function(String verificationId) onCodeSent,
    required Function(String error) onError,
  }) async {
    await _authService.verifyPhoneNumber(
      phoneNumber: phone,
      codeSent: onCodeSent,
      verificationFailed: (e) {
        onError(e.message ?? "حدث خطأ");
      },
      verificationCompleted: (_) {},
      codeAutoRetrievalTimeout: (_) {},
    );
  }

  Future<void> verifyOtp({
    required String verificationId,
    required String code,
  }) async {
    final result = await _authService.signInWithOtp(
      verificationId: verificationId,
      smsCode: code,
    );

    final user = result.user;

    if (user == null) return;

    final doc = _firestore.collection("users").doc(user.uid);

    if (!(await doc.get()).exists) {
      final appUser = AppUser(
  uid: user.uid,
  phone: user.phoneNumber ?? "",
  role: "customer",
  active: true,
  createdAt: DateTime.now(),
);

await doc.set(appUser.toMap());

      await doc.set(appUser.toMap());
    }
  }
}
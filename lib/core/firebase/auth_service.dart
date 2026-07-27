import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService._();

  static final instance = AuthService._();

  final FirebaseAuth auth =
      FirebaseAuth.instance;

  User? get currentUser {
    return auth.currentUser;
  }

  String? get uid {
    return auth.currentUser?.uid;
  }

  Future<void> logout() async {
    await auth.signOut();
  }
}
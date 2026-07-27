import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/firebase_auth_service.dart';

final authServiceProvider = Provider<FirebaseAuthService>((ref) {
  return FirebaseAuthService.instance;
});
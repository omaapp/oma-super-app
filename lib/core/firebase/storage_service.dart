import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  StorageService._();

  static final instance =
      StorageService._();

  final FirebaseStorage storage =
      FirebaseStorage.instance;

  Reference drivers(String uid) {
    return storage.ref(
      "drivers/$uid",
    );
  }

  Reference users(String uid) {
    return storage.ref(
      "users/$uid",
    );
  }

  Reference trips(String id) {
    return storage.ref(
      "trips/$id",
    );
  }
}
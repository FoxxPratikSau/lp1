import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  Future<void> saveUserData(String uid, String name, String email) async {
    await users.doc(uid).set({
      'name': name,
      'email': email,
    });
  }
}

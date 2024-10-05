import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firebase_service.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  AuthProvider() {
    user = _auth.currentUser;
  }

  Future<void> signUp(String email, String password, String name) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = credential.user;

      // Save additional user info to Firestore
      await FirebaseService().saveUserData(user!.uid, name, email);

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = credential.user;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void signOut() async {
    await _auth.signOut();
    user = null;
    notifyListeners();
  }
}

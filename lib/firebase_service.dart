import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ✅ Crear cuenta de usuario y guardar en Firestore
  Future<void> registerUser({
    required String email,
    required String password,
    required Map<String, dynamic> userData,
    required Map<String, dynamic> petPreferences,
  }) async {
    // 1. Crear cuenta en Firebase Authentication
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    String uid = userCredential.user!.uid;

    // 2. Agregar campos adicionales a Firestore
    await _firestore.collection('users').doc(uid).set({
      'uid': uid,
      ...userData,
      'petPreferences': petPreferences,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}

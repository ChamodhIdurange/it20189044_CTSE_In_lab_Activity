import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserRepositery {
  final storage = FirebaseFirestore.instance;

  registerUser(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseException catch (e) {
      return Text(
        e.message!,
        style: const TextStyle(color: Colors.red),
      );
    }
  }

  Future<Text> signIn(String passedInEmail, String passedInPassword) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: passedInEmail, password: passedInPassword);
      return const Text("");
    } on FirebaseException catch (e) {
      return Text(
        e.message!,
        style: const TextStyle(color: Colors.red),
      );
    }
  }

  fireBaseSignOut() {
    FirebaseAuth.instance.signOut();
  }

  getCurrentUser() {
    return FirebaseAuth.instance.currentUser!;
  }
}

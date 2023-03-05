import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:in_lab_activity/screens/login_register_screen.dart';
import 'package:in_lab_activity/screens/recipe_screen.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        //Fir capturing the auth state changes
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //is logged in
          if (snapshot.hasData) {
            return const RecipeList();
          }
          //is not logged in
          else {
            return const LoginRegisterScreen();
          }
        },
      ),
    );
  }
}

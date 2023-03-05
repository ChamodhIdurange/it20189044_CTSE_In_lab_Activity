import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:in_lab_activity/repositories/recipe_repositery.dart';
import 'package:in_lab_activity/repositories/auth_repositery.dart';
import 'package:in_lab_activity/screens/auth_page.dart';
import 'firebase_options.dart';
import 'package:firebase_storage/firebase_storage.dart';

// Initializing the array List
final storage = FirebaseStorage.instance;
final storageRef = FirebaseStorage.instance.ref();
final repo = RecipeRepositery();
final userRepo = AuthRepositery();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const AuthPage(),
    );
  }
}

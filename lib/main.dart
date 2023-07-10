import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter24/blog/blog_screen.dart';
import 'package:flutter24/notes/notes_login_screen.dart';
import 'package:flutter24/notes/notes_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: FirebaseAuth.instance.currentUser == null
          ? NotesLoginScreen()
          : NotesScreen(),
    );
  }
}

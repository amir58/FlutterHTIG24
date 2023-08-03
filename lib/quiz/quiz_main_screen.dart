import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter24/quiz/quiz_login_screen.dart';
import 'package:flutter24/quiz/quiz_profile_screen.dart';
import 'package:flutter24/quiz/start_quiz_screen.dart';

class QuizMainScreen extends StatefulWidget {
  const QuizMainScreen({Key? key}) : super(key: key);

  @override
  State<QuizMainScreen> createState() => _QuizMainScreenState();
}

class _QuizMainScreenState extends State<QuizMainScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(minutes: 3)).then((value) {});

    Timer.periodic(const Duration(seconds: 1), (timer) {
      print(DateTime.now().toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz Main"),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizLoginScreen(),
                ),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Lottie.asset('assets/animations/quiz.json'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StartQuizScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/images/quiz.png",
                    height: 24,
                    width: 24,
                  ),
                  const SizedBox(width: 10),
                  const Text("Start Quiz"),
                ],
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StartQuizScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
              icon: getImageAsset(
                imageName: "quiz",
                extension: ImageExtensions.png,
                width: 50,
                height: 50,
              ),
              label: Text("Start Quiz"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizProfileScreen(),
                  ),
                );
              },
              child: const Text("Profile"),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable component => Class ( TASK )
  Image getImageAsset({
    required String imageName,
    ImageExtensions extension = ImageExtensions.png,
    double height = 24,
    double width = 24,
  }) {
    return Image.asset(
      "assets/images/$imageName.${extension.name}",
      height: height,
      width: width,
    );
  }
}

enum ImageExtensions { png, jpg }

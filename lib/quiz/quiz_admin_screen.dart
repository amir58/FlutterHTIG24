import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter24/quiz/add_question_screen.dart';
import 'package:flutter24/quiz/quiz_login_screen.dart';

class QuizAdminScreen extends StatefulWidget {
  const QuizAdminScreen({Key? key}) : super(key: key);

  @override
  State<QuizAdminScreen> createState() => _QuizAdminScreenState();
}

class _QuizAdminScreenState extends State<QuizAdminScreen> {
  final firestore = FirebaseFirestore.instance;

  final List<Map<String, dynamic>> questions = [];

  @override
  void initState() {
    super.initState();
    getQuestions();
  }

  void getQuestions() {
    firestore.collection("quizQuestions").get().then((value) {
      questions.clear();
      for (var document in value.docs) {
        final question = document.data();
        questions.add(question);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz Admin"),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddQuestionScreen(),
            ),
          ).then((value) => getQuestions());
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final questionMap = questions[index];

          return Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "- ${questionMap['question']}",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "1 : ${questionMap['answerOne']}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: questionMap['rightAnswer'] == 'one'
                        ? Colors.green
                        : Colors.black,
                  ),
                ),
                Text(
                  "2 : ${questionMap['answerTwo']}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: questionMap['rightAnswer'] == 'two'
                        ? Colors.green
                        : Colors.black,
                  ),
                ),
                Text(
                  "3 : ${questionMap['answerThree']}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: questionMap['rightAnswer'] == 'three'
                        ? Colors.green
                        : Colors.black,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

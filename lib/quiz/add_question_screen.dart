import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddQuestionScreen extends StatefulWidget {
  const AddQuestionScreen({Key? key}) : super(key: key);

  @override
  State<AddQuestionScreen> createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  final questionController = TextEditingController();
  final answerOneController = TextEditingController();
  final answerTwoController = TextEditingController();
  final answerThreeController = TextEditingController();
  final rightAnswerController = TextEditingController();

  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Question"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextFormField(
              controller: questionController,
              decoration: const InputDecoration(
                labelText: "Question",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: answerOneController,
              decoration: const InputDecoration(
                labelText: "Answer One",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: answerTwoController,
              decoration: const InputDecoration(
                labelText: "Answer Two",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: answerThreeController,
              decoration: const InputDecoration(
                labelText: "Answer Three",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: rightAnswerController,
              decoration: const InputDecoration(
                labelText: "Right Answer",
                border: OutlineInputBorder(),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  addQuestion();
                },
                child: const Text(
                  "Add",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void addQuestion() {
    String question = questionController.text;
    String answerOne = answerOneController.text;
    String answerTwo = answerTwoController.text;
    String answerThree = answerThreeController.text;
    String rightAnswer = rightAnswerController.text;

    String questionId = DateTime.now().millisecondsSinceEpoch.toString();

    Map<String, dynamic> data = {
      "questionId": questionId,
      "question": question,
      "answerOne": answerOne,
      "answerTwo": answerTwo,
      "answerThree": answerThree,
      "rightAnswer": rightAnswer,
    };

    firestore.collection("quizQuestions").doc(questionId).set(data);

    Navigator.pop(context);
  }
}

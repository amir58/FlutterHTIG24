import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// enum => constants
enum EAnswers { one, two, three }

class StartQuizScreen extends StatefulWidget {
  const StartQuizScreen({Key? key}) : super(key: key);

  @override
  State<StartQuizScreen> createState() => _StartQuizScreenState();
}

class _StartQuizScreenState extends State<StartQuizScreen> {
  final firestore = FirebaseFirestore.instance;

  final List<Map<String, dynamic>> questions = [];

  int currentQuestionIndex = 0;

  EAnswers? eAnswers = EAnswers.one;

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
        title: const Text("Quiz"),
      ),
      body: questions.isEmpty
          ? const Center(child: CircularProgressIndicator.adaptive())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Question ${currentQuestionIndex + 1} / ${questions.length}",
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 33,
                    ),
                  ),
                  Container(
                    width: double.infinity,
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
                          "- ${questions[currentQuestionIndex]['question']}",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        RadioListTile<EAnswers>(
                          title: Text(
                              questions[currentQuestionIndex]['answerOne']),
                          value: EAnswers.one,
                          groupValue: eAnswers,
                          onChanged: (EAnswers? value) {
                            setState(() {
                              eAnswers = value;
                            });
                          },
                        ),
                        RadioListTile<EAnswers>(
                          title: Text(
                              questions[currentQuestionIndex]['answerTwo']),
                          value: EAnswers.two,
                          groupValue: eAnswers,
                          onChanged: (EAnswers? value) {
                            setState(() {
                              eAnswers = value;
                            });
                          },
                        ),
                        RadioListTile<EAnswers>(
                          title: Text(
                              questions[currentQuestionIndex]['answerThree']),
                          value: EAnswers.three,
                          groupValue: eAnswers,
                          onChanged: (EAnswers? value) {
                            setState(() {
                              eAnswers = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => nextQuestion(),
                      child: Text(
                        currentQuestionIndex + 1 == questions.length
                            ? "Finish Quiz"
                            : "Next Question",
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  int points = 0;

  void nextQuestion() {
    print(eAnswers);
    print(eAnswers!.name);

    if (eAnswers!.name == questions[currentQuestionIndex]['rightAnswer']) {
      points++;
    }

    if (currentQuestionIndex + 1 == questions.length) {
      _showMyDialog();
      return;
    }

    currentQuestionIndex++;
    setState(() {});
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Your points : $points / ${questions.length}'),
          actions: <Widget>[
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

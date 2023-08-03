import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter24/notes/notes_register_screen.dart';
import 'package:flutter24/notes/notes_screen.dart';
import 'package:flutter24/quiz/quiz_admin_screen.dart';
import 'package:flutter24/quiz/quiz_main_screen.dart';
import 'package:flutter24/quiz/quiz_register_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class QuizLoginScreen extends StatefulWidget {
  @override
  State<QuizLoginScreen> createState() => _QuizLoginScreenState();
}

class _QuizLoginScreenState extends State<QuizLoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  // Form => TextFormFields
  final formKey = GlobalKey<FormState>();

  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz Login"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email required";
                    }
                    // if not contain @ OR if not contain .
                    if (!value.contains("@") || !value.contains(".")) {
                      return "Email invalid";
                    }

                    return null;
                  },
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.email,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password required";
                    }
                    if (value.length < 6) {
                      return "Password must be at least 6 character";
                    }

                    return null;
                  },
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.lock,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () {},
                  child: const Text(
                    "Forget password?",
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    // 2 / 3
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder()),
                        onPressed: () => login(),
                        child: const Text(
                          "Login",
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    // 1 / 3
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizRegisterScreen(),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          shape: const StadiumBorder(),
                        ),
                        child: const Text('Register'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    // if not validate => return
    if (!formKey.currentState!.validate()) {
      return;
    }

    String email = emailController.text;
    String password = passwordController.text;

    auth
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      checkUserType();
    }).catchError((error) {
      print(error);
      Fluttertoast.showToast(msg: error.toString());
    });
  }

  void checkUserType() {
    String userId = auth.currentUser!.uid;

    firestore.collection("quizUsers").doc(userId).get().then((value) {
      if (!value.exists) {
        Fluttertoast.showToast(msg: "User not found!");
        return;
      }

      if (value.data()!['admin']) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const QuizAdminScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const QuizMainScreen()),
        );
      }
    }).catchError((error) {});
  }
}

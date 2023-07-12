import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class QuizRegisterScreen extends StatefulWidget {
  @override
  State<QuizRegisterScreen> createState() => _QuizRegisterScreenState();
}

class _QuizRegisterScreenState extends State<QuizRegisterScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz Register"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: nameController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.person,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: phoneController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.phone,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
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
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                  onPressed: () => register(),
                  child: const Text(
                    "Register",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  register() async {
    String name = nameController.text;
    String phone = phoneController.text;
    String email = emailController.text;
    String password = passwordController.text;

    auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      saveUserDataOnFirestore(name, phone, email);
    }).catchError((error) {
      print(error);
    });
  }

  void saveUserDataOnFirestore(
    String name,
    String phone,
    String email,
  ) {
    String userId = auth.currentUser!.uid;

    Map<String, dynamic> data = {
      "userId": userId,
      "name": name,
      "phone": phone,
      "email": email,
      "admin": false,
    };

    firestore.collection("quizUsers")
    .doc(userId)
    .set(data)
    .then((value) {
      auth.signOut();
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Account created!");
    })
    .catchError((error){
      Fluttertoast.showToast(msg: error.toString());
    });

  }
}

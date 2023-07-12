import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NotesRegisterScreen extends StatefulWidget {
  @override
  State<NotesRegisterScreen> createState() => _NotesRegisterScreenState();
}

class _NotesRegisterScreenState extends State<NotesRegisterScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes Register"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
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
    String email = emailController.text;
    String password = passwordController.text;

    auth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      Navigator.pop(context);
      print('Account created!');
    }).catchError((error) {
      print(error);
    });

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        Fluttertoast.showToast(msg: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        Fluttertoast.showToast(
            msg: "The account already exists for that email.");
      }
    } catch (e) {
      print(e);
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter24/notes/login/cubit/login_cubit.dart';
import 'package:flutter24/notes/login/cubit/login_states.dart';
import 'package:flutter24/notes/notes_register_screen.dart';
import 'package:flutter24/notes/notes_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NotesLoginScreen extends StatefulWidget {
  @override
  State<NotesLoginScreen> createState() => _NotesLoginScreenState();
}

class _NotesLoginScreenState extends State<NotesLoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final cubit = LoginCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) navigateToNotesScreen();
          if (state is LoginFailureState) {
            Fluttertoast.showToast(msg: state.errorMessage);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Notes Login"),
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
                                builder: (context) => NotesRegisterScreen(),
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
      ),
    );
  }

  login() {
    String email = emailController.text;
    String password = passwordController.text;

    cubit.login(email: email, password: password);
  }

  void navigateToNotesScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => NotesScreen(),
      ),
    );
  }
}

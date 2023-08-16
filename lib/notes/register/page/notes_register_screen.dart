import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter24/notes/register/cubit/register_cubit.dart';
import 'package:flutter24/notes/register/cubit/register_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NotesRegisterScreen extends StatefulWidget {
  @override
  State<NotesRegisterScreen> createState() => _NotesRegisterScreenState();
}

class _NotesRegisterScreenState extends State<NotesRegisterScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final cubit = RegisterCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            onRegisterSuccess();
          }
          if (state is RegisterFailureState) {
            onRegisterFailure(state.errorMessage);
          }
        },
        child: Scaffold(
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
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder()),
                      onPressed: () => cubit.register(
                        email: emailController.text,
                        password: passwordController.text,
                      ),
                      child: const Text(
                        "Register",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onRegisterSuccess() => Navigator.pop(context);

  void onRegisterFailure(String errorMessage) =>
      Fluttertoast.showToast(msg: errorMessage);
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter24/apis/ecommerce/e_home_screen.dart';
import 'package:flutter24/apis/ecommerce/login/cubit/e_login_cubit.dart';
import 'package:flutter24/apis/ecommerce/login/cubit/e_login_state.dart';
import 'package:flutter24/notes/login/cubit/login_states.dart';
import 'package:flutter24/notes/register/page/notes_register_screen.dart';
import 'package:flutter24/notes/notes/page/notes_screen.dart';
import 'package:flutter24/quiz/quiz_admin_screen.dart';
import 'package:flutter24/quiz/quiz_main_screen.dart';
import 'package:flutter24/quiz/quiz_register_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ELoginScreen extends StatefulWidget {
  @override
  State<ELoginScreen> createState() => _ELoginScreenState();
}

class _ELoginScreenState extends State<ELoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  // Form => TextFormFields
  final formKey = GlobalKey<FormState>();

  final cubit = ELoginCubit();

  @override
  void initState() {
    super.initState();
    checkApiToken();
  }

  void checkApiToken() async {
    final pref = await SharedPreferences.getInstance();
    String apiToken = pref.getString("apiToken") ?? "";

    if (apiToken.isNotEmpty) {
      onLoginSuccess();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<ELoginCubit, ELoginState>(
        listener: (context, state) {
          if (state is ELoginSuccessState) onLoginSuccess();
          print('BlocListener => $state');
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Login"),
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
        ),
      ),
    );
  }

  void login() {
    if (formKey.currentState!.validate()) {
      cubit.login(
        email: emailController.text,
        password: passwordController.text,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void onLoginSuccess() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => EHomeScreen(),
      ),
    );
  }
}

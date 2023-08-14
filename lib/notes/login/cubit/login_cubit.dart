import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter24/notes/login/cubit/login_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  final auth = FirebaseAuth.instance;

  login({
    required String email,
    required String password,
  }) async {
    auth
        .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
        .then((value) => emit(LoginSuccessState()))
        .catchError((error) => emit(LoginFailureState(error.toString())));
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter24/notes/register/cubit/register_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  final auth = FirebaseAuth.instance;

  register({
    required String email,
    required String password,
  }) async {
    // auth
    //     .createUserWithEmailAndPassword(
    //       email: email,
    //       password: password,
    //     )
    //     .then((value) => emit(RegisterSuccessState()))
    //     .catchError(
    //       (error) => emit(RegisterFailureState(errorMessage: error.toString())),
    //     );

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      emit(RegisterSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailureState(
            errorMessage: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailureState(
            errorMessage: 'The account already exists for that email.'));
      }
    } catch (e) {
      emit(RegisterFailureState(errorMessage: e.toString()));
    }
  }
}

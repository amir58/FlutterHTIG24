import 'package:dio/dio.dart';
import 'package:flutter24/apis/ecommerce/login/cubit/e_login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ELoginCubit extends Cubit<ELoginState> {
  ELoginCubit() : super(ELoginInitial());

  final String baseUrl = "https://student.valuxapps.com/api";

  Dio dio = Dio(
    BaseOptions(
      headers: {"lang": "ar"},
    ),
  );

  void login({
    required String email,
    required String password,
  }) {
    dio.post(
      "$baseUrl/login",
      data: {
        "email": email,
        "password": password,
      },
    ).then((value) {
      emit(ELoginSuccessState());
      print(value.statusCode);
      print(value.data);
      _saveUserData(value.data);
    }).catchError((error) {
      emit(ELoginFailureState(error.toString()));
      print(error);
    });
  }

  void _saveUserData(dynamic data) async {
    final pref = await SharedPreferences.getInstance();

    pref.setString("apiToken", data['data']['token']);
    pref.setString("name", data['data']['name']);
    pref.setString("email", data['data']['email']);
    pref.setString("phone", data['data']['phone']);
    pref.setString("image", data['data']['image']);
  }
}

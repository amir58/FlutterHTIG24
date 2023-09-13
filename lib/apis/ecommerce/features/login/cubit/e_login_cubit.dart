import 'package:dio/dio.dart';
import 'package:flutter24/apis/ecommerce/data_source/local/app_shared_preferences.dart';
import 'package:flutter24/apis/ecommerce/features/login/cubit/e_login_state.dart';
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
      print(value.statusCode);
      print(value.data);

      if (value.data['status'] == true) {
        emit(ELoginSuccessState());
        _saveUserData(value.data);
      }
      else{
        emit(ELoginFailureState(value.data['message']));
      }



    }).catchError((error) {
      emit(ELoginFailureState(error.toString()));
      print(error);
    });
  }

  void _saveUserData(dynamic data) async {
    PreferenceUtils.setString("apiToken", data['data']['token']);
    PreferenceUtils.setString("name", data['data']['name']);
    PreferenceUtils.setString("email", data['data']['email']);
    PreferenceUtils.setString("phone", data['data']['phone']);
    PreferenceUtils.setString("image", data['data']['image']);
  }
}

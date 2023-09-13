import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter24/apis/ecommerce/constants/strings.dart';
import 'package:flutter24/apis/ecommerce/data_source/api/end_points.dart';
import 'package:flutter24/apis/ecommerce/models/EHomeResponse.dart';
import 'package:meta/meta.dart';

part 'e_home_state.dart';

class EHomeCubit extends Cubit<EHomeState> {
  EHomeCubit() : super(EHomeInitial());
  EHomeData homeData = EHomeData();

  Dio dio = Dio(
    BaseOptions(
      headers: {"lang": "en"},
    ),
  );

  void getHome() async {
    // dio.get(baseUrl + home);
    // dio.get("$baseUrl$home");
    final response = await dio.get("${Constants.baseUrl}${EndPoints.home}");

    if (response.data['status']) {
      final model = EHomeResponse.fromJson(response.data);
      homeData = model.data;
      emit(EGetHomeSuccessState(response.data['data']));
    } else {
      emit(EGetHomeFailureState(response.data['message']));
    }
  }
}

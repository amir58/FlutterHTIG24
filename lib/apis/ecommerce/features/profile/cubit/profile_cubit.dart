import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter24/apis/ecommerce/core/loading.dart';
import 'package:flutter24/apis/ecommerce/data_source/local/app_shared_preferences.dart';
import 'package:flutter24/apis/ecommerce/features/profile/models/profile_response.dart';
import 'package:meta/meta.dart';

import '../../../constants/strings.dart';
import '../../../data_source/api/end_points.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  var profileData = ProfileData();

  Dio dio = Dio(
    BaseOptions(
      headers: {
        "lang": "ar",
        'Authorization': PreferenceUtils.getString('apiToken'),
      },
    ),
  );

  void getProfile() async {
    final response = await dio.get("${Constants.baseUrl}${EndPoints.profile}");

    print("Profile => ${response.data}");

    if (response.data['status']) {
      final model = ProfileResponse.fromJson(response.data);
      profileData = model.data ?? ProfileData();
      emit(GetProfileSuccessState());
    } else {
      emit(GetProfileFailureState(response.data['message']));
    }
  }

  void updateProfile({
    required String name,
    required String phone,
    required String email,
  }) async {
    showLoading();

    final response = await dio.put(
      "${Constants.baseUrl}${EndPoints.updateProfile}",
      data: {
        "name": name,
        "phone": phone,
        "email": email,
      },
    );

    hideLoading();

    print("Profile => ${response.data}");

    if (response.data['status']) {
      final model = ProfileResponse.fromJson(response.data);
      profileData = model.data;
      emit(GetProfileSuccessState());
      showSuccess(message: 'Updated');
    } else {
      emit(GetProfileFailureState(response.data['message']));
      showError(message: response.data['message']);
    }
  }
}

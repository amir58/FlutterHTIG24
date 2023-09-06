// BASE_URL => https://student.valuxapps.com/api/
// EndPoint => register

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ERegisterScreen extends StatefulWidget {
  const ERegisterScreen({super.key});

  @override
  State<ERegisterScreen> createState() => _ERegisterScreenState();
}

class _ERegisterScreenState extends State<ERegisterScreen> {
  final String baseUrl = "https://student.valuxapps.com/api";

  Dio dio = Dio(
    BaseOptions(
      headers: {"lang": "ar"},
    ),
  );

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  @override
  void initState() {
    super.initState();
    updateProfile();
  }

  void register() async {
    final response = await dio.post(
      "$baseUrl/register",
      // data = body in postman
      data: {
        "name": "HTI",
        "email": "hti4@gmail.com",
        "phone": "012214726484",
        "password": "123123"
      },
    );

    print(response.statusCode);
    print(response.data['status']);
    print(response.data['message']);

    if (response.statusCode == 200 && response.data['status'] == true) {
      print(response.data);
      print(response.data['data']);
    }
  }

  void login() {
    dio.post(
      "$baseUrl/login",
      data: {
        "email": "hti3@gmail.com",
        "password": "123123",
      },
    ).then((value) {
      print(value.statusCode);
      print(value.data);
      print('-----------------------');
      print(value.data['data']['id']);
      print(value.data['data']['name']);
      print(value.data['data']['email']);
      print(value.data['data']['phone']);
      print(value.data['data']['image']);
      print(value.data['data']['token']);
    }).catchError((error) {
      print(error);
    });
  }

  void getUserData() {
    dio
        .get("$baseUrl/profile",
            options: Options(
              headers: {
                "Authorization":
                    "Gio3eZGus2i5JU90e97SuBv05Q5sYOhJQvmnMTHNc6AcHKRvBMO16HdXOGansX3uqF3HOJ"
              },
            ))
        .then((value) {
      print(value.statusCode);
      print(value.data);
    });
  }

  void updateProfile() async {
    final response = await dio.put("$baseUrl/update-profile",
        // data = body in postman
        data: {
          "name": "HTI Senior Steps",
          "email": "hti5@gmail.com",
          "phone": "0227278080",
          "password": "123123"
        },
        options: Options(
          headers: {
            "Authorization":
                "Gio3eZGus2i5JU90e97SuBv05Q5sYOhJQvmnMTHNc6AcHKRvBMO16HdXOGansX3uqF3HOJ"
          },
        ));

    print(response.statusCode);
    print(response.data['status']);
    print(response.data['message']);

    if (response.statusCode == 200 && response.data['status'] == true) {
      print(response.data);
      print(response.data['data']);
    }
  }
}

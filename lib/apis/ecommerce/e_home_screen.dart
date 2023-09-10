import 'package:flutter/material.dart';
import 'package:flutter24/apis/ecommerce/login/view/e_login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EHomeScreen extends StatefulWidget {
  const EHomeScreen({super.key});

  @override
  State<EHomeScreen> createState() => _EHomeScreenState();
}

class _EHomeScreenState extends State<EHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            onPressed: () async {
              final pref = await SharedPreferences.getInstance();
              pref.remove("apiToken");
              // pref.clear(); // To remove all data
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ELoginScreen(),
                ),
              );
            },
            icon: Icon(Icons.exit_to_app),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter24/apis/ecommerce/data_source/local/app_shared_preferences.dart';
import 'package:flutter24/apis/ecommerce/features/home/view/e_home_screen.dart';
import 'package:flutter24/apis/ecommerce/features/login/view/e_login_screen.dart';
import 'package:flutter24/apis/ecommerce/features/profile/pages/profile_screen.dart';

class EMainScreen extends StatefulWidget {
  const EMainScreen({super.key});

  @override
  State<EMainScreen> createState() => _EMainScreenState();
}

class _EMainScreenState extends State<EMainScreen> {
  List<Widget> screens = [
    const EHomeScreen(),
    const SizedBox(),
    const EProfileScreen(),
  ];

  List<String> titles = [
    'Home',
    'Favourites',
    'Profile',
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[currentIndex]),
        actions: [
          IconButton(
            onPressed: () async {
              PreferenceUtils.remove("apiToken");
              // PreferenceUtils.clear(); // To remove all data
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ELoginScreen(),
                ),
              );
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favourites",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

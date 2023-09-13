import 'package:flutter/material.dart';
import 'package:flutter24/apis/ecommerce/features/home/view/e_home_screen.dart';

class EMainScreen extends StatefulWidget {
  const EMainScreen({super.key});

  @override
  State<EMainScreen> createState() => _EMainScreenState();
}

class _EMainScreenState extends State<EMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EHomeScreen(),
      bottomNavigationBar: BottomNavigationBar(
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

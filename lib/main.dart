import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter24/apis/ecommerce/data_source/local/app_shared_preferences.dart';
import 'package:flutter24/apis/ecommerce/features/home/view/e_home_screen.dart';
import 'package:flutter24/apis/ecommerce/features/login/view/e_login_screen.dart';
import 'package:flutter24/apis/ecommerce/features/main_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// Connect Firebase to iOS
// TextFormField => Validators
// Assets
// Lottie

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceUtils.init();
  await Firebase.initializeApp();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      // enabled: true,
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (p0, p1, p2) {
        return MaterialApp(
          builder: EasyLoading.init(),
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: PreferenceUtils.getString("apiToken").isEmpty
              ? ELoginScreen()
              : EMainScreen(),
          // home: FirebaseAuth.instance.currentUser == null
          //     ? NotesLoginScreen()
          //     : NotesScreen(),

          // home: BlocProvider(
          //   create: (_) => CounterCubit(),
          //   child: CounterPage(),
          // ),

          // home: FirebaseAuth.instance.currentUser == null
          //     ? QuizLoginScreen()
          //     : const QuizMainScreen(),
        );
      },
    );
  }
}

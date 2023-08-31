import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter24/apis/news/news_screen.dart';
import 'package:flutter24/apis/posts/posts_screen.dart';
import 'package:flutter24/blog/blog_screen.dart';
import 'package:flutter24/notes/login/page/notes_login_screen.dart';
import 'package:flutter24/notes/notes/page/notes_screen.dart';
import 'package:flutter24/quiz/quiz_login_screen.dart';
import 'package:flutter24/quiz/quiz_main_screen.dart';
import 'package:flutter24/state_management/counter_cubit.dart';
import 'package:flutter24/state_management/counter_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// Connect Firebase to iOS
// TextFormField => Validators
// Assets
// Lottie

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: NewsScreen(),
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

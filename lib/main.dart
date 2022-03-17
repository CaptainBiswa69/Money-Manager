import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/myTheme.dart';
import 'package:flutter_application_3/pages/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: myTheme,
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
            backgroundColor: Colors.white,
            splash: Image.asset("assets/images/ManagerR.gif"),
            splashIconSize: 300,
            nextScreen: const HomePage()));
  }
}

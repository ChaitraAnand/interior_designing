import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'secondscreen.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      backgroundColor: Colors.black,
      image : Image.asset('assets/images/logo2.png'),
      loaderColor: Colors.cyanAccent,
      photoSize: 150.0,
      navigateAfterSeconds: MainScreen(),
    );
  }
}


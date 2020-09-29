import 'package:flutter/material.dart';
import 'package:sqlite/screen/HomeScreen.dart';
import 'package:sqlite/screen/SplashScreen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

import 'package:flutter/material.dart';

class Themes {
  static Color get primary => const Color.fromARGB(255, 104, 159, 56);
  static Color get primaryLight => const Color.fromARGB(255, 240, 248, 233);
  static Color get backGround => Colors.white;
  static Color get secondary => const Color.fromARGB(255, 55, 55, 55);

  static TextTheme textTheme() => TextTheme(
        headline1: TextStyle(
            fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white),
        labelMedium: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700]),
        headline3: TextStyle(fontSize: 16.0, color: Colors.lightGreen[700]),
      );

  static AppBar defaultAppBar({String title = ''}) => AppBar(
        title: Text(title),
        centerTitle: true,
        backgroundColor: Themes.primary,
        titleTextStyle: Themes.textTheme().headline1,
      );
}
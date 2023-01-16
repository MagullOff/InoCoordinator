import 'package:flutter/material.dart';

class Themes {
  static Color get primary => const Color.fromARGB(255, 104, 159, 56);
  static Color get primaryLight => const Color.fromARGB(255, 240, 248, 233);
  static Color get backGround => Colors.white;
  static Color get secondary => const Color.fromARGB(255, 55, 55, 55);

  static TextTheme textTheme() => TextTheme(
      headline1: const TextStyle(
          fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white),
      labelMedium: TextStyle(
          fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.grey[700]),
      headline3: TextStyle(fontSize: 16.0, color: Colors.lightGreen[700]),
      headline2: TextStyle(
          fontSize: 20.0, fontWeight: FontWeight.bold, color: secondary),
      headline5: TextStyle(
          fontSize: 30.0, fontWeight: FontWeight.bold, color: secondary),
      headline6: TextStyle(fontSize: 17.0, color: secondary),
      headline4: TextStyle(fontSize: 14.0, color: Colors.grey[700]),
      caption: TextStyle(
          fontSize: 40.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 10,
          color: secondary),
      button: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold));

  static AppBar defaultAppBar({String title = '', List<Widget>? actions}) =>
      AppBar(
        title: Text(
          title,
          style: textTheme().headline1,
        ),
        centerTitle: true,
        backgroundColor: Themes.primary,
        titleTextStyle: Themes.textTheme().headline1,
        actions: actions,
      );
}

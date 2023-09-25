import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black54,
    colorScheme: const ColorScheme.dark(
      onSurface: Colors.white,
      primary: Colors.lightBlueAccent,
    ),
    primaryColor: Colors.lightBlueAccent,
    cardColor: const Color(0xFF454545),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.lightBlueAccent,
    ),
    fontFamily: "Montserrat",
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontFamily: "Montserrat",
      ),
      actionsIconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Colors.blue,
      linearTrackColor: Colors.grey,
    ),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFFEEEEEE),
    colorScheme: const ColorScheme.light(
      onSurface: Colors.black,
      primary: Colors.lightBlueAccent,
    ),
    cardColor: Colors.white,
    primaryColor: Colors.lightBlueAccent,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.lightBlueAccent,
    ),
    fontFamily: "Montserrat",
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontFamily: "Montserrat",
      ),
      actionsIconTheme: IconThemeData(
        color: Colors.black,
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.black,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.lightBlueAccent,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Colors.lightBlueAccent,
      linearTrackColor: Colors.grey,
    ),
  );
}

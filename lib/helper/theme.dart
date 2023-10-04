import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: darkBackgroundColor,
    colorScheme: const ColorScheme.dark(
      onSurface: Colors.white,
      primary: primaryColor,
    ),
    primaryColor: primaryColor,
    cardColor: darkCardColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
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
      color: primaryColor,
      linearTrackColor: Colors.grey,
    ),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFFEEEEEE),
    colorScheme: const ColorScheme.light(
      onSurface: Colors.black,
      primary: primaryColor,
    ),
    cardColor: lightCardColor,
    primaryColor: primaryColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
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
      selectedItemColor: primaryColor,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: primaryColor,
      linearTrackColor: Colors.grey,
    ),
  );
}

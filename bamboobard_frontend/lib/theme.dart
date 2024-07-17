import 'package:flutter/material.dart';

class MyAppTheme {
  static const Color darkBg = Color(0xFF181820);
  static const Color darkBorder = Color(0xFF343343);
  static const Color darkFg = Color(0xFFF8FBFC);
  static const Color primary = Color(0xFF5FB8FA);
  static const Color secondary = Color(0xFFFB548D);
  static const Color darkMutedFg = Color(0xFFF0F0F0);
  static const Color darkMutedBg = Color(0xFF888888);
  static const Color darkDestructive = Color(0xFFFF4C61);

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primary,
    colorScheme: ColorScheme.dark(
      primary: primary,
      secondary: secondary,
      background: darkBg,
      surface: darkBorder,
      onBackground: darkFg,
      onSurface: darkFg,
      onPrimary: darkBg,
      onSecondary: darkBg,
      error: darkDestructive,
      onError: darkBg,
    ),
    scaffoldBackgroundColor: darkBg,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: darkFg),
      bodyMedium: TextStyle(color: darkFg),
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      buttonColor: primary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkMutedBg,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: darkBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: darkBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: primary),
      ),
    ),
    appBarTheme: AppBarTheme(
      color: darkBg,
      iconTheme: IconThemeData(color: darkFg),
      titleTextStyle: TextStyle(
        color: darkFg,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    cardTheme: CardTheme(
      color: darkMutedBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}

import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData _lightTheme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.black,
    brightness: Brightness.light,
    // colorScheme: const ColorScheme.light(
    //   brightness: Brightness.light,
    // ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.white,
    ),
    listTileTheme: const ListTileThemeData(
      titleTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
      subtitleTextStyle: TextStyle(
        color: Colors.black,
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: const WidgetStatePropertyAll(Colors.black),
      trackColor: const WidgetStatePropertyAll(Colors.white),
      overlayColor: WidgetStatePropertyAll(Colors.black.withOpacity(0.15)),
    ),
  );

  static final ThemeData _darkTheme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.white,
    brightness: Brightness.dark,
    // colorScheme: const ColorScheme.dark(
    //   brightness: Brightness.dark,
    // ),
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.black,
    ),
    listTileTheme: const ListTileThemeData(
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      subtitleTextStyle: TextStyle(
        color: Colors.white,
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: const WidgetStatePropertyAll(Colors.black),
      trackColor: const WidgetStatePropertyAll(Colors.white),
      overlayColor: WidgetStatePropertyAll(Colors.black.withOpacity(0.15)),
    ),
  );

  static ThemeData get lightTheme => _lightTheme;
  static ThemeData get darkTheme => _darkTheme;
}

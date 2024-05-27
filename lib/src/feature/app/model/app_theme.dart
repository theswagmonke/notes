import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData _lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      brightness: Brightness.light,
      primary: Colors.black,
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      surfaceTintColor: Colors.transparent,
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
      trackOutlineWidth: const WidgetStatePropertyAll(1),
    ),

  );

  static final ThemeData _darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      brightness: Brightness.dark,
      primary: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      surfaceTintColor: Colors.transparent,
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
      trackOutlineWidth: const WidgetStatePropertyAll(1),
    ),
  );

  static ThemeData get lightTheme => _lightTheme;
  static ThemeData get darkTheme => _darkTheme;
}

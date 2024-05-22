import 'package:flutter/material.dart';
import 'dart:async';

import 'package:notes/src/feature/splash/splash_screen.dart';

void main() => runZonedGuarded(
      () => runApp(const App()),
      (error, stackTrace) => print('Top level exception:\n$error,\n$stackTrace'),
    );

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}


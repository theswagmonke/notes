import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:developer';

import 'package:notes/src/feature/app/di.dart';
import 'package:notes/src/feature/app/widget/app.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await initializeDependencies();
      runApp(const App());
    },
    (error, stackTrace) => log('Top level exception:\n$error,\n$stackTrace'),
  );
}

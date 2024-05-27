import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:developer';

import 'package:notes/src/feature/app/di.dart';
import 'package:notes/src/feature/app/widget/app.dart';
import 'package:notes/src/feature/notes/data/notes_db.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await NotesDatabase.instance.database;
      await initializeDependencies();
      runApp(const App());
    },
    (error, stackTrace) => log('Top level exception:\n$error,\n$stackTrace'),
  );
}

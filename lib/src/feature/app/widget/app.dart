import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:notes/src/core/utils/router/router.dart';
import 'package:notes/src/feature/app/di.dart';
import 'package:notes/src/feature/app/model/app_theme.dart';
import 'package:notes/src/core/utils/theme/theme_manager.dart';
import 'package:notes/src/core/utils/theme/theme_provider.dart';

import 'package:notes/src/feature/notes/bloc/notes_bloc.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final ThemeManager _themeManager = ThemeManager();

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      notifier: _themeManager,
      child: Builder(
        builder: (context) {
          final isDarkTheme = ThemeProvider.of(context).isDarkTheme;
          return MultiBlocProvider(
            providers: [
              BlocProvider<NotesBloc>(
                create: (context) => sl<NotesBloc>()..add(const NotesEvent.loadNotes()),
              )
            ],
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: GoRouterProvider.router,
              theme: isDarkTheme ? AppTheme.darkTheme : AppTheme.lightTheme,
            ),
          );
        },
      ),
    );
  }
}

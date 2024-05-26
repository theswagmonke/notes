import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:notes/src/feature/notes/model/note.dart';
import 'package:notes/src/feature/notes/widget/notes_screen.dart';
import 'package:notes/src/feature/notes/widget/note_info_screen.dart';

class GoRouterProvider {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    initialLocation: '/notesScreen',
    navigatorKey: _rootNavigatorKey,
    //debugLogDiagnostics: true,
    routes: <RouteBase>[
      GoRoute(
        path: '/notesScreen',
        name: 'notesScreen',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const NotesScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: '/noteInfoScreen',
        name: 'noteInfoScreen',
        pageBuilder: (BuildContext context, GoRouterState state) {
          final note = state.extra != null ? state.extra as Note : null;
          return CustomTransitionPage(
            key: state.pageKey,
            child: NoteInfoScreen(
              note: note,
            ),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
                child: child,
              );
            },
          );
        },
      ),
    ],
  );

  static GoRouter get router => _router;
}
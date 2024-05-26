import 'package:flutter/material.dart';

import 'theme_manager.dart';

class ThemeProvider extends InheritedNotifier<ThemeManager> {
  const ThemeProvider({
    required ThemeManager super.notifier,
    required super.child,
    super.key,
  });

  static ThemeManager of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ThemeProvider>()!.notifier!;

  @override
  bool updateShouldNotify(covariant InheritedNotifier<ThemeManager> oldWidget) {
    return oldWidget.notifier != notifier;
  }
}
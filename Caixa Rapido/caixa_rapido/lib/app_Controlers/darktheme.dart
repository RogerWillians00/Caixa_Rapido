import 'package:flutter/material.dart';

class ThemeProvider extends InheritedWidget {
  final bool isDarkTheme;
  final Function toggleTheme;

  const ThemeProvider({
    Key? key,
    required this.isDarkTheme,
    required this.toggleTheme,
    required Widget child,
  }) : super(key: key, child: child);

  static ThemeProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeProvider>();
  }

  @override
  bool updateShouldNotify(covariant ThemeProvider oldWidget) {
    return oldWidget.isDarkTheme != isDarkTheme;
  }
}
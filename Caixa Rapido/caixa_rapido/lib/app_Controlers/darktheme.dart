import 'package:flutter/material.dart';

class ThemeProvider extends InheritedWidget {
  // ================================================================
  // PROPRIEDADES
  // ================================================================
  final bool isDarkTheme;
  final Function toggleTheme;

  const ThemeProvider({
    Key? key,
    required this.isDarkTheme,
    required this.toggleTheme,
    required Widget child,
  }) : super(key: key, child: child);

  // ================================================================
  // METODO: Obter o ThemeProvider do contexto atual
  // ================================================================
  static ThemeProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeProvider>();
  }

  // ================================================================
  // METODO: Notificar os filhos quando o tema muda
  // ================================================================
  @override
  bool updateShouldNotify(covariant ThemeProvider oldWidget) {
    return oldWidget.isDarkTheme != isDarkTheme;
  }
}

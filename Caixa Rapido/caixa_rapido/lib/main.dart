import 'package:flutter/material.dart';
import 'app_Controlers/darktheme.dart';
import 'Screens/titleScreen.dart';
import 'Screens/nameScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // ================================================================
  // VARIAVEIS DE ESTADO
  // ================================================================
  bool isDarkTheme = false;

  // ================================================================
  // METODO: Alternar entre tema claro e escuro
  // ================================================================
  void toggleTheme() {
    setState(() {
      isDarkTheme = !isDarkTheme;
    });
  }

  // ================================================================
  // METODO: Montar o aplicativo
  // ================================================================
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      isDarkTheme: isDarkTheme,
      toggleTheme: toggleTheme,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: isDarkTheme ? ThemeData.dark() : ThemeData.light(),
        routes: _buildRoutes(),
      ),
    );
  }

  // ================================================================
  // METODO: Rotas de navegacao entre as telas
  // ================================================================
  Map<String, WidgetBuilder> _buildRoutes() {
    return {
      // É aqui que voce adiciona as rotas para os botoes navegarem
      '/': (context) => const TitleScreen(),
      '/name': (context) => const NameScreen(),
    };
  }
}

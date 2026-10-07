import 'package:flutter/material.dart';
import 'app_Controlers/darktheme.dart';
import 'app_Controlers/local_storage.dart';
import 'Screens/inventory_screen.dart';
import 'Screens/titleScreen.dart';
import 'Screens/nameScreen.dart';
import 'models/saved_app_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.initialize();
  final savedAppData = await LocalStorage.loadAppData();
  runApp(MyApp(savedAppData: savedAppData));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key, this.savedAppData}) : super(key: key);

  final SavedAppData? savedAppData;

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
        home: widget.savedAppData == null
            ? const TitleScreen()
            : InventoryScreen(initialData: widget.savedAppData),
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
      '/name': (context) => const NameScreen(),
      '/inventory': (context) => const InventoryScreen(),
    };
  }
}

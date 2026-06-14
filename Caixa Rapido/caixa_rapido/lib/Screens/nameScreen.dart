import 'dart:io'; // Importante para usar a classe File
import 'package:image_picker/image_picker.dart'; // Importa o pacote image_picker
import 'package:flutter/material.dart';
import '../app_Controlers/darktheme.dart';


class NameScreen extends StatefulWidget {
  const NameScreen({Key? key}) : super(key: key);

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final TextEditingController _controller = TextEditingController();
  
  // 1. Variáveis para controlar a imagem
 
  File? _image; 
  final ImagePicker _picker = ImagePicker();

  // 2. Função para abrir a galeria e selecionar a imagem
  
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50, // Mantendo a qualidade baixa para economizar RAM no iOS 12
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _onStartPressed(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = ThemeProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 30, 87, 39),
        centerTitle: true,
        title: const Text(
          'Para começar insira um nome para seu caixa',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        actions: [
          if (themeProvider != null)
            IconButton(
              icon: Icon(themeProvider.isDarkTheme
                  ? Icons.wb_sunny
                  : Icons.nightlight_round),
              onPressed: () {
                themeProvider.toggleTheme();
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 12),

              // 3. Foto circular atualizada
              GestureDetector(
                onTap: _pickImage, // Chama a função de selecionar foto
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.grey.shade300,
                  // Se _image não for nulo, exibe a foto selecionada
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                  child: _image == null
                      ? const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'clique aqui\nse quiser\ninserir uma\nfoto',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black87, fontSize: 18),
                          ),
                        )
                      : null, // Remove o texto quando há uma imagem
                ),
              ),

              const SizedBox(height: 28),

              const Text(
                'Não coletamos e NÃO PRECISAMOS de seus dados pessoais\nse quiser apenas insira "Caixa 1"',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),

              const SizedBox(height: 28),

              Container(
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Nome do Caixa (ex: Caixa 1)',
                  ),
                ),
              ),

              const SizedBox(height: 36),

              SizedBox(
                width: 260,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => _onStartPressed(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff0AB4FF),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  child: const Text(
                    'Começar',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

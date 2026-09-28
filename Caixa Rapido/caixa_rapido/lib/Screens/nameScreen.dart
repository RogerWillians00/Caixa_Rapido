import 'dart:io'; // Necessario para usar a classe File
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../app_Controlers/darktheme.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({Key? key}) : super(key: key);

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  // ================================================================
  // VARIAVEIS DE ESTADO
  // ================================================================
  final TextEditingController _controller = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _image;

  // ================================================================
  // METODO: Selecionar imagem da galeria
  // ================================================================
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      // Qualidade baixa para economizar memoria no iOS 12 e no iPad Air 1
      imageQuality: 50,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // ================================================================
  // METODO: Botao Comecar
  // ================================================================
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
    // ============================================================
    // CONFIGURAÇÕES DE RESPONSIVIDADE
    // ============================================================
    final size = MediaQuery.of(context).size;
    final screenHeight = size.height;
    final screenWidth = size.width;
    final isTablet = screenWidth > 600;
    final baseFontSize = isTablet ? 1.2 : 1.0;

    // ============================================================
    // CONSTANTES DE ESPACAMENTO
    // ============================================================
    final avatarRadius = isTablet ? 96.0 : 80.0;
    final smallSpacing = screenHeight * 0.015;
    final mediumSpacing = screenHeight * 0.03;
    final largeSpacing = screenHeight * 0.04;
    final horizontalPadding = screenWidth * 0.07;

    // ============================================================
    // CONSTANTES DE DIMENSOES FIXAS
    // ============================================================
    const fieldHeight = 56.0;
    const buttonWidth = 260.0;
    const buttonHeight = 56.0;

    // ============================================================
    // CONSTANTES DE CORES
    // ============================================================
    const appBarColor = Color.fromARGB(255, 30, 87, 39);
    const buttonColor = Color(0xff0AB4FF);
    const whiteColor = Color.fromARGB(255, 255, 255, 255);
    const placeholderColor = Color(0xffBDBDBD);
    const placeholderTextColor = Color(0xff212121);

    // ============================================================
    // CONFIGURACOES DA TELHA
    // ============================================================
    final themeProvider = ThemeProvider.of(context);

    // ============================================================
    // TELA PRINCIPAL
    // ============================================================
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        centerTitle: true,
        title: Text(
          'Para começar insira um nome para seu caixa',
          style: TextStyle(
            color: whiteColor,
            fontSize: 20 * baseFontSize,
          ),
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
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: mediumSpacing,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: smallSpacing),

              // ============================================================
              // SECAO: FOTO DO USUARIO
              // ============================================================
              _buildAvatarSection(avatarRadius, placeholderColor,
                  placeholderTextColor, baseFontSize),

              SizedBox(height: largeSpacing),

              // ============================================================
              // SECAO: AVISO DE PRIVACIDADE
              // ============================================================
              _buildPrivacyNoticeSection(baseFontSize),

              SizedBox(height: largeSpacing),

              // ============================================================
              // SECAO: CAMPO DE NOME DO CAIXA
              // ============================================================
              _buildNameFieldSection(
                fieldHeight,
                placeholderColor,
                baseFontSize,
              ),

              SizedBox(height: largeSpacing),

              // ============================================================
              // SECAO: BOTAO COMECAR
              // ============================================================
              _buildStartButtonSection(
                context,
                buttonWidth,
                buttonHeight,
                buttonColor,
                whiteColor,
                baseFontSize,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================================================================
  // WIDGET: Secao da Foto do Usuario
  // ================================================================
  Widget _buildAvatarSection(
    double avatarRadius,
    Color placeholderColor,
    Color placeholderTextColor,
    double baseFontSize,
  ) {
    return GestureDetector(
      onTap: _pickImage, // Abre a galeria para selecionar a foto
      child: CircleAvatar(
        radius: avatarRadius,
        backgroundColor: placeholderColor,
        // Exibe a foto selecionada, quando existir
        backgroundImage: _image != null ? FileImage(_image!) : null,
        child: _image == null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'clique aqui\nse quiser\ninserir uma\nfoto',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: placeholderTextColor,
                    fontSize: 18 * baseFontSize,
                  ),
                ),
              )
            : null, // Remove o texto quando ha uma imagem
      ),
    );
  }

  // ================================================================
  // WIDGET: Secao do Aviso de Privacidade
  // ================================================================
  Widget _buildPrivacyNoticeSection(double baseFontSize) {
    return Text(
      'Não coletamos e NÃO PRECISAMOS de seus dados pessoais\n'
      'se quiser apenas insira "Caixa 1"',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 18 * baseFontSize,
      ),
    );
  }

  // ================================================================
  // WIDGET: Secao do Campo de Nome do Caixa
  // ================================================================
  Widget _buildNameFieldSection(
    double fieldHeight,
    Color placeholderColor,
    double baseFontSize,
  ) {
    return Container(
      height: fieldHeight,
      decoration: BoxDecoration(
        color: placeholderColor,
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        controller: _controller,
        style: TextStyle(
          fontSize: 16 * baseFontSize,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Nome do Caixa (ex: Caixa 1)',
        ),
      ),
    );
  }

  // ================================================================
  // WIDGET: Secao do Botao Comecar
  // ================================================================
  Widget _buildStartButtonSection(
    BuildContext context,
    double buttonWidth,
    double buttonHeight,
    Color buttonColor,
    Color textColor,
    double baseFontSize,
  ) {
    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: () => _onStartPressed(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        child: Text(
          'Começar',
          style: TextStyle(
            fontSize: 20 * baseFontSize,
            color: textColor,
          ),
        ),
      ),
    );
  }
}

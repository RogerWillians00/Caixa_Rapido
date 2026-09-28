import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TitleScreen extends StatelessWidget {
  const TitleScreen({Key? key}) : super(key: key);

  void onStartPressed(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/name');
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

    // ============================================================
    // CONSTANTES DE ESPACAMENTO
    // ============================================================
    final topSpacing = screenHeight * 0.08;
    final titleSpacing = screenHeight * 0.015;
    final logoSize = isTablet ? screenWidth * 0.35 : 200.0;
    final baseFontSize = isTablet ? 1.2 : 1.0;
    final iconSize = isTablet ? 20.0 : 15.0;

    // ============================================================
    // CONSTANTES DE CORES
    // ============================================================
    const backgroundColor = Color(0xFF2A492F);
    const textColor = Color(0xFFC0C0C0);
    const titleColor = Color(0xff007C02);
    const whiteColor = Color.fromARGB(255, 255, 255, 255);

    // ============================================================
    // TELA PRINCIPAL
    // ============================================================
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Separacao do topo
                SizedBox(height: topSpacing),

                // ============================================================
                // SECAO: BOAS VINDAS
                // ============================================================
                _buildWelcomeSection(baseFontSize, textColor),

                SizedBox(height: titleSpacing),

                // ============================================================
                // SECAO: NOME DO APP
                // ============================================================
                _buildAppNameSection(baseFontSize, titleColor),

                SizedBox(height: screenHeight * 0.02),

                // ============================================================
                // SECAO: LOGO DO APP
                // ============================================================
                SvgPicture.asset(
                  'assets/images/appLogo.svg',
                  width: logoSize,
                  height: logoSize,
                ),

                SizedBox(height: screenHeight * 0.02),

                // ============================================================
                // SECAO: DISCLAIMER
                // ============================================================
                _buildDisclaimerSection(baseFontSize, whiteColor),

                SizedBox(height: screenHeight * 0.03),

                // ============================================================
                // SECAO: BOTAO DE CONTINUAR
                // ============================================================
                _buildStartButton(
                    context, screenWidth, screenHeight, baseFontSize),

                SizedBox(height: screenHeight * 0.04),

                // ============================================================
                // SECAO: CREDITOS E CONTATO
                // ============================================================
                _buildCreditsSection(baseFontSize, whiteColor, iconSize),

                SizedBox(height: screenHeight * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================================================================
  // WIDGET: Secao de Boas Vindas
  // ================================================================
  Widget _buildWelcomeSection(double baseFontSize, Color textColor) {
    return Column(
      children: [
        Text(
          "Bem-Vindo",
          style: TextStyle(
            fontSize: 35 * baseFontSize,
            color: textColor,
          ),
        ),
        Text(
          "ao",
          style: TextStyle(
            fontSize: 30 * baseFontSize,
            color: textColor,
          ),
        ),
      ],
    );
  }

  // ================================================================
  // WIDGET: Secao do Nome do App
  // ================================================================
  Widget _buildAppNameSection(double baseFontSize, Color titleColor) {
    return Column(
      children: [
        Text(
          "Caixa",
          style: TextStyle(
            fontSize: 50 * baseFontSize,
            fontFamily: 'impact',
            color: titleColor,
          ),
        ),
        Text(
          "Rapido",
          style: TextStyle(
            fontSize: 40 * baseFontSize,
            color: titleColor,
          ),
        ),
      ],
    );
  }

  // ================================================================
  // WIDGET: Secao de Disclaimer
  // ================================================================
  Widget _buildDisclaimerSection(double baseFontSize, Color textColor) {
    return Text(
      "Este app foi pensado para você que precisa registrar suas vendas do dia a dia de maneira rápida e fácil.",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16 * baseFontSize,
        color: textColor,
      ),
    );
  }

  // ================================================================
  // WIDGET: Botao Começar
  // ================================================================
  Widget _buildStartButton(
    BuildContext context,
    double screenWidth,
    double screenHeight,
    double baseFontSize,
  ) {
    return ElevatedButton(
      onPressed: () => onStartPressed(context),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.1,
          vertical: screenHeight * 0.015,
        ),
      ),
      child: Text(
        'Começar',
        style: TextStyle(fontSize: 18 * baseFontSize),
      ),
    );
  }

  // ================================================================
  // WIDGET: Secao de Creditos e Contato
  // ================================================================
  Widget _buildCreditsSection(
      double baseFontSize, Color textColor, double iconSize) {
    return Column(
      children: [
        Text(
          "Desenvolvido por.",
          style: TextStyle(
            fontSize: 15 * baseFontSize,
            color: textColor,
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icone LinkedIn
            SvgPicture.asset(
              'assets/images/linkedinIcon.svg',
              width: iconSize,
              height: iconSize,
              color: const Color(0xffC0C0C4),
            ),
            Text(
              ' in/rogerw00/       ',
              style: TextStyle(
                color: const Color(0xffC0C0C1),
                fontSize: 14 * baseFontSize,
              ),
            ),
            // Icone GitHub
            SvgPicture.asset(
              'assets/images/githubIcon.svg',
              width: iconSize,
              height: iconSize,
              color: const Color(0xffC0C0C0),
            ),
            Text(
              ' /RogerWillians00',
              style: TextStyle(
                color: const Color(0xffC0C0C0),
                fontSize: 14 * baseFontSize,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

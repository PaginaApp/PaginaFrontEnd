import 'package:flutter/material.dart';
import 'package:projeto_pagina/telas/cadastro.dart';
import 'package:projeto_pagina/telas/login.dart';

class SplashArt extends StatefulWidget {
  const SplashArt({super.key});

  @override
  State<SplashArt> createState() => _SplashArtState();
}

class _SplashArtState extends State<SplashArt> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xfff6f5f2),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: screenWidth,
              height: screenHeight * 2.2 / 3,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/png/background_splash_art.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildText("Venha fazer ", 28.5, const Color(0xff14131a)),
                _buildText("parte da", 28.5, const Color(0xff14131a)),
                _buildText("comunidade", 28.5, const Color(0xff14131a)),
                _buildText("da PÁGINA", 28.5, const Color(0xff14131a)),
                SizedBox(
                  height: screenHeight * 0.1,
                ),
                Center(
                  child: Image.asset(
                    'assets/png/pessoas_com_livros.png',
                    width: screenWidth * 0.6,
                    height: screenHeight * 0.22,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.1,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(screenWidth * 0.05),
                        backgroundColor: const Color(0xff1f1d34),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: _buildText("Entrar", 16.5, const Color(0xfff6f5f2),
                          isBold: true),
                    ),
                    SizedBox(
                      height: screenHeight * 0.04,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Cadastro()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(screenWidth * 0.05),
                        backgroundColor: const Color(0xfff6f5f2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: const BorderSide(
                            color: Color(0xff1f1d34),
                            width: 3.0,
                          ),
                        ),
                      ),
                      child: _buildText(
                          "Cadastrar-se", 16.5, const Color(0xff1f1d34),
                          isBold: true),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildText(String text, double fontSize, Color color,
      {bool isBold = false}) {
    double screenWidth = MediaQuery.of(context).size.width;

    double responsiveFontSize(double fontSize) {
      return fontSize * screenWidth / 375.0;
    }

    return Text(
      text,
      style: TextStyle(
        fontSize: responsiveFontSize(fontSize),
        fontFamily: 'Poppins',
        color: color,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:projeto_pagina/telas/splash_art.dart';

class ConfiguracoesExcluir1 extends StatefulWidget {
  const ConfiguracoesExcluir1({super.key});

  @override
  State<ConfiguracoesExcluir1> createState() => _ConfiguracoesExcluir1State();
}

class _ConfiguracoesExcluir1State extends State<ConfiguracoesExcluir1> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double responsiveFontSize(double fontSize) {
      return fontSize * screenWidth / 375;
    }

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.1),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.1),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xff4f5071),
                      width: screenWidth * 0.0025,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: const Color(0xff3ab45d),
                        size: responsiveFontSize(60.0),
                      ),
                      Text(
                        'Tudo certo!',
                        style: TextStyle(
                          fontSize: responsiveFontSize(19.0),
                          color: const Color(0xff14131a),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      Text(
                        'Sua conta foi excluída',
                        style: TextStyle(
                          fontSize: responsiveFontSize(14.0),
                          color: const Color(0xff14131a),
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.005),
                      Text(
                        'com sucesso.',
                        style: TextStyle(
                          fontSize: responsiveFontSize(14.0),
                          color: const Color(0xff14131a),
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SplashArt()),
                            (Route<dynamic> route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff3ab45d),
                          foregroundColor: const Color(0xfff6f5f2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          "Ok!",
                          style: TextStyle(
                            fontSize: responsiveFontSize(16.0),
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

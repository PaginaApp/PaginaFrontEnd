import 'package:flutter/material.dart';

class ConfiguracoesSuporte extends StatefulWidget {
  const ConfiguracoesSuporte({super.key});

  @override
  State<ConfiguracoesSuporte> createState() => _ConfiguracoesSuporteState();
}

class _ConfiguracoesSuporteState extends State<ConfiguracoesSuporte> {
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
                        Icons.cancel,
                        color: const Color(0xffcd4e4e),
                        size: responsiveFontSize(60.0),
                      ),
                      Text(
                        'Atenção!',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: const Color(0xff14131a),
                          fontSize: responsiveFontSize(19.0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      Text(
                        'Você será direcionado',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: const Color(0xff14131a),
                          fontSize: responsiveFontSize(14.0),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.005),
                      Text(
                        'para nosso',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: const Color(0xff14131a),
                          fontSize: responsiveFontSize(14.0),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.005),
                      Text(
                        'chat de suporte.',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: const Color(0xff14131a),
                          fontSize: responsiveFontSize(14.0),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.005),
                      Text(
                        'Tem certeza disso?',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: const Color(0xff14131a),
                          fontSize: responsiveFontSize(14.0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                side: BorderSide(
                                  color: const Color(0xffcd4e4e),
                                  width: screenWidth * 0.005,
                                ),
                              ),
                            ),
                            child: Text(
                              "Cancelar",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: responsiveFontSize(16.0),
                                color: const Color(0xffcd4e4e),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // ir para tela de suporte
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff4e90cd),
                              foregroundColor: const Color(0xfff6f5f2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Text(
                              "Ok!",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: responsiveFontSize(16.0),
                              ),
                            ),
                          ),
                        ],
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

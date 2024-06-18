// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:projeto_pagina/services/authentication_service.dart';
import 'package:projeto_pagina/telas/configuracoes_excluir_1.dart';

class ConfiguracoesExcluir extends StatefulWidget {
  const ConfiguracoesExcluir({super.key});

  @override
  State<ConfiguracoesExcluir> createState() => _ConfiguracoesExcluirState();
}

class _ConfiguracoesExcluirState extends State<ConfiguracoesExcluir> {
  final TextEditingController _controller = TextEditingController();
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
                        'Sua conta será excluída e',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: const Color(0xff14131a),
                          fontSize: responsiveFontSize(14.0),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.005),
                      Text(
                        'você perderá todos os dados.',
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
                      SizedBox(height: screenHeight * 0.005),
                      Text(
                        'Digite aceito para confirmar.',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: const Color(0xff14131a),
                          fontSize: responsiveFontSize(14.0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      TextFormField(
                        controller: _controller,
                        maxLength: 6,
                        decoration: InputDecoration(
                          hintText: 'aceito',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: screenHeight * 0.02),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xff1f1d34),
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xff1f1d34),
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: responsiveFontSize(17.0),
                            fontWeight: FontWeight.bold,
                          ),
                          hintStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: responsiveFontSize(13.5),
                          ),
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
                            onPressed: _controller.text != 'aceito'
                                ? null
                                : () async {
                                    bool success =
                                        await _handleDeleteUserAccount() &&
                                            _controller.text == 'aceito';

                                    if (success && mounted) {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Conta excluída com sucesso!',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize:
                                                  responsiveFontSize(16.0),
                                            ),
                                          ),
                                          duration: const Duration(seconds: 5),
                                          backgroundColor:
                                              const Color(0xff4ecd72),
                                        ),
                                      );
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ConfiguracoesExcluir1(),
                                        ),
                                        (Route<dynamic> route) => false,
                                      );
                                    } else if (mounted) {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Erro ao excluir conta!',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize:
                                                  responsiveFontSize(16.0),
                                            ),
                                          ),
                                          duration: const Duration(seconds: 5),
                                          backgroundColor:
                                              const Color(0xffcd4e4e),
                                        ),
                                      );
                                    }
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

  Future<bool> _handleDeleteUserAccount() async {
    try {
      await AuthenticationService().deleteUserAccount();
      return true;
    } catch (e) {
      return false;
    }
  }
}

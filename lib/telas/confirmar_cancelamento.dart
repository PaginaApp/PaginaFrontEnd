// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:projeto_pagina/services/transacao_service.dart';
import 'package:projeto_pagina/telas/home.dart';

class ConfirmarCancelamento extends StatefulWidget {
  final String transacaoId;

  const ConfirmarCancelamento({Key? key, required this.transacaoId})
      : super(key: key);

  @override
  State<ConfirmarCancelamento> createState() => _ConfirmarCancelamentoState();
}

class _ConfirmarCancelamentoState extends State<ConfirmarCancelamento> {
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
                        'Você cancelará',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: const Color(0xff14131a),
                          fontSize: responsiveFontSize(14.0),
                        ),
                      ),
                      Text(
                        'a negociação',
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
                              "Voltar",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: responsiveFontSize(16.0),
                                color: const Color(0xffcd4e4e),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              bool success = await _handleCancelarTransacao();

                              if (success && mounted) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Home()),
                                  (Route<dynamic> route) => false,
                                );

                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Cancelamento efetuado com sucesso!',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: responsiveFontSize(16.0),
                                      ),
                                    ),
                                    duration: const Duration(seconds: 5),
                                    backgroundColor: const Color(0xff4ecd72),
                                  ),
                                );
                              } else if (mounted) {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Erro ao cancelar a transação. Tente novamente mais tarde',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: responsiveFontSize(16.0),
                                      ),
                                    ),
                                    duration: const Duration(seconds: 5),
                                    backgroundColor: const Color(0xffec4e4e),
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

  Future<bool> _handleCancelarTransacao() async {
    try {
      await TransacaoService().cancelarTransacao(widget.transacaoId);
      return true;
    } catch (e) {
      return false;
    }
  }
}

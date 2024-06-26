// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:projeto_pagina/services/authentication_service.dart';
import 'package:projeto_pagina/telas/termos_de_uso_certo.dart';
import 'package:projeto_pagina/telas/termos_de_uso_errado.dart';

class TermosDeUso extends StatefulWidget {
  final String name;
  final String birthDate;
  final String cpf;
  final String phoneNumber;
  final String email;
  final String password;
  final String cep;
  final String city;
  final String neighborhood;
  final String street;
  final String number;
  final String state;
  final String complement;

  const TermosDeUso({
    Key? key,
    required this.name,
    required this.birthDate,
    required this.cpf,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.cep,
    required this.city,
    required this.neighborhood,
    required this.street,
    required this.number,
    required this.state,
    required this.complement,
  }) : super(key: key);

  @override
  State<TermosDeUso> createState() => _TermosDeUsoState();
}

class _TermosDeUsoState extends State<TermosDeUso> {
  bool concordo = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double responsiveFontSize(double fontSize) {
      return fontSize * screenWidth / 375.0;
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: screenHeight / 7.5,
            color: const Color(0xff4f5071),
            padding: EdgeInsets.only(
                left: screenWidth * 0.06, top: screenWidth * 0.075),
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Termos de Uso e',
                  style: TextStyle(
                    color: const Color(0xfff6f5f2),
                    fontSize: responsiveFontSize(23.7),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Política de privacidade',
                  style: TextStyle(
                    color: const Color(0xfff6f5f2),
                    fontSize: responsiveFontSize(23.7),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(screenWidth * 0.08),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.all(screenWidth * 0.03),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xff4f5071),
                        width: screenWidth * 0.0025,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non risus. Suspendisse lectus tortor, dignissim sit amet, adipiscing nec, ultricies sed, dolor. Cras elementum ultrices diam. Maecenas ligula massa, varius a, semper congue, euismod non, mi. Proin porttitor, orci nec nonummy molestie, enim est eleifend mi, non fermentum diam nisl sit amet erat. Duis semper. Duis arcu massa, scelerisque vitae, consequat in, pretium a, enim. Pellentesque congue. Ut in risus volutpat libero pharetra tempor. Cras vestibulum bibendum augue. Praesent egestas leo in pede. Praesent blandit odio eu enim. Pellentesque sed dui ut augue blandit sodales. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Aliquam nibh. Mauris ac mauris sed pede pellentesque fermentum. Maecenas adipiscing ante non diam sodales hendrerit. Nullam lectus justo, vulputate eget mollis sed, tempor sed magna. Nam at tortor in tellus interdum sagittis. Nunc dapibus ligula ac leo ullamcorper, eget tristique velit tincidunt. Curabitur nec dui nec libero eleifend tincidunt. Vivamus euismod, ligula vel rhoncus imperdiet, odio justo semper lacus, id consectetur quam elit at ligula. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum. Praesent mauris. Fusce nec tellus sed augue semper porta. Mauris massa. Vestibulum lacinia arcu eget nulla. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.',
                      style: TextStyle(
                        fontSize: responsiveFontSize(15.0),
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              concordo = !concordo;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.02,
                                horizontal: screenWidth * 0.02),
                            child: Row(
                              children: [
                                concordo
                                    ? const Icon(
                                        Icons.check_box,
                                        color: Color(0xff1f1d34),
                                      )
                                    : const Icon(
                                        Icons.check_box_outline_blank,
                                        color: Color(0xff1f1d34),
                                      ),
                                SizedBox(width: screenWidth * 0.015),
                                Text(
                                  "Li e concordo",
                                  style: TextStyle(
                                      color: const Color(0xff1f1d34),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize: responsiveFontSize(15.0)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: concordo
                          ? () async {
                              bool registerSuccess = await _handleRegister();
                              if (registerSuccess && mounted) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const TermosDeUsoCerto()),
                                );
                              } else if (mounted) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const TermosDeUsoErrado()),
                                );
                              }
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff4e90cd),
                        foregroundColor: const Color(0xfff6f5f2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        "Criar conta",
                        style: TextStyle(
                          fontSize: responsiveFontSize(17.0),
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Voltar",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Color(0xff1f1d34),
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
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
    );
  }

  Future<bool> _handleRegister() async {
    try {
      await AuthenticationService().registerUserAndAdress(
        widget.name,
        widget.birthDate,
        widget.cpf,
        widget.phoneNumber,
        widget.email,
        widget.password,
        widget.cep,
        widget.city,
        widget.neighborhood,
        widget.street,
        widget.number,
        widget.state,
        widget.complement,
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}

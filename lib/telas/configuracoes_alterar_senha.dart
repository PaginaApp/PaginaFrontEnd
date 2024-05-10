import 'package:flutter/material.dart';
import 'package:projeto_pagina/services/authentication_service.dart';

class ConfiguracoesAlterarSenha extends StatefulWidget {
  const ConfiguracoesAlterarSenha({super.key});

  @override
  State<ConfiguracoesAlterarSenha> createState() =>
      _ConfiguracoesAlterarSenhaState();
}

class _ConfiguracoesAlterarSenhaState extends State<ConfiguracoesAlterarSenha> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double responsiveFontSize(double fontSize) {
      return fontSize * screenWidth / 375.0;
    }

    // ignore: no_leading_underscores_for_local_identifiers
    String? _validateRequiredField(String? value) {
      if (value == null || value.isEmpty) {
        return 'Campo obrigatório';
      }
      return null;
    }

    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                backgroundColor: const Color(0xfff6f5f2),
                iconTheme: const IconThemeData(color: Color(0xff4e90cd)),
                title: Text(
                  'Alterar Senha',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: responsiveFontSize(20),
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff14131a),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: screenHeight * 0.05),
                    TextFormField(
                      controller: _currentPasswordController,
                      maxLength: 100,
                      validator: _validateRequiredField,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Senha Atual',
                        hintText: 'Insira sua senha atual...',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: screenHeight * 0.02),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: responsiveFontSize(18.0),
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff14131a),
                        ),
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: responsiveFontSize(13.5),
                          color: const Color(0xff14131a),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    TextFormField(
                      controller: _newPasswordController,
                      maxLength: 100,
                      validator: _validateRequiredField,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Nova Senha',
                        hintText: 'Insira uma nova senha...',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: screenHeight * 0.02),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xff1f1d34),
                          ), // Cor quando a caixa é selecionada
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xff1f1d34),
                          ), // Cor quando a caixa não é selecionada
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: responsiveFontSize(18.0),
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff14131a),
                        ),
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: responsiveFontSize(13.5),
                          color: const Color(0xff14131a),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    TextFormField(
                      controller: _confirmPasswordController,
                      maxLength: 100,
                      validator: _validateRequiredField,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Confirme a Senha',
                        hintText: 'Repita a senha...',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: screenHeight * 0.02),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: responsiveFontSize(18.0),
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff14131a),
                        ),
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: responsiveFontSize(13.5),
                          color: const Color(0xff14131a),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.3),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                              onPressed: () async {
                                // verifica se as senhas são iguais
                                if (_newPasswordController.text !=
                                    _confirmPasswordController.text) {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "As senhas não coincidem.",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: responsiveFontSize(16.0),
                                        ),
                                      ),
                                      duration: const Duration(seconds: 5),
                                      backgroundColor: const Color(0xffcd4e4e),
                                    ),
                                  );
                                } else {
                                  // se as senhas são iguais
                                  bool success = await _handleChangePassword();

                                  // se a senha foi alterada com sucesso
                                  if (success &&
                                      mounted &&
                                      _formKey.currentState!.validate()) {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Senha alterada com sucesso!',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: responsiveFontSize(16.0),
                                          ),
                                        ),
                                        duration: const Duration(seconds: 5),
                                        backgroundColor:
                                            const Color(0xff4ecd72),
                                      ),
                                    );
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            super.widget,
                                      ),
                                    );
                                  } else if (mounted) {
                                    // se não foi possível alterar a senha
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Erro ao alterar a senha.',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: responsiveFontSize(16.0),
                                          ),
                                        ),
                                        duration: const Duration(seconds: 5),
                                        backgroundColor:
                                            const Color(0xffcd4e4e),
                                      ),
                                    );
                                  }
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
                                "Salvar",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: responsiveFontSize(16.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     // if (_formKey.currentState?.validate() ?? false) {
                        //     //   Navigator.push(
                        //     //     context,
                        //     //     MaterialPageRoute(
                        //     //         builder: (context) => const Cadastro1()),
                        //     //   );
                        //     // }
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _handleChangePassword() async {
    try {
      await AuthenticationService().changePassword(
          _currentPasswordController.text, _newPasswordController.text);
      return true;
    } catch (e) {
      return false;
    }
  }
}

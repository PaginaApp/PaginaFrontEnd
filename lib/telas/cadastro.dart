import 'package:flutter/material.dart';
import 'package:projeto_pagina/services/authentication_service.dart';
import 'package:projeto_pagina/telas/cadastro_1.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthDateController =
      MaskedTextController(mask: '00/00/0000');
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
              Container(
                height: screenHeight / 9.5,
                color: const Color(0xff4f5071),
                padding: EdgeInsets.only(
                    left: screenWidth * 0.06, top: screenWidth * 0.03),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Cadastro',
                  style: TextStyle(
                    color: const Color(0xfff6f5f2),
                    fontSize: responsiveFontSize(23.7),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: const Color(0xff4f5071),
                          size: responsiveFontSize(23.7),
                        ),
                        SizedBox(width: screenWidth * 0.01),
                        Text(
                          'Dados Pessoais',
                          style: TextStyle(
                            fontSize: responsiveFontSize(22.0),
                            color: const Color(0xff14131a),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    TextFormField(
                      controller: _nameController,
                      maxLength: 100,
                      validator: _validateRequiredField,
                      decoration: InputDecoration(
                        labelText: 'Nome completo',
                        hintText: 'Insira seu nome completo',
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
                          fontSize: responsiveFontSize(17.0),
                          fontFamily: 'Poppins',
                          color: const Color(0xff14131a),
                          fontWeight: FontWeight.bold,
                        ),
                        hintStyle: TextStyle(
                          fontSize: responsiveFontSize(13.5),
                          fontFamily: 'Poppins',
                          color: const Color(0xff14131a),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _birthDateController,
                            // PERGUNTAR O QUE VAI RECEBER NA DATA DE NASC
                            maxLength: 10,
                            validator: _validateRequiredField,
                            keyboardType: TextInputType.datetime,
                            // inputFormatters: [
                            //   FilteringTextInputFormatter.digitsOnly
                            // ],
                            decoration: InputDecoration(
                              labelText: 'Data de Nascimento',
                              hintText: '00/00/0000',
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
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelStyle: TextStyle(
                                fontSize: responsiveFontSize(17.0),
                                fontFamily: 'Poppins',
                                color: const Color(0xff14131a),
                                fontWeight: FontWeight.bold,
                              ),
                              hintStyle: TextStyle(
                                fontSize: responsiveFontSize(13.5),
                                fontFamily: 'Poppins',
                                color: const Color(0xff14131a),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.035,
                          height: screenHeight * 0.12,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _cpfController,
                            maxLength: 11,
                            validator: _validateRequiredField,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              // PERGUNTAR O QUE VAI RECEBER NO CPF
                              labelText: 'CPF',
                              hintText: '000.000.000-00',
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
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelStyle: TextStyle(
                                fontSize: responsiveFontSize(17.0),
                                fontFamily: 'Poppins',
                                color: const Color(0xff14131a),
                                fontWeight: FontWeight.bold,
                              ),
                              hintStyle: TextStyle(
                                fontSize: responsiveFontSize(13.5),
                                fontFamily: 'Poppins',
                                color: const Color(0xff14131a),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      controller: _phoneNumberController,
                      maxLength: 11,
                      validator: _validateRequiredField,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        // PERGUNTAR O QUE VAI RECEBER AQUI
                        labelText: 'Telefone',
                        hintText: '(00) 90000-0000',
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
                          fontSize: responsiveFontSize(17.0),
                          fontFamily: 'Poppins',
                          color: const Color(0xff14131a),
                          fontWeight: FontWeight.bold,
                        ),
                        hintStyle: TextStyle(
                          fontSize: responsiveFontSize(13.5),
                          fontFamily: 'Poppins',
                          color: const Color(0xff14131a),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    TextFormField(
                      controller: _emailController,
                      maxLength: 100,
                      validator: _validateRequiredField,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'usuario123@email.com',
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
                          fontSize: responsiveFontSize(17.0),
                          fontFamily: 'Poppins',
                          color: const Color(0xff14131a),
                          fontWeight: FontWeight.bold,
                        ),
                        hintStyle: TextStyle(
                          fontSize: responsiveFontSize(13.5),
                          fontFamily: 'Poppins',
                          color: const Color(0xff14131a),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _passwordController,
                            maxLength: 100,
                            validator: _validateRequiredField,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Senha',
                              hintText: 'Insira uma senha',
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
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelStyle: TextStyle(
                                fontSize: responsiveFontSize(17.0),
                                fontFamily: 'Poppins',
                                color: const Color(0xff14131a),
                                fontWeight: FontWeight.bold,
                              ),
                              hintStyle: TextStyle(
                                fontSize: responsiveFontSize(13.5),
                                fontFamily: 'Poppins',
                                color: const Color(0xff14131a),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.035,
                          height: screenHeight * 0.12,
                        ),
                        Expanded(
                          child: TextFormField(
                            maxLength: 100,
                            validator: _validateRequiredField,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Confirme a senha',
                              hintText: 'Repita a senha',
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
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelStyle: TextStyle(
                                fontSize: responsiveFontSize(17.0),
                                fontFamily: 'Poppins',
                                color: const Color(0xff14131a),
                                fontWeight: FontWeight.bold,
                              ),
                              hintStyle: TextStyle(
                                fontSize: responsiveFontSize(13.5),
                                fontFamily: 'Poppins',
                                color: const Color(0xff14131a),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Cadastro1(
                                          name: _nameController.text,
                                          birthDate: _birthDateController.text,
                                          cpf: _cpfController.text,
                                          phoneNumber:
                                              _phoneNumberController.text,
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                        )),
                              );
                            }

                            // temporario
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => const Cadastro1()),
                            // );
                            // AuthenticationService().registerUser(
                            //   _nameController.text,
                            //   _emailController.text,
                            //   _passwordController.text,
                            //   _phoneNumberController.text,
                            //   _birthDateController.text,
                            //   _cpfController.text,
                            // );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff4e90cd),
                            foregroundColor: const Color(0xfff6f5f2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            "Próximo",
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
                            "Cancelar",
                            style: TextStyle(
                              color: Color(0xff1f1d34),
                              fontFamily: 'Poppins',
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
        ),
      ),
    );
  }
}

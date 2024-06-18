import 'package:flutter/material.dart';
import 'package:projeto_pagina/services/via_cep_service.dart';
import 'package:projeto_pagina/telas/termos_de_uso.dart';

class Cadastro1 extends StatefulWidget {
  final String name;
  final String birthDate;
  final String cpf;
  final String phoneNumber;
  final String email;
  final String password;

  const Cadastro1({
    Key? key,
    required this.name,
    required this.birthDate,
    required this.cpf,
    required this.phoneNumber,
    required this.email,
    required this.password,
  }) : super(key: key);

  @override
  State<Cadastro1> createState() => _Cadastro1State();
}

class _Cadastro1State extends State<Cadastro1> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _neighborhoodController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _complementController = TextEditingController();

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
                          Icons.location_on,
                          color: const Color(0xff4f5071),
                          size: responsiveFontSize(23.7),
                        ),
                        SizedBox(width: screenWidth * 0.01),
                        Text(
                          'Endereço',
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
                      controller: _cepController,
                      maxLength: 8,
                      validator: _validateRequiredField,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'CEP',
                        hintText: '00000000',
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
                          fontSize: responsiveFontSize(19.5),
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
                    SizedBox(height: screenHeight * 0.01),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            getAddressByCep();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff4e90cd),
                            foregroundColor: const Color(0xfff6f5f2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            "Buscar CEP",
                            style: TextStyle(
                              fontSize: responsiveFontSize(17.0),
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    TextFormField(
                      controller: _cityController,
                      maxLength: 100,
                      validator: _validateRequiredField,
                      decoration: InputDecoration(
                        labelText: 'Cidade',
                        hintText: 'Ex: Campinas',
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
                          fontSize: responsiveFontSize(19.5),
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
                    SizedBox(height: screenHeight * 0.01),
                    TextFormField(
                      controller: _neighborhoodController,
                      maxLength: 100,
                      validator: _validateRequiredField,
                      decoration: InputDecoration(
                        labelText: 'Bairro',
                        hintText: 'Ex: Bonfim',
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
                          fontSize: responsiveFontSize(19.5),
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
                    SizedBox(height: screenHeight * 0.01),
                    TextFormField(
                      controller: _streetController,
                      maxLength: 100,
                      validator: _validateRequiredField,
                      decoration: InputDecoration(
                        labelText: 'Rua',
                        hintText: 'Ex: Avenida Americana',
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
                          fontSize: responsiveFontSize(19.5),
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
                            controller: _numberController,
                            maxLength: 100000,
                            validator: _validateRequiredField,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Número',
                              hintText: '00',
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
                                fontSize: responsiveFontSize(19.5),
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
                          height: screenHeight * 0.11,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _stateController,
                            maxLength: 2,
                            validator: _validateRequiredField,
                            decoration: InputDecoration(
                              labelText: 'Estado',
                              hintText: 'Ex: SP',
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
                                fontSize: responsiveFontSize(19.5),
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
                      controller: _complementController,
                      maxLength: 100,
                      decoration: InputDecoration(
                        labelText: 'Complemento',
                        hintText: 'Ex: Bloco 17, ap. 11',
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
                          fontSize: responsiveFontSize(19.5),
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TermosDeUso(
                                    name: widget.name,
                                    birthDate: widget.birthDate,
                                    cpf: widget.cpf,
                                    phoneNumber: widget.phoneNumber,
                                    email: widget.email,
                                    password: widget.password,
                                    cep: _cepController.text,
                                    city: _cityController.text,
                                    neighborhood: _neighborhoodController.text,
                                    street: _streetController.text,
                                    number: _numberController.text,
                                    state: _stateController.text,
                                    complement:
                                        _complementController.text.isEmpty
                                            ? "Nada"
                                            : _complementController.text,
                                  ),
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
        ),
      ),
    );
  }

  void getAddressByCep() async {
    if (_cepController.text.isNotEmpty) {
      final response =
          await ViaCepService().getAddressByCep(_cepController.text);
      _cityController.text = response['localidade'];
      _neighborhoodController.text = response['bairro'];
      _streetController.text = response['logradouro'];
      _stateController.text = response['uf'];
    }
  }
}

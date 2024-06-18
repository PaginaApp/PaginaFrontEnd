// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:projeto_pagina/data/models/dados_pessoais_model.dart';
import 'package:projeto_pagina/data/models/endereco_model.dart';
import 'package:projeto_pagina/services/dados_pessoais_service.dart';
import 'package:projeto_pagina/services/endereco_service.dart';
import 'package:projeto_pagina/services/via_cep_service.dart';
import 'package:intl/intl.dart';

class ConfiguracoesMeusDados extends StatefulWidget {
  final String? userId;
  final String? token;

  const ConfiguracoesMeusDados(
      {Key? key, required this.userId, required this.token})
      : super(key: key);

  @override
  State<ConfiguracoesMeusDados> createState() => _ConfiguracoesMeusDadosState();
}

class _ConfiguracoesMeusDadosState extends State<ConfiguracoesMeusDados> {
  bool _isEditingAddress = false;
  bool _isEditingPersonalData = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _neighborhoodController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _complementController = TextEditingController();

  final EnderecoService _enderecoService = EnderecoService();
  final DadosPessoaisService _dadosPessoaisService = DadosPessoaisService();
  late Future<EnderecoModel> _enderecoFuture;
  late Future<DadosPessoaisModel> _dadosPessoaisFuture;

  @override
  void initState() {
    super.initState();
    _enderecoFuture = _enderecoService.fetchEndereco(widget.userId ?? '');
    _dadosPessoaisFuture =
        _dadosPessoaisService.fetchDadosPessoais(widget.userId ?? '');
  }

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
      backgroundColor: const Color(0xfff6f5f2),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                backgroundColor: const Color(0xfff6f5f2),
                iconTheme: const IconThemeData(color: Color(0xff4e90cd)),
                title: Text(
                  'Meus Dados',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: responsiveFontSize(18),
                    color: const Color(0xff14131a),
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
                        Text(
                          'Dados Pessoais',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: responsiveFontSize(22.0),
                            color: const Color(0xff14131a),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.05),

                    // começo da parte de dados pessoais
                    // ==================================================

                    FutureBuilder<DadosPessoaisModel>(
                      future: _dadosPessoaisFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Falha ao carregar, tente novamente.',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: responsiveFontSize(15.0),
                                ),
                              ),
                            ],
                          );
                        } else {
                          final dadosPessoais = snapshot.data!;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TextFormField(
                                enabled: false,
                                decoration: InputDecoration(
                                  labelText: 'Nome completo',
                                  // substituir esse hintText pelo nome do usuário
                                  hintText: dadosPessoais.nome,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: screenHeight * 0.02),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      enabled: false,
                                      decoration: InputDecoration(
                                        labelText: 'Data de Nascimento',
                                        // substituir esse hintText pela data de nascimento do usuário
                                        hintText: DateFormat('dd/MM/yyyy')
                                            .format(DateTime.parse(
                                                dadosPessoais.dataNascimento)),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: screenHeight * 0.02),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
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
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.035,
                                    height: screenHeight * 0.12,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      enabled: false,
                                      decoration: InputDecoration(
                                        labelText: 'CPF',
                                        // substituir esse hintText pelo CPF do usuário
                                        hintText: dadosPessoais.cpf,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: screenHeight * 0.02),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
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
                                  ),
                                ],
                              ),
                              TextFormField(
                                controller: _phoneController,
                                maxLength: 11,
                                validator: _validateRequiredField,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  labelText: 'Telefone',
                                  hintText: dadosPessoais.telefone,
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
                              TextFormField(
                                enabled: false,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  // substituir esse hintText pelo email do usuário
                                  hintText: dadosPessoais.email,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: screenHeight * 0.02),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
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
                              SizedBox(height: screenHeight * 0.04),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (_isEditingPersonalData)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              _isEditingPersonalData = false;
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            foregroundColor: Colors.red,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
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
                                              fontSize:
                                                  responsiveFontSize(16.0),
                                              color: const Color(0xffcd4e4e),
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            setState(() {
                                              _isEditingPersonalData = false;
                                            });

                                            bool success =
                                                await _handleUpdateUser();

                                            if (success && mounted) {
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentSnackBar();

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Dados pessoais atualizados com sucesso!',
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize:
                                                          responsiveFontSize(
                                                              17.0),
                                                    ),
                                                  ),
                                                  duration: const Duration(
                                                      seconds: 5),
                                                  backgroundColor:
                                                      const Color(0xff4ecd72),
                                                ),
                                              );

                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          super.widget,
                                                ),
                                              );
                                            } else if (mounted) {
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentSnackBar();

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Erro ao atualizar dados pessoais',
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize:
                                                          responsiveFontSize(
                                                              17.0),
                                                    ),
                                                  ),
                                                  duration: const Duration(
                                                      seconds: 5),
                                                  backgroundColor:
                                                      const Color(0xffcd4e4e),
                                                ),
                                              );
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xff4e90cd),
                                            foregroundColor:
                                                const Color(0xfff6f5f2),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                          child: Text(
                                            "Salvar",
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize:
                                                  responsiveFontSize(16.0),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  if (!_isEditingPersonalData)
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          _isEditingPersonalData = true;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xff4e90cd),
                                        foregroundColor:
                                            const Color(0xfff6f5f2),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                      child: Text(
                                        "Alterar dados pessoais",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: responsiveFontSize(16.0),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          );
                        }
                      },
                    ),

                    // fim da parte de dados pessoais
                    // -------------------------------------------------------------------------

                    SizedBox(height: screenHeight * 0.04),
                    Row(
                      children: [
                        SizedBox(width: screenWidth * 0.01),
                        Text(
                          'Endereço',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: responsiveFontSize(22.0),
                            color: const Color(0xff14131a),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.05),

                    // ==================================================
                    FutureBuilder<EnderecoModel>(
                      future: _enderecoFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Falha ao carregar, tente cadastrar um novo endereço.',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: responsiveFontSize(15.0),
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.05),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: TextFormField(
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
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xff1f1d34),
                                          ), // Cor quando a caixa é selecionada
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xff1f1d34),
                                          ), // Cor quando a caixa não é selecionada
                                          borderRadius:
                                              BorderRadius.circular(8.0),
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
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        bool getAddressByCepSuccess =
                                            await _handleGetAddressByCep();

                                        if (getAddressByCepSuccess && mounted) {
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar();

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "Endereço encontrado com sucesso!",
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize:
                                                      responsiveFontSize(16.0),
                                                ),
                                              ),
                                              duration:
                                                  const Duration(seconds: 5),
                                              backgroundColor:
                                                  const Color(0xff4ecd72),
                                            ),
                                          );
                                        } else if (mounted) {
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar();

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "Erro: CEP não encontrado",
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize:
                                                      responsiveFontSize(16.0),
                                                ),
                                              ),
                                              duration:
                                                  const Duration(seconds: 5),
                                              backgroundColor:
                                                  const Color(0xffcd4e4e),
                                            ),
                                          );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xff4e90cd),
                                        foregroundColor:
                                            const Color(0xfff6f5f2),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xff1f1d34),
                                          ), // Cor quando a caixa é selecionada
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xff1f1d34),
                                          ), // Cor quando a caixa não é selecionada
                                          borderRadius:
                                              BorderRadius.circular(8.0),
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
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xff1f1d34),
                                          ), // Cor quando a caixa é selecionada
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xff1f1d34),
                                          ), // Cor quando a caixa não é selecionada
                                          borderRadius:
                                              BorderRadius.circular(8.0),
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
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      bool addressRegisterSuccess =
                                          await _handleAddressRegister();

                                      if (addressRegisterSuccess && mounted) {
                                        ScaffoldMessenger.of(context)
                                            .hideCurrentSnackBar();

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Endereço salvo com sucesso!",
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize:
                                                    responsiveFontSize(16.0),
                                              ),
                                            ),
                                            duration:
                                                const Duration(seconds: 5),
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
                                        ScaffoldMessenger.of(context)
                                            .hideCurrentSnackBar();

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Erro ao salvar endereço",
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize:
                                                    responsiveFontSize(16.0),
                                              ),
                                            ),
                                            duration:
                                                const Duration(seconds: 5),
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
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    child: Text(
                                      "Salvar Endereço",
                                      style: TextStyle(
                                        fontSize: responsiveFontSize(17.0),
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        } else {
                          final endereco = snapshot.data!;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: _cepController,
                                      maxLength: 8,
                                      validator: _validateRequiredField,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        labelText: 'CEP',
                                        // substituir esse hintText pelo CEP do usuário
                                        hintText: endereco.cep,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: screenHeight * 0.02),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xff1f1d34),
                                          ), // Cor quando a caixa é selecionada
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xff1f1d34),
                                          ), // Cor quando a caixa não é selecionada
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
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
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.035,
                                    height: screenHeight * 0.11,
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        bool getAddressByCepSuccess =
                                            await _handleGetAddressByCep();

                                        if (getAddressByCepSuccess && mounted) {
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar();

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "Endereço encontrado com sucesso!",
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize:
                                                      responsiveFontSize(16.0),
                                                ),
                                              ),
                                              duration:
                                                  const Duration(seconds: 5),
                                              backgroundColor:
                                                  const Color(0xff4ecd72),
                                            ),
                                          );
                                        } else if (mounted) {
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar();

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "Erro: CEP não encontrado",
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize:
                                                      responsiveFontSize(16.0),
                                                ),
                                              ),
                                              duration:
                                                  const Duration(seconds: 5),
                                              backgroundColor:
                                                  const Color(0xffcd4e4e),
                                            ),
                                          );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xff4e90cd),
                                        foregroundColor:
                                            const Color(0xfff6f5f2),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
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
                                  ),
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              TextFormField(
                                controller: _cityController,
                                enabled: false,
                                decoration: InputDecoration(
                                  labelText: 'Cidade',
                                  // substituir esse hintText pela cidade do usuário
                                  hintText: endereco.localidade,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: screenHeight * 0.02),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
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
                              SizedBox(height: screenHeight * 0.03),
                              TextFormField(
                                controller: _neighborhoodController,
                                enabled: false,
                                decoration: InputDecoration(
                                  labelText: 'Bairro',
                                  // substituir esse hintText pelo bairro do usuário
                                  hintText: endereco.bairro,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: screenHeight * 0.02),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
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
                              SizedBox(height: screenHeight * 0.03),
                              TextFormField(
                                controller: _streetController,
                                enabled: false,
                                decoration: InputDecoration(
                                  labelText: 'Rua',
                                  // substituir esse hintText pela rua do usuário
                                  hintText: endereco.rua,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: screenHeight * 0.02),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: _numberController,
                                      maxLength: 100000,
                                      validator: _validateRequiredField,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: 'Número',
                                        hintText: endereco.numero,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: screenHeight * 0.02),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xff1f1d34),
                                          ), // Cor quando a caixa é selecionada
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xff1f1d34),
                                          ), // Cor quando a caixa não é selecionada
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
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
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.035,
                                    height: screenHeight * 0.11,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _stateController,
                                      maxLength: 2,
                                      enabled: false,
                                      decoration: InputDecoration(
                                        labelText: 'Estado',
                                        // substituir esse hintText pelo estado do usuário
                                        hintText: endereco.uf,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: screenHeight * 0.02),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
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
                                  ),
                                ],
                              ),
                              TextFormField(
                                controller: _complementController,
                                maxLength: 100,
                                validator: _validateRequiredField,
                                decoration: InputDecoration(
                                  labelText: 'Complemento',
                                  // substituir esse hintText pelo complemento do usuário
                                  hintText: endereco.complemento,
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
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (_isEditingAddress)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              _isEditingAddress = false;
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            foregroundColor: Colors.red,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
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
                                              fontSize:
                                                  responsiveFontSize(16.0),
                                              color: const Color(0xffcd4e4e),
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            setState(() {
                                              _isEditingAddress = false;
                                            });

                                            bool success =
                                                await _handleAddressUpdate();

                                            if (success && mounted) {
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentSnackBar();

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Endereço atualizado com sucesso!',
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize:
                                                          responsiveFontSize(
                                                              17.0),
                                                    ),
                                                  ),
                                                  duration: const Duration(
                                                      seconds: 5),
                                                  backgroundColor:
                                                      const Color(0xff4ecd72),
                                                ),
                                              );

                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          super.widget,
                                                ),
                                              );
                                            } else if (mounted) {
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentSnackBar();

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Erro ao atualizar endereço',
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize:
                                                          responsiveFontSize(
                                                              17.0),
                                                    ),
                                                  ),
                                                  duration: const Duration(
                                                      seconds: 5),
                                                  backgroundColor:
                                                      const Color(0xffcd4e4e),
                                                ),
                                              );
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xff4e90cd),
                                            foregroundColor:
                                                const Color(0xfff6f5f2),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                          child: Text(
                                            "Salvar",
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize:
                                                  responsiveFontSize(16.0),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  if (!_isEditingAddress)
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          _isEditingAddress = true;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xff4e90cd),
                                        foregroundColor:
                                            const Color(0xfff6f5f2),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                      child: Text(
                                        "Alterar Endereço",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: responsiveFontSize(16.0),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          );
                        }
                      },
                    ),
                    // ==================================================
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _handleGetAddressByCep() async {
    try {
      final response =
          await ViaCepService().getAddressByCep(_cepController.text);
      _cityController.text = response['localidade'];
      _neighborhoodController.text = response['bairro'];
      _streetController.text = response['logradouro'];
      _stateController.text = response['uf'];
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> _handleAddressRegister() async {
    try {
      await EnderecoService().registerEndereco(
        widget.userId ?? '',
        _cepController.text,
        _cityController.text,
        _neighborhoodController.text,
        _streetController.text,
        _numberController.text,
        _stateController.text,
        _complementController.text.isEmpty
            ? "Nada"
            : _complementController.text,
      );

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> _handleAddressUpdate() async {
    try {
      await EnderecoService().updateEndereco(
        widget.userId ?? '',
        _cepController.text,
        _cityController.text,
        _neighborhoodController.text,
        _streetController.text,
        _numberController.text,
        _stateController.text,
        _complementController.text.isEmpty
            ? "Nada"
            : _complementController.text,
      );

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> _handleUpdateUser() async {
    try {
      await DadosPessoaisService().updateDadosPessoais(
        widget.userId ?? '',
        _phoneController.text,
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}

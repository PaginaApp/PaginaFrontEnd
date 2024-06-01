// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:projeto_pagina/data/models/dados_pessoais_model.dart';
import 'package:projeto_pagina/services/dados_pessoais_service.dart';
import 'package:projeto_pagina/services/transacao_service.dart';
import 'package:projeto_pagina/telas/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmarNegociacao extends StatefulWidget {
  final String exemplarUsuarioId;
  final String exemplarId;
  final String negotiationTypeId;

  const ConfirmarNegociacao({
    Key? key,
    required this.exemplarUsuarioId,
    required this.exemplarId,
    required this.negotiationTypeId,
  }) : super(key: key);

  @override
  State<ConfirmarNegociacao> createState() => _ConfirmarNegociacaoState();
}

class _ConfirmarNegociacaoState extends State<ConfirmarNegociacao> {
  late Future<DadosPessoaisModel> _dadosPessoaisFuture;

  String? userId;

  void _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId');
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserId();
    _dadosPessoaisFuture =
        DadosPessoaisService().fetchDadosPessoais(widget.exemplarUsuarioId);
  }

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
                        userId == widget.exemplarUsuarioId
                            ? 'Você não pode'
                            : 'Você deseja',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: const Color(0xff14131a),
                          fontSize: responsiveFontSize(14.0),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.005),
                      Text(
                        userId == widget.exemplarUsuarioId
                            ? 'negociar com você mesmo'
                            : 'confirmar a negociação?',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: const Color(0xff14131a),
                          fontSize: responsiveFontSize(14.0),
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
                            onPressed: userId == widget.exemplarUsuarioId
                                ? null
                                : () async {
                                    bool success = await _handleNegotiation();

                                    if (success && mounted) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const Home()),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Negociação iniciada. Aguardando confirmação do outro usuário.',
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
                                    } else if (mounted) {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Erro ao iniciar negociação. Tente novamente mais tarde',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize:
                                                  responsiveFontSize(16.0),
                                            ),
                                          ),
                                          duration: const Duration(seconds: 5),
                                          backgroundColor:
                                              const Color(0xffec4e4e),
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
                SizedBox(height: screenHeight * 0.02),
                // dados do anunciante
                FutureBuilder<DadosPessoaisModel>(
                  future: _dadosPessoaisFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: SizedBox(
                          height: screenHeight * 0.2,
                          width: screenWidth * 2,
                          child: Text(
                            'Erro ao carregar nome de usuário e título',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: responsiveFontSize(14),
                                color: const Color(0xfff6f5f2),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    } else {
                      final anunciante = snapshot.data!;
                      return Container(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        color: const Color(0xffbabdd3),
                        // ignore: sized_box_for_whitespace
                        child: Container(
                          height: screenHeight * 0.2,
                          width: screenWidth * 2,
                          child: Row(
                            children: [
                              FutureBuilder<Image>(
                                future: DadosPessoaisService()
                                    .fetchAvatar(widget.exemplarUsuarioId),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Center(
                                      child: Text(
                                        'Erro ao carregar imagem',
                                        style: TextStyle(
                                          color: const Color(0xfff6f5f2),
                                          fontFamily: 'Poppins',
                                          fontSize: responsiveFontSize(14),
                                        ),
                                      ),
                                    );
                                  } else {
                                    final image = snapshot.data!;
                                    return CircleAvatar(
                                      radius: screenWidth * 0.05,
                                      backgroundColor: const Color(0xfff6f5f2),
                                      child: image,
                                    );
                                  }
                                },
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userId == widget.exemplarUsuarioId
                                          ? 'Você'
                                          : anunciante.nome,
                                      style: TextStyle(
                                        fontSize: responsiveFontSize(14.0),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff14131a),
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.02),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.phone,
                                          color: const Color(0xfff6f5f2),
                                          size: responsiveFontSize(20.0),
                                        ),
                                        SizedBox(width: screenWidth * 0.01),
                                        Flexible(
                                          child: Text(
                                            anunciante.telefone,
                                            style: TextStyle(
                                              fontSize:
                                                  responsiveFontSize(12.0),
                                              fontFamily: 'Poppins',
                                              color: const Color(0xff14131a),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: screenHeight * 0.005),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.email,
                                          color: const Color(0xfff6f5f2),
                                          size: responsiveFontSize(20.0),
                                        ),
                                        SizedBox(width: screenWidth * 0.01),
                                        Flexible(
                                          child: Text(
                                            anunciante.email,
                                            style: TextStyle(
                                              fontSize:
                                                  responsiveFontSize(12.0),
                                              fontFamily: 'Poppins',
                                              color: const Color(0xff14131a),
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
                      );
                    }
                  },
                ),
                // fim dos dados do anunciante
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _handleNegotiation() async {
    try {
      await TransacaoService().createTransacao(
        DateTime.now().toIso8601String(),
        widget.negotiationTypeId,
        userId ?? '',
        widget.exemplarUsuarioId,
        widget.exemplarId,
      );

      return true;
    } catch (e) {
      return false;
    }
  }
}

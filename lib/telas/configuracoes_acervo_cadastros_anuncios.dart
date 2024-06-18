import 'package:flutter/material.dart';
import 'package:projeto_pagina/data/repositories/exemplar_repository.dart';
import 'package:projeto_pagina/data/repositories/transacao_anunciante_repository.dart';
import 'package:projeto_pagina/stores/exemplar_store.dart';
import 'package:projeto_pagina/stores/transacao_anunciante_store.dart';
import 'package:projeto_pagina/telas/produto_2.dart';
import 'package:projeto_pagina/telas/produto_negociacao_negociacoes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:diacritic/diacritic.dart';

class ConfiguracoesAcervoCadastrosAnuncios extends StatefulWidget {
  const ConfiguracoesAcervoCadastrosAnuncios({super.key});

  @override
  State<ConfiguracoesAcervoCadastrosAnuncios> createState() =>
      _ConfiguracoesAcervoCadastrosAnunciosState();
}

class _ConfiguracoesAcervoCadastrosAnunciosState
    extends State<ConfiguracoesAcervoCadastrosAnuncios> {
  final TransacaoAnuncianteStore transacaoAnuncianteStore =
      TransacaoAnuncianteStore(
          transacaoAnuncianteRepository: TransacaoAnuncianteRepository());

  final ExemplarStore exemplarStore =
      ExemplarStore(exemplarRepository: ExemplarRepository());

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      String? id = prefs.getString('userId');
      if (id != null) {
        transacaoAnuncianteStore.getTransacoesAnuncianteById(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double responsiveFontSize(double fontSize) {
      return fontSize * screenWidth / 375;
    }

    return Scaffold(
      backgroundColor: const Color(0xfff6f5f2),
      body: Column(
        children: [
          AppBar(
            backgroundColor: const Color(0xfff6f5f2),
            title: Text(
              'Seus anúncios',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: responsiveFontSize(20),
                fontWeight: FontWeight.bold,
                color: const Color(0xff14131a),
              ),
            ),
            iconTheme: const IconThemeData(
              color: Color(0xff4e90cd),
            ),
          ),

          // =============================================================================

          AnimatedBuilder(
            animation: Listenable.merge([
              transacaoAnuncianteStore.isLoading,
              transacaoAnuncianteStore.error,
              transacaoAnuncianteStore.state,
            ]),
            builder: (context, child) {
              if (transacaoAnuncianteStore.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (transacaoAnuncianteStore.error.value.isNotEmpty) {
                return Center(
                  child: Text(
                    "Nenhum transação encontrado",
                    style: TextStyle(
                      color: const Color(0xffcd4e4e),
                      fontSize: responsiveFontSize(14.0),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                );
              }

              if (transacaoAnuncianteStore.state.value.isEmpty) {
                return Center(
                  child: Text(
                    'Nenhum anúncio encontrado',
                    style: TextStyle(
                      color: const Color(0xff14131a),
                      fontSize: responsiveFontSize(14.0),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: transacaoAnuncianteStore.state.value.length,
                    itemBuilder: (context, index) {
                      final transacao =
                          transacaoAnuncianteStore.state.value[index];
                      bool isLocked = transacao.exemplarNegociando;
                      return InkWell(
                        onTap: () {},
                        child: InkWell(
                          onTap: () {
                            if (!isLocked) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Produto2(
                                    exemplarId: transacao.exemplaresId,
                                    transacaoLeitorId: transacao.usuLeitorId,
                                    tipoTransacao: transacao.tipoTransacao,
                                    statusTransacao: transacao.statusTransacao,
                                    transacaoId: transacao.id,
                                  ),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProdutoNegociacaoNegociacoes(
                                    exemplarId: transacao.exemplaresId,
                                    transacaoLeitorId: transacao.usuLeitorId,
                                    transacaoAnuncianteId:
                                        transacao.usuAnuncianteId,
                                    tipoTransacao: transacao.tipoTransacao,
                                    transacaoId: transacao.id,
                                  ),
                                ),
                              );
                            }
                          },
                          child: Opacity(
                            opacity: isLocked ? 0.5 : 1,
                            child: Container(
                              margin: EdgeInsets.all(screenWidth * 0.05),
                              padding: EdgeInsets.all(screenWidth * 0.02),
                              decoration: BoxDecoration(
                                color: const Color(0xfff6f5f2),
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Stack(
                                    children: [
                                      Image.asset(
                                        'assets/png/imagem_exemplar.png',
                                        width: screenWidth * 0.15,
                                        height: screenHeight * 0.1,
                                      ),
                                      if (isLocked)
                                        Icon(
                                          Icons.lock,
                                          size: screenWidth * 0.1,
                                          color: Colors.grey,
                                        ),
                                    ],
                                  ),
                                  SizedBox(width: screenWidth * 0.002),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          transacao.titulo,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: responsiveFontSize(14.0),
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff14131a),
                                          ),
                                        ),
                                        SizedBox(height: screenHeight * 0.005),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              for (var item
                                                  in transacao.categorias)
                                                _buildCategory(item),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: screenHeight * 0.01),
                                        Text(
                                          "Status da negociação: ${transacao.statusTransacao}",
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: responsiveFontSize(13.0),
                                            color: const Color(0xff14131a),
                                          ),
                                        ),
                                        SizedBox(height: screenHeight * 0.01),
                                        Text(
                                          transacao.statusTransacao ==
                                                  'Em espera'
                                              ? 'Aceite a negociação'
                                              : transacao.statusTransacao ==
                                                      'Em andamento'
                                                  ? 'Clique para concluir a negociação'
                                                  : '',
                                          style: TextStyle(
                                            color: const Color(0xff14131a),
                                            fontSize: responsiveFontSize(12.0),
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                        SizedBox(height: screenHeight * 0.01),
                                        Image.asset(
                                          'assets/png/${removeDiacritics(transacao.tipoTransacao).toLowerCase()}.png',
                                          width: screenWidth * 0.1,
                                          height: screenHeight * 0.05,
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
                    },
                  ),
                );
              }
            },
          ),
          // ==============================================================================
        ],
      ),
    );
  }

  Widget _buildCategory(String text) {
    double screenWidth = MediaQuery.of(context).size.width;

    double responsiveFontSize(double fontSize) {
      return fontSize * screenWidth / 375.0;
    }

    return Container(
      margin: EdgeInsets.only(right: screenWidth * 0.015),
      padding: EdgeInsets.all(screenWidth * 0.014),
      decoration: BoxDecoration(
        color: const Color(0xff4e90cd),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: responsiveFontSize(12.0),
          color: const Color(0xfff6f5f2),
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}

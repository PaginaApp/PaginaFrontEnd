import 'package:flutter/material.dart';
import 'package:projeto_pagina/data/models/exemplar_detalhes_model.dart';
import 'package:projeto_pagina/data/repositories/exemplar_repository.dart';
import 'package:projeto_pagina/data/repositories/transacao_leitor_repository.dart';
import 'package:projeto_pagina/services/exemplar_detalhes_service.dart';
import 'package:projeto_pagina/stores/exemplar_store.dart';
import 'package:projeto_pagina/stores/transacao_leitor_store.dart';
import 'package:projeto_pagina/telas/produto_2.dart';
import 'package:projeto_pagina/telas/produto_negociacao_negociacoes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfiguracoesAcervoCadastrosSolicitacoes extends StatefulWidget {
  const ConfiguracoesAcervoCadastrosSolicitacoes({super.key});

  @override
  State<ConfiguracoesAcervoCadastrosSolicitacoes> createState() =>
      _ConfiguracoesAcervoCadastrosSolicitacoesState();
}

class _ConfiguracoesAcervoCadastrosSolicitacoesState
    extends State<ConfiguracoesAcervoCadastrosSolicitacoes> {
  final TransacaoLeitorStore transacaoLeitorStore = TransacaoLeitorStore(
      transacaoLeitorRepository: TransacaoLeitorRepository());

  final ExemplarStore exemplarStore =
      ExemplarStore(exemplarRepository: ExemplarRepository());

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      String? id = prefs.getString('userId');
      if (id != null) {
        transacaoLeitorStore.getTransacoesLeitorById(id);
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
              'Suas solicitações',
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
              transacaoLeitorStore.isLoading,
              transacaoLeitorStore.error,
              transacaoLeitorStore.state,
            ]),
            builder: (context, child) {
              if (transacaoLeitorStore.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (transacaoLeitorStore.error.value.isNotEmpty) {
                return Center(
                  child: Text(
                    "Nenhuma transação encontrada",
                    style: TextStyle(
                      color: const Color(0xffcd4e4e),
                      fontSize: responsiveFontSize(14.0),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                );
              }

              if (transacaoLeitorStore.state.value.isEmpty) {
                return Center(
                  child: Text(
                    'Nenhuma solicitação encontrada',
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
                    itemCount: transacaoLeitorStore.state.value.length,
                    itemBuilder: (context, index) {
                      final transacao = transacaoLeitorStore.state.value[index];

                      return InkWell(
                        onTap: () {},
                        child: FutureBuilder<ExemplarDetalhesModel>(
                          future: ExemplarDetalhesService()
                              .fetchExemplarDetalhes(transacao.exemplaresId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                  'Erro ao carregar anúncio',
                                  style: TextStyle(
                                    color: const Color(0xffcd4e4e),
                                    fontSize: responsiveFontSize(14.0),
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              );
                            } else {
                              final exemplarDetalhes = snapshot.data!;
                              bool isLocked = exemplarDetalhes.negociando;

                              return InkWell(
                                onTap: () {
                                  if (!isLocked) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Produto2(
                                          exemplarId: exemplarDetalhes.id,
                                        ),
                                      ),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ProdutoNegociacaoNegociacoes(
                                          exemplarId: exemplarDetalhes.id,
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
                                              'assets/png/emprestimo.png',
                                              width: screenWidth * 0.3,
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
                                                "Você solicitou:",
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize:
                                                      responsiveFontSize(14.0),
                                                  color:
                                                      const Color(0xff14131a),
                                                ),
                                              ),
                                              Text(
                                                exemplarDetalhes.titulo,
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize:
                                                      responsiveFontSize(14.0),
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      const Color(0xff14131a),
                                                ),
                                              ),
                                              SizedBox(
                                                  height: screenHeight * 0.005),
                                              SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  children: [
                                                    for (var item
                                                        in exemplarDetalhes
                                                            .categorias)
                                                      _buildCategory(item),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                  height: screenHeight * 0.01),
                                              Image.asset(
                                                'assets/png/doacao.png',
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
                              );
                            }
                          },
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
        color: const Color(0xffbabdd3),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: responsiveFontSize(11.0),
          color: const Color(0xff14131a),
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}

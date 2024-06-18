import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pagina/data/repositories/exemplar_repository.dart';
import 'package:projeto_pagina/data/repositories/transacao_anunciante_repository.dart';
import 'package:projeto_pagina/data/repositories/transacao_leitor_repository.dart';
import 'package:projeto_pagina/stores/exemplar_store.dart';
import 'package:projeto_pagina/stores/transacao_anunciante_store.dart';
import 'package:projeto_pagina/stores/transacao_leitor_store.dart';
import 'package:projeto_pagina/telas/configuracoes_acervo_cadastros_add.dart';
import 'package:projeto_pagina/telas/configuracoes_acervo_cadastros_anuncios.dart';
import 'package:projeto_pagina/telas/configuracoes_acervo_cadastros_atualizar.dart';
import 'package:projeto_pagina/telas/configuracoes_acervo_cadastros_excluir.dart';
import 'package:projeto_pagina/telas/configuracoes_acervo_cadastros_solicitacoes.dart';
import 'package:projeto_pagina/telas/produto_1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfiguracoesAcervoCadastros extends StatefulWidget {
  const ConfiguracoesAcervoCadastros({super.key});

  @override
  State<ConfiguracoesAcervoCadastros> createState() =>
      _ConfiguracoesAcervoCadastrosState();
}

class _ConfiguracoesAcervoCadastrosState
    extends State<ConfiguracoesAcervoCadastros> {
  final ExemplarStore exemplarStore =
      ExemplarStore(exemplarRepository: ExemplarRepository());

  final TransacaoAnuncianteStore transacaoAnuncianteStore =
      TransacaoAnuncianteStore(
          transacaoAnuncianteRepository: TransacaoAnuncianteRepository());

  final TransacaoLeitorStore transacaoLeitorStore = TransacaoLeitorStore(
      transacaoLeitorRepository: TransacaoLeitorRepository());

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      String? id = prefs.getString('userId');
      if (id != null) {
        exemplarStore.getExemplaresByUser(id, 1, 50);
        transacaoAnuncianteStore.getTransacoesAnuncianteById(id);
        transacaoLeitorStore.getTransacoesLeitorById(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double responsiveFontSize(double fontSize) {
      return fontSize * screenWidth / 375.0;
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xfff6f5f2),
        body: Column(
          children: [
            AppBar(
              backgroundColor: const Color(0xfff6f5f2),
              title: Text(
                'Meu Acervo',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: responsiveFontSize(18),
                  color: const Color(0xff14131a),
                  fontWeight: FontWeight.bold,
                ),
              ),
              iconTheme: const IconThemeData(
                color: Color(0xff4e90cd),
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            TabBar(
              indicatorColor: const Color(0xff14131a),
              unselectedLabelColor: const Color(0xff4f5071),
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.book, color: Color(0xff4f5071)),
                      SizedBox(width: screenWidth * 0.01),
                      Text(
                        "Cadastros",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: responsiveFontSize(13.0),
                          color: const Color(0xff14131a),
                        ),
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.chat),
                      SizedBox(width: screenWidth * 0.01),
                      Text(
                        "Negociações",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: responsiveFontSize(13.0),
                          color: const Color(0xff14131a),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Conteúdo das abas
            Expanded(
              child: TabBarView(
                children: [
                  // Conteúdo da aba de cadastros

                  // -------------------------------------------------

                  AnimatedBuilder(
                    animation: Listenable.merge([
                      exemplarStore.isLoading,
                      exemplarStore.error,
                      exemplarStore.state,
                    ]),
                    builder: (context, child) {
                      if (exemplarStore.isLoading.value) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (exemplarStore.error.value.isNotEmpty) {
                        return Center(
                          child: Text(
                            "Falha ao carregar exemplares, verifique sua conexão",
                            style: TextStyle(
                              color: const Color(0xffcd4e4e),
                              fontSize: responsiveFontSize(14.0),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        );
                      }

                      if (exemplarStore.state.value.isEmpty) {
                        return Center(
                          child: Text(
                            'Nenhum exemplar encontrado',
                            style: TextStyle(
                              color: const Color(0xff14131a),
                              fontSize: responsiveFontSize(14.0),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          color: const Color(0xfff6f5f2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  itemCount: exemplarStore.state.value.length,
                                  itemBuilder: (context, index) {
                                    final exemplar =
                                        exemplarStore.state.value[index];
                                    // Condição para exemplares em negociação
                                    bool isLocked = exemplar.negociando;
                                    return InkWell(
                                      onTap: () {
                                        if (!isLocked) {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Produto1(
                                                  exemplarId: exemplar.id),
                                            ),
                                          );
                                        }
                                      },
                                      // -------------------------------------------------

                                      child: Opacity(
                                        opacity: isLocked ? 0.5 : 1,
                                        child: Container(
                                          margin: EdgeInsets.all(
                                              screenWidth * 0.05),
                                          padding: EdgeInsets.all(
                                              screenWidth * 0.02),
                                          decoration: BoxDecoration(
                                            color: const Color(0xfff6f5f2),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
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
                                              SizedBox(
                                                  width: screenWidth * 0.002),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      exemplar.titulo,
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize:
                                                            responsiveFontSize(
                                                                14.0),
                                                        color: const Color(
                                                            0xff14131a),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height: screenHeight *
                                                            0.005),
                                                    SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Row(
                                                        children: [
                                                          for (var categoria
                                                              in exemplar
                                                                  .categorias)
                                                            _buildCategory(
                                                                categoria),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height: screenHeight *
                                                            0.01),
                                                    SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Row(
                                                        children: [
                                                          for (var tipoTransacao
                                                              in exemplar
                                                                  .tiposTransacoes) ...[
                                                            Image.asset(
                                                              'assets/png/${removeDiacritics(tipoTransacao).toLowerCase()}.png',
                                                              width:
                                                                  screenWidth *
                                                                      0.1,
                                                              height:
                                                                  screenHeight *
                                                                      0.05,
                                                            ),
                                                            SizedBox(
                                                                width:
                                                                    screenWidth *
                                                                        0.015),
                                                          ]
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  IconButton(
                                                    icon: const Icon(
                                                      Icons.edit,
                                                      color: Color(0xff4ecd72),
                                                    ),
                                                    onPressed: () {
                                                      if (!isLocked) {
                                                        Navigator
                                                            .pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                ConfiguracoesAcervoCadastrosAtualizar(
                                                                    exemplarId:
                                                                        exemplar
                                                                            .id),
                                                          ),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                  IconButton(
                                                    icon: const Icon(
                                                      Icons.delete,
                                                      color: Color(0xffcd4e4e),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ConfiguracoesAcervoCadastrosExcluir(
                                                                  exemplarId:
                                                                      exemplar
                                                                          .id),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      // -------------------------------------------------
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.1),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                  // -------------------------------------------------
                  // Fim do conteúdo da aba de cadastros

                  // Conteúdo da aba de negociações

                  // ===================================

                  Column(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: screenHeight * 0.05),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ConfiguracoesAcervoCadastrosAnuncios()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff4e90cd),
                                foregroundColor: const Color(0xfff6f5f2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              child: Text(
                                "Veja aqui seus anúncios",
                                style: TextStyle(
                                  fontSize: responsiveFontSize(16.0),
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.1),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ConfiguracoesAcervoCadastrosSolicitacoes()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff4e90cd),
                                foregroundColor: const Color(0xfff6f5f2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              child: Text(
                                "Veja aqui suas solicitações",
                                style: TextStyle(
                                  fontSize: responsiveFontSize(16.0),
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // ===================================
                  // Fim do conteúdo da aba de negociações
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const ConfiguracoesAcervoCadastrosAdd()),
            );
          },
          backgroundColor: const Color(0xff4e90cd),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.15),
          ),
          child: Icon(
            Icons.add,
            color: const Color(0xfff6f5f2),
            size: screenWidth * 0.1,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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

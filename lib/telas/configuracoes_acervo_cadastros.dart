import 'dart:async';

import 'package:flutter/material.dart';
import 'package:projeto_pagina/data/models/exemplar_detalhes_model.dart';
import 'package:projeto_pagina/data/repositories/exemplar_repository.dart';
import 'package:projeto_pagina/data/repositories/transacao_anunciante_repository.dart';
import 'package:projeto_pagina/data/repositories/transacao_leitor_repository.dart';
import 'package:projeto_pagina/services/exemplar_detalhes_service.dart';
import 'package:projeto_pagina/stores/exemplar_store.dart';
import 'package:projeto_pagina/stores/transacao_anunciante_store.dart';
import 'package:projeto_pagina/stores/transacao_leitor_store.dart';
import 'package:projeto_pagina/telas/configuracoes_acervo_cadastros_add.dart';
import 'package:projeto_pagina/telas/configuracoes_acervo_cadastros_atualizar.dart';
import 'package:projeto_pagina/telas/configuracoes_acervo_cadastros_excluir.dart';
import 'package:projeto_pagina/telas/produto_1.dart';
import 'package:projeto_pagina/telas/produto_negociacao_negociacoes.dart';
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
        exemplarStore.getExemplaresByUser(id, 1, 10);
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
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.07),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Título, autor, editora...',
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: responsiveFontSize(14.0),
                          color: const Color(0xff14131a),
                        ),
                        fillColor: const Color(0xfff6f5f2),
                        filled: true,
                        prefixIcon: Icon(
                          Icons.search,
                          color: const Color(0xff14131a),
                          size: responsiveFontSize(22.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff4e90cd)),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff4e90cd)),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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

                                      child:
                                          FutureBuilder<ExemplarDetalhesModel>(
                                        future: ExemplarDetalhesService()
                                            .fetchExemplarDetalhes(exemplar.id),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          } else if (snapshot.hasError) {
                                            return Center(
                                              child: Text(
                                                'Erro ao carregar exemplar',
                                                style: TextStyle(
                                                  color:
                                                      const Color(0xffcd4e4e),
                                                  fontSize:
                                                      responsiveFontSize(14.0),
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Poppins',
                                                ),
                                              ),
                                            );
                                          } else {
                                            final exemplarDetalhes =
                                                snapshot.data!;
                                            return Opacity(
                                              opacity: isLocked ? 0.5 : 1,
                                              child: Container(
                                                margin: EdgeInsets.all(
                                                    screenWidth * 0.05),
                                                padding: EdgeInsets.all(
                                                    screenWidth * 0.02),
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xfff6f5f2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 5,
                                                      blurRadius: 7,
                                                      offset:
                                                          const Offset(0, 3),
                                                    ),
                                                  ],
                                                ),
                                                child: Row(
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        Image.asset(
                                                          'assets/png/emprestimo.png',
                                                          width:
                                                              screenWidth * 0.3,
                                                          height: screenHeight *
                                                              0.1,
                                                        ),
                                                        if (isLocked)
                                                          Icon(
                                                            Icons.lock,
                                                            size: screenWidth *
                                                                0.1,
                                                            color: Colors.grey,
                                                          ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                        width: screenWidth *
                                                            0.002),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            exemplarDetalhes
                                                                .titulo,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontSize:
                                                                  responsiveFontSize(
                                                                      14.0),
                                                              color: const Color(
                                                                  0xff14131a),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height:
                                                                  screenHeight *
                                                                      0.005),
                                                          SingleChildScrollView(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            child: Row(
                                                              children: [
                                                                for (var categoria
                                                                    in exemplarDetalhes
                                                                        .categorias)
                                                                  _buildCategory(
                                                                      categoria),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height:
                                                                  screenHeight *
                                                                      0.01),
                                                          Image.asset(
                                                            'assets/png/doacao.png',
                                                            width: screenWidth *
                                                                0.1,
                                                            height:
                                                                screenHeight *
                                                                    0.05,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Column(
                                                      children: [
                                                        IconButton(
                                                          icon: const Icon(
                                                            Icons.edit,
                                                            color: Color(
                                                                0xff4ecd72),
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
                                                                              exemplar.id),
                                                                ),
                                                              );
                                                            }
                                                          },
                                                        ),
                                                        IconButton(
                                                          icon: const Icon(
                                                            Icons.delete,
                                                            color: Color(
                                                                0xffcd4e4e),
                                                          ),
                                                          onPressed: () {
                                                            Navigator
                                                                .pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    ConfiguracoesAcervoCadastrosExcluir(
                                                                        exemplarId:
                                                                            exemplar.id),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }
                                        },
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

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Parte da transacao como anunciante
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

                            if (transacaoAnuncianteStore
                                .error.value.isNotEmpty) {
                              return Center(
                                child: Text(
                                  "Falha ao carregar negociações, verifique sua conexão",
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
                                  'Nenhuma transação encontrada',
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
                                        itemCount: transacaoAnuncianteStore
                                            .state.value.length,
                                        itemBuilder: (context, index) {
                                          final transacao =
                                              transacaoAnuncianteStore
                                                  .state.value[index];

                                          if (transacao.exemplaresId.length ==
                                              1) {
                                            // exibição de exemplar da transação quando há apenas um exemplar
                                            return Column(
                                              children: [
                                                FutureBuilder<
                                                    ExemplarDetalhesModel>(
                                                  future: ExemplarDetalhesService()
                                                      .fetchExemplarDetalhes(
                                                          transacao
                                                              .exemplaresId[0]),
                                                  builder: (context, snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return const Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      );
                                                    } else if (snapshot
                                                        .hasError) {
                                                      return Center(
                                                        child: Text(
                                                          'Erro ao carregar exemplar',
                                                          style: TextStyle(
                                                            color: const Color(
                                                                0xffcd4e4e),
                                                            fontSize:
                                                                responsiveFontSize(
                                                                    14.0),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                'Poppins',
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      final exemplarDetalhes =
                                                          snapshot.data!;
                                                      bool isLocked =
                                                          exemplarDetalhes
                                                              .negociando;
                                                      return InkWell(
                                                        onTap: () {
                                                          if (!isLocked) {
                                                            print(
                                                                'Caixa $index clicada');
                                                          } else {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const ProdutoNegociacaoNegociacoes()),
                                                            );
                                                          }
                                                        },
                                                        child: Opacity(
                                                          opacity: isLocked
                                                              ? 0.5
                                                              : 1,
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.all(
                                                                    screenWidth *
                                                                        0.05),
                                                            padding:
                                                                EdgeInsets.all(
                                                                    screenWidth *
                                                                        0.02),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: const Color(
                                                                  0xfff6f5f2),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.5),
                                                                  spreadRadius:
                                                                      5,
                                                                  blurRadius: 7,
                                                                  offset:
                                                                      const Offset(
                                                                          0, 3),
                                                                ),
                                                              ],
                                                            ),
                                                            child: Row(
                                                              children: [
                                                                Stack(
                                                                  children: [
                                                                    Image.asset(
                                                                      'assets/png/emprestimo.png',
                                                                      width:
                                                                          screenWidth *
                                                                              0.3,
                                                                      height:
                                                                          screenHeight *
                                                                              0.1,
                                                                    ),
                                                                    if (isLocked)
                                                                      Icon(
                                                                        Icons
                                                                            .lock,
                                                                        size: screenWidth *
                                                                            0.1,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                    width: screenWidth *
                                                                        0.002),
                                                                Expanded(
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        "Você anunciou:",
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          fontSize:
                                                                              responsiveFontSize(14.0),
                                                                          color:
                                                                              const Color(0xff14131a),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        exemplarDetalhes
                                                                            .titulo,
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          fontSize:
                                                                              responsiveFontSize(14.0),
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              const Color(0xff14131a),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                          height:
                                                                              screenHeight * 0.005),
                                                                      SingleChildScrollView(
                                                                        scrollDirection:
                                                                            Axis.horizontal,
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            for (var item
                                                                                in exemplarDetalhes.categorias)
                                                                              _buildCategory(item),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                          height:
                                                                              screenHeight * 0.01),
                                                                      Image
                                                                          .asset(
                                                                        'assets/png/doacao.png',
                                                                        width: screenWidth *
                                                                            0.1,
                                                                        height: screenHeight *
                                                                            0.05,
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
                                              ],
                                            );

                                            // fim da exibição de exemplar da transação quando há apenas um exemplar
                                          } else {
                                            // exibição do exemplar do usuário quando tem mais de um exemplar
                                            final exemplarIdCompleter =
                                                Completer<String>();

                                            SharedPreferences.getInstance()
                                                .then((prefs) async {
                                              String? userId =
                                                  prefs.getString('userId');
                                              for (int i = 0;
                                                  i <
                                                      transacao
                                                          .exemplaresId.length;
                                                  i++) {
                                                final id =
                                                    transacao.exemplaresId[i];
                                                final exemplarDetalhes =
                                                    await ExemplarDetalhesService()
                                                        .fetchExemplarDetalhes(
                                                            id);

                                                if (exemplarDetalhes.usuID ==
                                                    userId) {
                                                  exemplarIdCompleter
                                                      .complete(id);
                                                  break;
                                                }
                                              }

                                              if (!exemplarIdCompleter
                                                  .isCompleted) {
                                                exemplarIdCompleter.completeError(
                                                    'Nenhum exemplar encontrado');
                                              }
                                            });

                                            exemplarIdCompleter.future
                                                .then((exemplarId) {
                                              return Column(
                                                children: [
                                                  FutureBuilder<
                                                      ExemplarDetalhesModel>(
                                                    future: ExemplarDetalhesService()
                                                        .fetchExemplarDetalhes(
                                                            exemplarIdCompleter
                                                                    .future
                                                                as String),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        return const Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        );
                                                      } else if (snapshot
                                                          .hasError) {
                                                        return Center(
                                                          child: Text(
                                                            'Erro ao carregar exemplar',
                                                            style: TextStyle(
                                                              color: const Color(
                                                                  0xffcd4e4e),
                                                              fontSize:
                                                                  responsiveFontSize(
                                                                      14.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  'Poppins',
                                                            ),
                                                          ),
                                                        );
                                                      } else {
                                                        final exemplarDetalhes =
                                                            snapshot.data!;

                                                        return Column(
                                                          children: [
                                                            FutureBuilder<
                                                                ExemplarDetalhesModel>(
                                                              future: ExemplarDetalhesService()
                                                                  .fetchExemplarDetalhes(
                                                                      exemplarIdCompleter
                                                                              .future
                                                                          as String),
                                                              builder: (context,
                                                                  snapshot) {
                                                                if (snapshot
                                                                        .connectionState ==
                                                                    ConnectionState
                                                                        .waiting) {
                                                                  return const Center(
                                                                    child:
                                                                        CircularProgressIndicator(),
                                                                  );
                                                                } else if (snapshot
                                                                    .hasError) {
                                                                  return Center(
                                                                    child: Text(
                                                                      'Erro ao carregar exemplar',
                                                                      style:
                                                                          TextStyle(
                                                                        color: const Color(
                                                                            0xffcd4e4e),
                                                                        fontSize:
                                                                            responsiveFontSize(14.0),
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            'Poppins',
                                                                      ),
                                                                    ),
                                                                  );
                                                                } else {
                                                                  final exemplarDetalhes =
                                                                      snapshot
                                                                          .data!;
                                                                  bool
                                                                      isLocked =
                                                                      exemplarDetalhes
                                                                          .negociando;
                                                                  return InkWell(
                                                                    onTap: () {
                                                                      if (!isLocked) {
                                                                        print(
                                                                            'Caixa $index clicada');
                                                                      } else {
                                                                        Navigator
                                                                            .push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => const ProdutoNegociacaoNegociacoes()),
                                                                        );
                                                                      }
                                                                    },
                                                                    child:
                                                                        Opacity(
                                                                      opacity: isLocked
                                                                          ? 0.5
                                                                          : 1,
                                                                      child:
                                                                          Container(
                                                                        margin: EdgeInsets.all(screenWidth *
                                                                            0.05),
                                                                        padding:
                                                                            EdgeInsets.all(screenWidth *
                                                                                0.02),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              const Color(0xfff6f5f2),
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                              color: Colors.grey.withOpacity(0.5),
                                                                              spreadRadius: 5,
                                                                              blurRadius: 7,
                                                                              offset: const Offset(0, 3),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        child:
                                                                            Row(
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
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    "Você anunciou:",
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'Poppins',
                                                                                      fontSize: responsiveFontSize(14.0),
                                                                                      color: const Color(0xff14131a),
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    exemplarDetalhes.titulo,
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
                                                                                        for (var item in exemplarDetalhes.categorias) _buildCategory(item),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(height: screenHeight * 0.01),
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
                                                          ],
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ],
                                              );
                                            }).catchError((error) {
                                              return Column(
                                                children: [
                                                  Text(
                                                    "Erro ao carregar exemplar",
                                                    style: TextStyle(
                                                      color: const Color(
                                                          0xffcd4e4e),
                                                      fontSize:
                                                          responsiveFontSize(
                                                              14.0),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Poppins',
                                                    ),
                                                  ),
                                                ],
                                              );
                                            });

                                            // fim da exibição do exemplar do usuário quando tem mais de um exemplar
                                          }
                                          return Text(
                                            "Nada a exibir",
                                            style: TextStyle(
                                              color: const Color(0xff14131a),
                                              fontSize:
                                                  responsiveFontSize(14.0),
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Poppins',
                                            ),
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
                        // Fim da parte de transacao como anunciante

                        // Parte da transacao como leitor
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
                                  "Falha ao carregar negociações, verifique sua conexão",
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
                                  'Nenhuma transação encontrada',
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
                                        itemCount: transacaoLeitorStore
                                            .state.value.length,
                                        itemBuilder: (context, index) {
                                          final transacao = transacaoLeitorStore
                                              .state.value[index];

                                          if (transacao.exemplaresId.length ==
                                              1) {
                                            // exibição de exemplar da transação quando há apenas um exemplar
                                            return Column(
                                              children: [
                                                FutureBuilder<
                                                    ExemplarDetalhesModel>(
                                                  future: ExemplarDetalhesService()
                                                      .fetchExemplarDetalhes(
                                                          transacao
                                                              .exemplaresId[0]),
                                                  builder: (context, snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return const Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      );
                                                    } else if (snapshot
                                                        .hasError) {
                                                      return Center(
                                                        child: Text(
                                                          'Erro ao carregar exemplar',
                                                          style: TextStyle(
                                                            color: const Color(
                                                                0xffcd4e4e),
                                                            fontSize:
                                                                responsiveFontSize(
                                                                    14.0),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                'Poppins',
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      final exemplarDetalhes =
                                                          snapshot.data!;
                                                      bool isLocked =
                                                          exemplarDetalhes
                                                              .negociando;
                                                      return InkWell(
                                                        onTap: () {
                                                          if (!isLocked) {
                                                            print(
                                                                'Caixa $index clicada');
                                                          } else {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const ProdutoNegociacaoNegociacoes()),
                                                            );
                                                          }
                                                        },
                                                        child: Opacity(
                                                          opacity: isLocked
                                                              ? 0.5
                                                              : 1,
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.all(
                                                                    screenWidth *
                                                                        0.05),
                                                            padding:
                                                                EdgeInsets.all(
                                                                    screenWidth *
                                                                        0.02),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: const Color(
                                                                  0xfff6f5f2),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.5),
                                                                  spreadRadius:
                                                                      5,
                                                                  blurRadius: 7,
                                                                  offset:
                                                                      const Offset(
                                                                          0, 3),
                                                                ),
                                                              ],
                                                            ),
                                                            child: Row(
                                                              children: [
                                                                Stack(
                                                                  children: [
                                                                    Image.asset(
                                                                      'assets/png/emprestimo.png',
                                                                      width:
                                                                          screenWidth *
                                                                              0.3,
                                                                      height:
                                                                          screenHeight *
                                                                              0.1,
                                                                    ),
                                                                    if (isLocked)
                                                                      Icon(
                                                                        Icons
                                                                            .lock,
                                                                        size: screenWidth *
                                                                            0.1,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                    width: screenWidth *
                                                                        0.002),
                                                                Expanded(
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        "Você anunciouaaaa:",
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          fontSize:
                                                                              responsiveFontSize(14.0),
                                                                          color:
                                                                              const Color(0xff14131a),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        exemplarDetalhes
                                                                            .titulo,
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          fontSize:
                                                                              responsiveFontSize(14.0),
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              const Color(0xff14131a),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                          height:
                                                                              screenHeight * 0.005),
                                                                      SingleChildScrollView(
                                                                        scrollDirection:
                                                                            Axis.horizontal,
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            for (var item
                                                                                in exemplarDetalhes.categorias)
                                                                              _buildCategory(item),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                          height:
                                                                              screenHeight * 0.01),
                                                                      Image
                                                                          .asset(
                                                                        'assets/png/doacao.png',
                                                                        width: screenWidth *
                                                                            0.1,
                                                                        height: screenHeight *
                                                                            0.05,
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
                                              ],
                                            );

                                            // fim da exibição de exemplar da transação quando há apenas um exemplar
                                          } else {
                                            // exibição do exemplar do usuário quando tem mais de um exemplar
                                            final exemplarIdCompleter =
                                                Completer<String>();

                                            SharedPreferences.getInstance()
                                                .then((prefs) async {
                                              String? userId =
                                                  prefs.getString('userId');
                                              for (int i = 0;
                                                  i <
                                                      transacao
                                                          .exemplaresId.length;
                                                  i++) {
                                                final id =
                                                    transacao.exemplaresId[i];
                                                final exemplarDetalhes =
                                                    await ExemplarDetalhesService()
                                                        .fetchExemplarDetalhes(
                                                            id);

                                                if (exemplarDetalhes.usuID ==
                                                    userId) {
                                                  exemplarIdCompleter
                                                      .complete(id);
                                                  break;
                                                }
                                              }

                                              if (!exemplarIdCompleter
                                                  .isCompleted) {
                                                exemplarIdCompleter.completeError(
                                                    'Nenhum exemplar encontrado');
                                              }
                                            });

                                            exemplarIdCompleter.future
                                                .then((exemplarId) {
                                              return Column(
                                                children: [
                                                  FutureBuilder<
                                                      ExemplarDetalhesModel>(
                                                    future: ExemplarDetalhesService()
                                                        .fetchExemplarDetalhes(
                                                            exemplarIdCompleter
                                                                    .future
                                                                as String),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        return const Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        );
                                                      } else if (snapshot
                                                          .hasError) {
                                                        return Center(
                                                          child: Text(
                                                            'Erro ao carregar exemplar',
                                                            style: TextStyle(
                                                              color: const Color(
                                                                  0xffcd4e4e),
                                                              fontSize:
                                                                  responsiveFontSize(
                                                                      14.0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  'Poppins',
                                                            ),
                                                          ),
                                                        );
                                                      } else {
                                                        final exemplarDetalhes =
                                                            snapshot.data!;

                                                        return Column(
                                                          children: [
                                                            FutureBuilder<
                                                                ExemplarDetalhesModel>(
                                                              future: ExemplarDetalhesService()
                                                                  .fetchExemplarDetalhes(
                                                                      exemplarIdCompleter
                                                                              .future
                                                                          as String),
                                                              builder: (context,
                                                                  snapshot) {
                                                                if (snapshot
                                                                        .connectionState ==
                                                                    ConnectionState
                                                                        .waiting) {
                                                                  return const Center(
                                                                    child:
                                                                        CircularProgressIndicator(),
                                                                  );
                                                                } else if (snapshot
                                                                    .hasError) {
                                                                  return Center(
                                                                    child: Text(
                                                                      'Erro ao carregar exemplar',
                                                                      style:
                                                                          TextStyle(
                                                                        color: const Color(
                                                                            0xffcd4e4e),
                                                                        fontSize:
                                                                            responsiveFontSize(14.0),
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            'Poppins',
                                                                      ),
                                                                    ),
                                                                  );
                                                                } else {
                                                                  final exemplarDetalhes =
                                                                      snapshot
                                                                          .data!;
                                                                  bool
                                                                      isLocked =
                                                                      exemplarDetalhes
                                                                          .negociando;
                                                                  return InkWell(
                                                                    onTap: () {
                                                                      if (!isLocked) {
                                                                        print(
                                                                            'Caixa $index clicada');
                                                                      } else {
                                                                        Navigator
                                                                            .push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => const ProdutoNegociacaoNegociacoes()),
                                                                        );
                                                                      }
                                                                    },
                                                                    child:
                                                                        Opacity(
                                                                      opacity: isLocked
                                                                          ? 0.5
                                                                          : 1,
                                                                      child:
                                                                          Container(
                                                                        margin: EdgeInsets.all(screenWidth *
                                                                            0.05),
                                                                        padding:
                                                                            EdgeInsets.all(screenWidth *
                                                                                0.02),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              const Color(0xfff6f5f2),
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                              color: Colors.grey.withOpacity(0.5),
                                                                              spreadRadius: 5,
                                                                              blurRadius: 7,
                                                                              offset: const Offset(0, 3),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        child:
                                                                            Row(
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
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    "Você anunciouaaaa:",
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'Poppins',
                                                                                      fontSize: responsiveFontSize(14.0),
                                                                                      color: const Color(0xff14131a),
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    exemplarDetalhes.titulo,
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
                                                                                        for (var item in exemplarDetalhes.categorias) _buildCategory(item),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(height: screenHeight * 0.01),
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
                                                          ],
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ],
                                              );
                                            }).catchError((error) {
                                              return Column(
                                                children: [
                                                  Text(
                                                    "Erro ao carregar exemplar",
                                                    style: TextStyle(
                                                      color: const Color(
                                                          0xffcd4e4e),
                                                      fontSize:
                                                          responsiveFontSize(
                                                              14.0),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Poppins',
                                                    ),
                                                  ),
                                                ],
                                              );
                                            });

                                            // fim da exibição do exemplar do usuário quando tem mais de um exemplar
                                          }
                                          return Text(
                                            "Nada a exibir",
                                            style: TextStyle(
                                              color: const Color(0xff14131a),
                                              fontSize:
                                                  responsiveFontSize(14.0),
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Poppins',
                                            ),
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

                        // Fim da parte de transacao como leitor
                      ],
                    ),
                  ),

                  // ===================================
                  // Container(
                  //   color: const Color(0xfff6f5f2),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Expanded(
                  //         child: ListView.builder(
                  //           itemCount: 10,
                  //           itemBuilder: (context, index) {
                  //             bool isLocked = index % 2 ==
                  //                 0; // Condição temporária para simular caixas bloqueadas
                  //             return InkWell(
                  //               onTap: () {
                  //                 if (!isLocked) {
                  //                   print('Caixa $index clicada');
                  //                 } else {
                  //                   Navigator.push(
                  //                     context,
                  //                     MaterialPageRoute(
                  //                         builder: (context) =>
                  //                             const ProdutoNegociacaoNegociacoes()),
                  //                   );
                  //                 }
                  //               },
                  //               child: Opacity(
                  //                 opacity: isLocked ? 0.5 : 1,
                  //                 child: Container(
                  //                   margin: EdgeInsets.all(screenWidth * 0.05),
                  //                   padding: EdgeInsets.all(screenWidth * 0.02),
                  //                   decoration: BoxDecoration(
                  //                     color: const Color(0xfff6f5f2),
                  //                     borderRadius: BorderRadius.circular(8.0),
                  //                     boxShadow: [
                  //                       BoxShadow(
                  //                         color: Colors.grey.withOpacity(0.5),
                  //                         spreadRadius: 5,
                  //                         blurRadius: 7,
                  //                         offset: const Offset(0, 3),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                   child: Row(
                  //                     children: [
                  //                       Stack(
                  //                         children: [
                  //                           Image.asset(
                  //                             'assets/png/emprestimo.png',
                  //                             width: screenWidth * 0.3,
                  //                             height: screenHeight * 0.1,
                  //                           ),
                  //                           if (isLocked)
                  //                             Icon(
                  //                               Icons.lock,
                  //                               size: screenWidth * 0.1,
                  //                               color: Colors.grey,
                  //                             ),
                  //                         ],
                  //                       ),
                  //                       SizedBox(width: screenWidth * 0.002),
                  //                       Expanded(
                  //                         child: Column(
                  //                           crossAxisAlignment:
                  //                               CrossAxisAlignment.start,
                  //                           children: [
                  //                             Text(
                  //                               'Nome do livro',
                  //                               style: TextStyle(
                  //                                 fontFamily: 'Poppins',
                  //                                 fontSize:
                  //                                     responsiveFontSize(14.0),
                  //                                 fontWeight: FontWeight.bold,
                  //                                 color:
                  //                                     const Color(0xff14131a),
                  //                               ),
                  //                             ),
                  //                             SizedBox(
                  //                                 height: screenHeight * 0.005),
                  //                             SingleChildScrollView(
                  //                               scrollDirection:
                  //                                   Axis.horizontal,
                  //                               child: Row(
                  //                                 children: [
                  //                                   _buildCategory('Aventura'),
                  //                                   _buildCategory('Biografia'),
                  //                                 ],
                  //                               ),
                  //                             ),
                  //                             SizedBox(
                  //                                 height: screenHeight * 0.01),
                  //                             Image.asset(
                  //                               'assets/png/doacao.png',
                  //                               width: screenWidth * 0.1,
                  //                               height: screenHeight * 0.05,
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
                  //             );
                  //           },
                  //         ),
                  //       ),
                  //       SizedBox(height: screenHeight * 0.1),
                  //     ],
                  //   ),
                  // ),
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

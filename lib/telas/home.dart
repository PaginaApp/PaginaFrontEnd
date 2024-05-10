import 'package:flutter/material.dart';
import 'package:projeto_pagina/data/models/exemplar_detalhes_model.dart';
import 'package:projeto_pagina/data/repositories/exemplar_repository.dart';
import 'package:projeto_pagina/data/repositories/produto_repository.dart';
import 'package:projeto_pagina/services/exemplar_detalhes_service.dart';
import 'package:projeto_pagina/stores/exemplar_store.dart';
import 'package:projeto_pagina/stores/produto_store.dart';
import 'package:projeto_pagina/telas/configuracoes.dart';
import 'package:projeto_pagina/telas/home_categorias.dart';
import 'package:projeto_pagina/telas/produto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ExemplarStore exemplarStore =
      ExemplarStore(exemplarRepository: ExemplarRepository());

  @override
  void initState() {
    super.initState();
    exemplarStore.getExemplares(1, 50);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double responsiveFontSize(double fontSize) {
      return fontSize * screenWidth / 375.0;
    }

    return Scaffold(
      backgroundColor: const Color(0xfff6f5f2),
      body: Column(
        children: [
          Container(
            color: const Color(0xff4e90cd),
            child: Column(
              children: [
                Row(
                  children: [
                    // Barra de pesquisa
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.07),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Título, autor, editora...',
                            hintStyle: TextStyle(
                                color: const Color(0xff14131a),
                                fontFamily: 'Poppins',
                                fontSize: responsiveFontSize(14.0)),
                            fillColor: const Color(0xfff6f5f2),
                            filled: true,
                            prefixIcon: Icon(
                              Icons.search,
                              color: const Color(0xff14131a),
                              size: responsiveFontSize(22.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Círculo de perfil
                    Padding(
                      padding: EdgeInsets.all(screenWidth * 0.03),
                      child: ElevatedButton(
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();

                          String? userId = prefs.getString('userId');
                          String? token = prefs.getString('token');

                          print("user id pego no shared preferences");
                          print(userId);
                          print("token pego no shared preferences");
                          print(token);

                          if (mounted) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Configuracoes(
                                  userId: userId,
                                  token: token,
                                ),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: const CircleBorder(),
                        ),
                        child: CircleAvatar(
                          radius: screenWidth * 0.07,
                          child: const Icon(
                            Icons.person,
                            color: Color(0xff4e90cd),
                          ),
                          //backgroundImage: NetworkImage('urlDaImagem'), //URL da imagem
                        ),
                      ),
                    ),
                  ],
                ),
                // Caixa com rolagem
                SizedBox(
                  height: screenHeight * 0.14,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildBox('Aventura'),
                        _buildBox('Biografia'),
                        _buildBox('Contos'),
                        _buildBox('Drama'),
                        _buildBox('Fantasia'),
                        _buildButton('...'),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCircle('Doação'),
                    _buildCircle('Empréstimo'),
                    _buildCircle('Troca'),
                    _buildCircle('Venda'),
                  ],
                ),
              ],
            ),
          ),
          // Parte branca
          Expanded(
            // PAREI AQUI
            child: Container(
              color: const Color(0xfff6f5f2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(screenWidth * 0.06),
                    child: Text(
                      'Descubra!',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: responsiveFontSize(16.0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Lista de exemplares
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
                        return Expanded(
                          child: ListView.builder(
                            itemCount: exemplarStore.state.value
                                .length, // trocar por items.length quando a API estiver pronta
                            itemBuilder: (context, index) {
                              final exemplar = exemplarStore.state.value[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Produto(exemplarId: exemplar.id),
                                    ),
                                  );
                                  //exemplarStore.getExemplares(1, 10);
                                  print(exemplar.id);
                                  print(exemplar.descricao);

                                  //print(produtoStore.state.value.length);
                                },
                                child: FutureBuilder<ExemplarDetalhesModel>(
                                  future: ExemplarDetalhesService()
                                      .fetchExemplarDetalhes(exemplar.id),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Center(
                                        child: Text(
                                          'Erro ao carregar exemplar',
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
                                      return Container(
                                        margin:
                                            EdgeInsets.all(screenWidth * 0.05),
                                        padding:
                                            EdgeInsets.all(screenWidth * 0.02),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              'assets/png/emprestimo.png', // Trocar pela URL da imagem do livro quando a API estiver pronta
                                              width: screenWidth * 0.3,
                                              height: screenHeight * 0.1,
                                            ),
                                            SizedBox(
                                                width: screenWidth * 0.002),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    exemplarDetalhes
                                                        .titulo, // Trocar pelo nome do livro quando a API estiver pronta
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize:
                                                          responsiveFontSize(
                                                              15.0),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          screenHeight * 0.005),
                                                  SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Row(
                                                      children: [
                                                        // Trocar pelo nome das categorias quando a API estiver pronta
                                                        _buildCategory(
                                                            'Aventura'),
                                                        _buildCategory(
                                                            'Biografia'),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          screenHeight * 0.01),
                                                  Image.asset(
                                                    'assets/png/doacao.png', // Trocar pela URL da imagem de doação, empréstimo, troca ou venda
                                                    width: screenWidth * 0.1,
                                                    height: screenHeight * 0.05,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBox(String text) {
    double screenWidth = MediaQuery.of(context).size.width;

    double responsiveFontSize(double fontSize) {
      return fontSize * screenWidth / 375.0;
    }

    return Container(
      width: screenWidth * 0.25,
      height: screenWidth * 0.1,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xff4e90cd),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xfff6f5f2)),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: responsiveFontSize(14),
            color: const Color(0xfff6f5f2),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String text) {
    double screenWidth = MediaQuery.of(context).size.width;

    double responsiveFontSize(double fontSize) {
      return fontSize * screenWidth / 375.0;
    }

    return Container(
      width: screenWidth * 0.25,
      height: screenWidth * 0.1,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xff4e90cd),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xfff6f5f2)),
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xfff6f5f2),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeCategorias(),
            ),
          );
        },
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: responsiveFontSize(15),
          ),
        ),
      ),
    );
  }

  Widget _buildCircle(String text) {
    double radius = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double responsiveFontSize(double fontSize) {
      return fontSize * radius / 375.0;
    }

    final images = {
      'Doação': 'assets/png/doacao.png',
      'Empréstimo': 'assets/png/emprestimo.png',
      'Troca': 'assets/png/troca.png',
      'Venda': 'assets/png/venda.png',
    };
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: const Color(0xfff6f5f2),
          radius: radius * 0.055,
          child: ClipOval(
            child: Image.asset(
              images[text] ?? '',
              fit: BoxFit.cover,
              width: 40,
              height: 40,
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.008),
        Text(
          text,
          style: TextStyle(
            color: const Color(0xfff6f5f2),
            fontFamily: 'Poppins',
            fontSize: responsiveFontSize(13.0),
          ),
        ),
      ],
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
          fontFamily: 'Poppins',
          fontSize: responsiveFontSize(11.0),
          color: const Color(0xff14131a),
        ),
      ),
    );
  }
}

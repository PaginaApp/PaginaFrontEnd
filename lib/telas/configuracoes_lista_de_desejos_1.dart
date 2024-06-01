// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:projeto_pagina/data/repositories/desejo_repository.dart';
import 'package:projeto_pagina/data/repositories/produto_repository.dart';
import 'package:projeto_pagina/stores/desejo_store.dart';
import 'package:projeto_pagina/stores/produto_store.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ConfiguracoesListaDeDesejos1 extends StatefulWidget {
  const ConfiguracoesListaDeDesejos1({super.key});

  @override
  State<ConfiguracoesListaDeDesejos1> createState() =>
      _ConfiguracoesListaDeDesejos1State();
}

class _ConfiguracoesListaDeDesejos1State
    extends State<ConfiguracoesListaDeDesejos1> {
  final ProdutoStore produtoStore = ProdutoStore(
    produtoRepository: ProdutoRepository(),
  );

  final DesejoStore desejoStore = DesejoStore(
    desejoRepository: DesejoRepository(),
  );

  @override
  void initState() {
    super.initState();
    produtoStore.getProdutos(1, 50);
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
              'Lista de Desejos',
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
          SizedBox(
            width: screenWidth * 0.9,
            child: Text(
              'Pesquise para adicionar mais livros à sua lista de desejos.',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: responsiveFontSize(14.0),
                color: const Color(0xff14131a),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.07),
                  child: TextField(
                    onSubmitted: (query) async {
                      bool success = await _handlePesquisarProdutos(query);

                      if (success && mounted) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Livro encontrado com sucesso!',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: responsiveFontSize(16.0),
                              ),
                            ),
                            duration: const Duration(seconds: 5),
                            backgroundColor: const Color(0xff4ecd72),
                          ),
                        );
                      } else if (mounted) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Livro não encontrado!',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: responsiveFontSize(16.0),
                              ),
                            ),
                            duration: const Duration(seconds: 5),
                            backgroundColor: const Color(0xffec4e4e),
                          ),
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => super.widget,
                          ),
                        );
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Pesquise por título ou ISBN',
                      hintStyle: TextStyle(
                        color: const Color(0xff14131a),
                        fontFamily: 'Poppins',
                        fontSize: responsiveFontSize(14.0),
                      ),
                      fillColor: const Color(0xfff6f5f2),
                      filled: true,
                      prefixIcon: const Icon(Icons.search),
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

          // ====================================================================

          AnimatedBuilder(
            animation: Listenable.merge([
              produtoStore.isLoading,
              produtoStore.error,
              produtoStore.state,
            ]),
            builder: (context, child) {
              if (produtoStore.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (produtoStore.error.value.isNotEmpty) {
                return Center(
                  child: Text(
                    "Falha ao carregar livros, verifique sua conexão",
                    style: TextStyle(
                      color: const Color(0xffcd4e4e),
                      fontSize: responsiveFontSize(14.0),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                );
              }

              if (produtoStore.state.value.isEmpty) {
                return Center(
                  child: Text(
                    'Nenhum livro encontrado',
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
                  child: Container(
                    color: const Color(0xfff6f5f2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: produtoStore.state.value.length,
                            itemBuilder: (context, index) {
                              final livro = produtoStore.state.value[index];
                              return InkWell(
                                onTap: () {},
                                child: Container(
                                  margin: EdgeInsets.all(screenWidth * 0.05),
                                  padding: EdgeInsets.all(screenWidth * 0.02),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
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
                                      Image.network(
                                        dotenv.env['BASE_API_URL']! +
                                            dotenv.env['IMAGEM_EXEMPLAR']!,
                                        width: screenWidth * 0.15,
                                        height: screenHeight * 0.1,
                                      ),
                                      SizedBox(width: screenWidth * 0.002),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              livro.titulo,
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize:
                                                    responsiveFontSize(14.0),
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xff14131a),
                                              ),
                                            ),
                                            SizedBox(
                                                height: screenHeight * 0.005),
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: [
                                                  for (var categoria
                                                      in livro.categorias)
                                                    _buildCategory(categoria),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                                height: screenHeight * 0.01),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.add,
                                              color: const Color(0xff4e90cd),
                                              size: screenWidth * 0.08,
                                            ),
                                            onPressed: () async {
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              String id =
                                                  prefs.getString('userId')!;
                                              bool addDesejoSuccess =
                                                  await _handleAddDesejo(
                                                      id, livro.id);

                                              if (addDesejoSuccess && mounted) {
                                                ScaffoldMessenger.of(context)
                                                    .hideCurrentSnackBar();

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Livro adicionado à lista de desejos!',
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize:
                                                            responsiveFontSize(
                                                                16.0),
                                                      ),
                                                    ),
                                                    duration: const Duration(
                                                        seconds: 5),
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
                                                      'Falha ao adicionar livro à lista de desejos',
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize:
                                                            responsiveFontSize(
                                                                16.0),
                                                      ),
                                                    ),
                                                    duration: const Duration(
                                                        seconds: 5),
                                                    backgroundColor:
                                                        const Color(0xffec4e4e),
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),

          // ====================================================================
        ],
      ),
    );
  }

  // método para lidar com a pesquisa de livros
  Future<bool> _handlePesquisarProdutos(String query) async {
    try {
      await produtoStore.pesquisarProdutos(query);
      return true;
    } catch (e) {
      return false;
    }
  }

  // método para lidar com o adicionar livro na lista de desejos
  Future<bool> _handleAddDesejo(String id, String idLivro) async {
    try {
      await desejoStore.addDesejo(id, idLivro);
      return true;
    } catch (e) {
      return false;
    }
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

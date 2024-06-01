// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:projeto_pagina/data/models/produto_model.dart';
import 'package:projeto_pagina/data/repositories/desejo_repository.dart';
import 'package:projeto_pagina/data/repositories/produto_repository.dart';
import 'package:projeto_pagina/stores/desejo_store.dart';
import 'package:projeto_pagina/telas/configuracoes_lista_de_desejos_1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ConfiguracoesListaDeDesejos extends StatefulWidget {
  const ConfiguracoesListaDeDesejos({super.key});

  @override
  State<ConfiguracoesListaDeDesejos> createState() =>
      _ConfiguracoesListaDeDesejosState();
}

class _ConfiguracoesListaDeDesejosState
    extends State<ConfiguracoesListaDeDesejos> {
  final DesejoStore desejoStore =
      DesejoStore(desejoRepository: DesejoRepository());

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      String? id = prefs.getString('userId');
      desejoStore.getDesejos(1, 10, id ?? '');
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

          // =============================================================================

          AnimatedBuilder(
            animation: Listenable.merge([
              desejoStore.isLoading,
              desejoStore.error,
              desejoStore.state,
            ]),
            builder: (context, child) {
              if (desejoStore.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (desejoStore.error.value.isNotEmpty) {
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

              if (desejoStore.state.value.isEmpty) {
                return Center(
                  child: Column(
                    children: [
                      Text(
                        'Nenhum livro encontrado.',
                        style: TextStyle(
                          color: const Color(0xff14131a),
                          fontSize: responsiveFontSize(14.0),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        'Clique no botão abaixo para procurar livros.',
                        style: TextStyle(
                          color: const Color(0xff14131a),
                          fontSize: responsiveFontSize(14.0),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      )
                    ],
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
                            itemCount: desejoStore.state.value.length,
                            itemBuilder: (context, index) {
                              final desejo = desejoStore.state.value[index];
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
                                              desejo.titulo,
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
                                              child: FutureBuilder<
                                                  List<ProdutoModel>>(
                                                future: ProdutoRepository()
                                                    .findByISBN(desejo.isbn),
                                                builder: (context, snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    );
                                                  } else if (snapshot
                                                      .hasError) {
                                                    return Text(
                                                      'Erro ao carregar categorias',
                                                      style: TextStyle(
                                                        color: const Color(
                                                            0xffcd4e4e),
                                                        fontSize:
                                                            responsiveFontSize(
                                                                12.0),
                                                        fontFamily: 'Poppins',
                                                      ),
                                                    );
                                                  } else {
                                                    final livro =
                                                        snapshot.data!;
                                                    return Row(
                                                      children: livro[0]
                                                          .categorias
                                                          .map((categoria) {
                                                        return _buildCategory(
                                                            categoria);
                                                      }).toList(),
                                                    );
                                                  }
                                                },
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
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Color(0xffcd4e4e),
                                            ),
                                            onPressed: () async {
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              String id =
                                                  prefs.getString('userId')!;

                                              bool deleteDesejoSuccess =
                                                  await _handleDeleteDesejo(
                                                      id, desejo.livID);

                                              if (deleteDesejoSuccess &&
                                                  mounted) {
                                                ScaffoldMessenger.of(context)
                                                    .hideCurrentSnackBar();

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Livro removido da lista de desejos com sucesso',
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

                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
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
                                                      'Falha ao remover livro da lista de desejos',
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
                        SizedBox(height: screenHeight * 0.1),
                      ],
                    ),
                  ),
                );
              }
            },
          ),

          // ==============================================================================
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    const ConfiguracoesListaDeDesejos1()),
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

  // método para lidar com a remoção de um livro da lista de desejos
  Future<bool> _handleDeleteDesejo(String id, String idLivro) async {
    try {
      await desejoStore.deleteDesejo(id, idLivro);
      return true;
    } catch (e) {
      return false;
    }
  }
}

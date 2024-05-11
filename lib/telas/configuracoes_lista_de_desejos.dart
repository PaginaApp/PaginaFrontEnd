import 'package:flutter/material.dart';
import 'package:projeto_pagina/data/repositories/desejo_repository.dart';
import 'package:projeto_pagina/stores/desejo_store.dart';
import 'package:projeto_pagina/telas/configuracoes_lista_de_desejos_1.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.07),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Título, autor, editora...',
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
                            itemCount: desejoStore.state.value
                                .length, // trocar por items.length quando a API estiver pronta
                            itemBuilder: (context, index) {
                              final desejo = desejoStore.state.value[index];
                              return InkWell(
                                onTap: () async {
                                  print(
                                      'Caixa $index clicada'); // Trocar pela ação ao clicar
                                },
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
                                      Image.asset(
                                        'assets/png/emprestimo.png', // Trocar pela URL da imagem do livro quando a API estiver pronta
                                        width: screenWidth * 0.3,
                                        height: screenHeight * 0.1,
                                      ),
                                      SizedBox(width: screenWidth * 0.002),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              desejo
                                                  .titulo, // Trocar pelo nome do livro quando a API estiver pronta
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
                                                  // Trocar pelo nome das categorias quando a API estiver pronta
                                                  _buildCategory('Aventura'),
                                                  _buildCategory('Biografia'),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                                height: screenHeight * 0.01),
                                            Row(
                                              children: [
                                                Image.asset(
                                                  // Trocar pela URL da imagem de doação, empréstimo, troca ou venda
                                                  // Vou precisar fazer algo para adicionar mais imagens
                                                  'assets/png/doacao.png',
                                                  width: screenWidth * 0.1,
                                                  height: screenHeight * 0.05,
                                                ),
                                              ],
                                            )
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

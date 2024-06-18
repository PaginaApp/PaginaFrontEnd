// ignore_for_file: use_build_context_synchronously

import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pagina/data/repositories/exemplar_repository.dart';
import 'package:projeto_pagina/stores/exemplar_store.dart';
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
  List<String> selectedNegotiationTypes = [];
  List<String> selectedCategories = [];
  TextEditingController searchController = TextEditingController();

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
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: 'Pesquise por título',
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
                        final searchText = searchController.text.toLowerCase();
                        final filteredExemplares =
                            exemplarStore.state.value.where((exemplar) {
                          final matchesNegotiationType =
                              selectedNegotiationTypes.isEmpty ||
                                  exemplar.tiposTransacoes.any(
                                      (tipoTransacao) =>
                                          selectedNegotiationTypes.contains(
                                              removeDiacritics(tipoTransacao)));

                          final matchesCategory = selectedCategories.isEmpty ||
                              exemplar.categorias.any((categoria) =>
                                  selectedCategories.contains(categoria));

                          final matchesSearchText = searchText.isEmpty ||
                              exemplar.titulo
                                  .toLowerCase()
                                  .contains(searchText);

                          return matchesNegotiationType &&
                              matchesCategory &&
                              matchesSearchText;
                        }).toList();
                        return Expanded(
                          child: ListView.builder(
                            itemCount: filteredExemplares.length,
                            itemBuilder: (context, index) {
                              final exemplar = filteredExemplares[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Produto(exemplarId: exemplar.id),
                                    ),
                                  );
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
                                        'assets/png/imagem_exemplar.png',
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
                                              exemplar.titulo,
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize:
                                                    responsiveFontSize(15.0),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                                height: screenHeight * 0.005),
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: [
                                                  for (var categoria
                                                      in exemplar.categorias)
                                                    _buildCategory(categoria),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                                height: screenHeight * 0.01),
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: [
                                                  for (var tipoTransacao
                                                      in exemplar
                                                          .tiposTransacoes) ...[
                                                    Image.asset(
                                                      'assets/png/${removeDiacritics(tipoTransacao).toLowerCase()}.png',
                                                      width: screenWidth * 0.1,
                                                      height:
                                                          screenHeight * 0.05,
                                                    ),
                                                    SizedBox(
                                                        width: screenWidth *
                                                            0.015),
                                                  ]
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
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

    bool isSelected = selectedCategories.contains(text);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedCategories.remove(text);
          } else {
            selectedCategories.add(text);
          }
        });
      },
      child: Container(
        width: screenWidth * 0.25,
        height: screenWidth * 0.1,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xff4e90cd),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: isSelected
                  ? const Color(0xff1f1d34)
                  : const Color(0xfff6f5f2)),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: responsiveFontSize(14),
              color: isSelected
                  ? const Color(0xff1f1d34)
                  : const Color(0xfff6f5f2),
            ),
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
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeCategorias(
                selectedCategories: selectedCategories,
                removedCategories: const [],
              ),
            ),
          );

          if (result != null) {
            setState(() {
              selectedCategories =
                  (selectedCategories + result['selectedCategories'])
                      .toSet()
                      .toList();
              selectedCategories.removeWhere((element) {
                return result['removedCategories'].contains(element);
              });
            });
          }
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

    bool isSelected = selectedNegotiationTypes.contains(removeDiacritics(text));

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedNegotiationTypes.remove(removeDiacritics(text));
          } else {
            selectedNegotiationTypes.add(removeDiacritics(text));
          }
        });
      },
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor:
                isSelected ? const Color(0xff1f1d34) : const Color(0xfff6f5f2),
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
              color: isSelected
                  ? const Color(0xff1f1d34)
                  : const Color(0xfff6f5f2),
              fontFamily: 'Poppins',
              fontSize: responsiveFontSize(13.0),
            ),
          ),
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
          fontFamily: 'Poppins',
          fontSize: responsiveFontSize(12.0),
          color: const Color(0xfff6f5f2),
        ),
      ),
    );
  }
}

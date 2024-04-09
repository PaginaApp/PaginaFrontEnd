import 'package:flutter/material.dart';
import 'package:projeto_pagina/telas/configuracoes_acervo_cadastros_add.dart';

class ConfiguracoesAcervoCadastros extends StatefulWidget {
  const ConfiguracoesAcervoCadastros({super.key});

  @override
  State<ConfiguracoesAcervoCadastros> createState() =>
      _ConfiguracoesAcervoCadastrosState();
}

class _ConfiguracoesAcervoCadastrosState
    extends State<ConfiguracoesAcervoCadastros> {
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
                  Container(
                    color: const Color(0xfff6f5f2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              bool isLocked = index % 2 ==
                                  0; // Condição temporária para simular caixas bloqueadas
                              return InkWell(
                                onTap: () {
                                  if (!isLocked) {
                                    print('Caixa $index clicada');
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
                                                'Nome do livro',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize:
                                                      responsiveFontSize(14.0),
                                                  color:
                                                      const Color(0xff14131a),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                  height: screenHeight * 0.005),
                                              SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  children: [
                                                    _buildCategory('Aventura'),
                                                    _buildCategory('Biografia'),
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
                                        Column(
                                          children: [
                                            IconButton(
                                              icon: const Icon(
                                                Icons.edit,
                                                color: Color(0xff4ecd72),
                                              ),
                                              onPressed: () {
                                                if (!isLocked) {
                                                  print(
                                                      'Botão de edição clicado');
                                                }
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Color(0xffcd4e4e),
                                              ),
                                              onPressed: () {
                                                if (!isLocked) {
                                                  print(
                                                      'Botão de exclusão clicado');
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
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
                  // Conteúdo da aba de negociações
                  Container(
                    color: const Color(0xfff6f5f2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              bool isLocked = index % 2 ==
                                  0; // Condição temporária para simular caixas bloqueadas
                              return InkWell(
                                onTap: () {
                                  if (!isLocked) {
                                    print('Caixa $index clicada');
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
                                                'Nome do livro',
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
                                                    _buildCategory('Aventura'),
                                                    _buildCategory('Biografia'),
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
                            },
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.1),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
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

import 'package:flutter/material.dart';

class ConfiguracoesHistorico extends StatefulWidget {
  const ConfiguracoesHistorico({super.key});

  @override
  State<ConfiguracoesHistorico> createState() => _ConfiguracoesHistoricoState();
}

class _ConfiguracoesHistoricoState extends State<ConfiguracoesHistorico> {
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
              'Histórico',
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
          Expanded(
            child: Container(
              color: const Color(0xfff6f5f2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount:
                          10, // trocar por items.length quando a API estiver pronta
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
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
                                        'Nome do livro', // Trocar pelo nome do livro quando a API estiver pronta
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
                                            // Trocar pelo nome das categorias quando a API estiver pronta
                                            _buildCategory('Aventura'),
                                            _buildCategory('Biografia'),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: screenHeight * 0.01),
                                      Row(
                                        children: [
                                          Image.asset(
                                            // Trocar pela URL da imagem de doação, empréstimo, troca ou venda
                                            // Vou precisar fazer algo para adicionar mais imagens
                                            'assets/png/doacao.png',
                                            width: screenWidth * 0.1,
                                            height: screenHeight * 0.05,
                                          ),
                                          SizedBox(width: screenWidth * 0.03),
                                          Text(
                                            // trocar pela data quando a API estiver pronta
                                            "dd/mm/aaaa",
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize:
                                                  responsiveFontSize(11.0),
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xff14131a),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
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

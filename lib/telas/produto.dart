import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pagina/data/models/exemplar_detalhes_model.dart';
import 'package:projeto_pagina/data/models/tipo_transacao_model.dart';
import 'package:projeto_pagina/services/exemplar_detalhes_service.dart';
import 'package:projeto_pagina/services/transacao_service.dart';
import 'package:projeto_pagina/telas/configuracoes_lista_de_desejos.dart';
import 'package:projeto_pagina/telas/confirmar_negociacao.dart';

class Produto extends StatefulWidget {
  final String exemplarId;

  const Produto({Key? key, required this.exemplarId}) : super(key: key);

  @override
  State<Produto> createState() => _ProdutoState();
}

class _ProdutoState extends State<Produto> {
  final ExemplarDetalhesService _exemplarService = ExemplarDetalhesService();
  late Future<ExemplarDetalhesModel> _exemplarDetalhesFuture;
  Future<List<TipoTransacaoModel>> tipoTransacaoFuture =
      TransacaoService().getTiposTransacao();

  String selectedNegotiationTypeId = '';

  final _controller = PageController();

  String selectedText = 'Total';
  List<bool> isSelected = [false, false, false, false];

  @override
  void initState() {
    super.initState();

    _exemplarDetalhesFuture =
        _exemplarService.fetchExemplarDetalhes(widget.exemplarId);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double responsiveFontSize(double fontSize) {
      return fontSize * screenWidth / 375.0;
    }

    return Scaffold(
      backgroundColor: const Color(0xfff6f5f2),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
              backgroundColor: const Color(0xfff6f5f2),
              title: Text(
                'Livro',
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
            SizedBox(height: screenHeight * 0.02),

            // ==============================================

            FutureBuilder<ExemplarDetalhesModel>(
              future: _exemplarDetalhesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Erro ao carregar dados',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: responsiveFontSize(16),
                        color: const Color(0xff14131a),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                } else {
                  final exemplar = snapshot.data!;
                  return Column(
                    children: [
                      // ==============================================

                      FutureBuilder<List<String>>(
                        future: ExemplarDetalhesService()
                            .fetchImagemExemplarId(exemplar.id),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text(
                              'Erro: Falha ao carregar imagens',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: responsiveFontSize(16),
                                color: const Color(0xff14131a),
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          } else {
                            return Column(
                              children: [
                                // ignore: sized_box_for_whitespace
                                Container(
                                  height: screenHeight * 0.25,
                                  child: PageView(
                                    controller: _controller,
                                    children: snapshot.data!.map((imageId) {
                                      return FutureBuilder<Image>(
                                        future: ExemplarDetalhesService()
                                            .fetchImagemExemplar(imageId),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const CircularProgressIndicator();
                                          } else if (snapshot.hasError) {
                                            return Text(
                                                'Erro: ${snapshot.error}');
                                          } else {
                                            return snapshot.data!;
                                          }
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.015),

                                SizedBox(
                                  width: screenWidth * 0.9,
                                  child: Text(
                                    'Arraste para o lado para ver mais imagens!',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: responsiveFontSize(14),
                                      color: const Color(0xff14131a),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),

                      // ----------------------------------------------

                      SizedBox(height: screenHeight * 0.02),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${exemplar.titulo} - ISBN ${exemplar.isbn}',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: responsiveFontSize(16),
                              color: const Color(0xff14131a),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      //----------------------------------------
                      FutureBuilder<ExemplarDetalhesModel>(
                        future: _exemplarDetalhesFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                'Erro ao carregar categorias',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: responsiveFontSize(16),
                                  color: const Color(0xff14131a),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          } else {
                            final exemplar = snapshot.data!;
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.05),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      for (var categoria in exemplar.categorias)
                                        _buildCategory(categoria),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                      //----------------------------------------
                      SizedBox(height: screenHeight * 0.01),
                      Container(
                        color: const Color(0xfff6f5f2),
                        child: ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.all(screenWidth * 0.05),
                          children: [
                            _buildBox('Autor: ${exemplar.autor}', Icons.person),
                            _buildBox(
                                'Editora: ${exemplar.editora}', Icons.book),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Sinopse',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: responsiveFontSize(16),
                              color: const Color(0xff14131a),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            exemplar.sinopse,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: responsiveFontSize(14),
                              color: const Color(0xff14131a),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Estado de conservação',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: responsiveFontSize(16),
                              color: const Color(0xff14131a),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Capa',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: responsiveFontSize(14),
                              color: const Color(0xff14131a),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Páginas',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: responsiveFontSize(14),
                              color: const Color(0xff14131a),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // exemplo de estado de conservação
                        children: [
                          _buildRectangle(exemplar.estadoCapa),
                          _buildRectangle(exemplar.estadoPaginas),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      // Descrição do estado do livro
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            exemplar.descricao,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: responsiveFontSize(14),
                              color: const Color(0xff14131a),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Selecione uma forma de negociação',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: responsiveFontSize(16),
                              color: const Color(0xff14131a),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      // tipos de negociação
                      FutureBuilder<List<TipoTransacaoModel>>(
                        future: tipoTransacaoFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                'Erro ao carregar tipos de negociação',
                                style: TextStyle(
                                  color: const Color(0xffcd4e4e),
                                  fontSize: responsiveFontSize(14.0),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            );
                          } else {
                            final tipoTransacao = snapshot.data!;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                if (exemplar.tiposTransacoes.isEmpty)
                                  Text(
                                    'Nenhuma forma de negociação disponível',
                                    style: TextStyle(
                                      color: const Color(0xffcd4e4e),
                                      fontSize: responsiveFontSize(13.0),
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins',
                                    ),
                                  )
                                else
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          for (var tipo
                                              in exemplar.tiposTransacoes)
                                            if (removeDiacritics(tipo) ==
                                                'Emprestimo') ...[
                                              _buildCircle(
                                                  'Empréstimo',
                                                  0,
                                                  exemplar.prazo == null
                                                      ? 'Indefinido'
                                                      : "${exemplar.prazo} dias",
                                                  tipoTransacao[0].id),
                                              SizedBox(
                                                  width: screenWidth * 0.07)
                                            ] else if (tipo == 'Troca')
                                              _buildCircle(
                                                'Troca',
                                                1,
                                                '',
                                                tipoTransacao[3].id,
                                              )
                                        ],
                                      ),
                                      SizedBox(height: screenHeight * 0.02),
                                      Row(
                                        children: [
                                          for (var tipo
                                              in exemplar.tiposTransacoes)
                                            if (tipo == 'Venda') ...[
                                              _buildCircle(
                                                'Venda',
                                                2,
                                                exemplar.preco == null
                                                    ? '0'
                                                    : exemplar.preco.toString(),
                                                tipoTransacao[1].id,
                                              ),
                                              SizedBox(
                                                  width: screenWidth * 0.2),
                                            ] else if (tipo == 'Doação')
                                              _buildCircle(
                                                'Doação',
                                                3,
                                                '',
                                                tipoTransacao[2].id,
                                              )
                                        ],
                                      ),
                                    ],
                                  )
                              ],
                            );
                          }
                        },
                      ),

                      // fim dos tipos de negociação
                      SizedBox(height: screenHeight * 0.02),
                      ElevatedButton(
                        onPressed: exemplar.tiposTransacoes.isEmpty
                            ? null
                            : () {
                                if (selectedNegotiationTypeId != '') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ConfirmarNegociacao(
                                        exemplarUsuarioId: exemplar.usuID,
                                        exemplarId: exemplar.id,
                                        negotiationTypeId:
                                            selectedNegotiationTypeId,
                                      ),
                                    ),
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          'Erro',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: responsiveFontSize(16.0),
                                          ),
                                        ),
                                        content: Text(
                                          'Por favor, selecione um tipo de negociação',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: responsiveFontSize(14.0),
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text(
                                              'Fechar',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize:
                                                    responsiveFontSize(14.0),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff4e90cd),
                          foregroundColor: const Color(0xfff6f5f2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          "Negociar",
                          style: TextStyle(
                            fontSize: responsiveFontSize(16.0),
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.1),
                    ],
                  );
                }
              },
            ),

            // ==============================================
          ],
        ),
      ),
    );
  }

  Widget _buildCircle(String text, int index, String attribute, String id) {
    double radius = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double responsiveFontSize(double fontSize) {
      return fontSize * radius / 375.0;
    }

    final images = {
      'Empréstimo': 'assets/png/emprestimo.png',
      'Troca': 'assets/png/troca.png',
      'Venda': 'assets/png/venda.png',
      'Doação': 'assets/png/doacao.png',
    };
    return Column(
      children: [
        ToggleButtons(
          borderWidth: 0.0,
          isSelected: [isSelected[index]],
          onPressed: (int newIndex) {
            setState(() {
              for (int i = 0; i < isSelected.length; i++) {
                if (i == index) {
                  isSelected[i] = true;
                  selectedText = text;
                  selectedNegotiationTypeId = id;
                } else {
                  isSelected[i] = false;
                }
              }
            });
          },
          children: [
            Column(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xfff6f5f2),
                  radius: radius * 0.055,
                  child: ClipOval(
                    child: Image.asset(
                      images[text] ?? '',
                      fit: BoxFit.cover,
                      width: radius * 0.1,
                      height: screenHeight * 0.1,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.008),
                Text(
                  text,
                  style: TextStyle(
                    color: const Color(0xff14131a),
                    fontFamily: 'Poppins',
                    fontSize: responsiveFontSize(13.0),
                  ),
                ),
              ],
            ),
          ],
        ),
        if (text == 'Empréstimo')
          Text(
            'Prazo: $attribute',
            style: TextStyle(
              color: const Color(0xff4e90cd),
              fontFamily: 'Poppins',
              fontSize: responsiveFontSize(11.0),
            ),
          ),
        if (text == 'Troca')
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ConfiguracoesListaDeDesejos()),
              );
            },
            child: Text(
              'Lista de desejos',
              style: TextStyle(
                color: const Color(0xff4e90cd),
                fontFamily: 'Poppins',
                fontSize: responsiveFontSize(11.0),
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        if (text == 'Venda')
          Text(
            'R\$ $attribute',
            style: TextStyle(
              color: const Color(0xff4e90cd),
              fontFamily: 'Poppins',
              fontSize: responsiveFontSize(11.0),
            ),
          ),
        if (text == 'Doação')
          Text(
            'Sem custo',
            style: TextStyle(
              color: const Color(0xff4e90cd),
              fontFamily: 'Poppins',
              fontSize: responsiveFontSize(11.0),
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

  Widget _buildBox(String title, IconData icon) {
    double screenHeight = MediaQuery.of(context).size.height;

    double responsiveFontSize(double size) {
      return size * MediaQuery.of(context).size.width / 375;
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
      decoration: BoxDecoration(
        color: const Color(0xfff6f5f2),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xff4e90cd)),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'Poppins',
            color: const Color(0xff14131a),
            fontSize: responsiveFontSize(14),
          ),
        ),
      ),
    );
  }

  Widget _buildRectangle(String text) {
    Color color;
    IconData icon;
    double screenWidth = MediaQuery.of(context).size.width;

    double responsiveFontSize(double fontSize) {
      return fontSize * screenWidth / 375.0;
    }

    switch (text) {
      case 'Ótimo estado':
        color = const Color(0xff4ecd72);
        icon = Icons.sentiment_very_satisfied;
        break;
      case 'Estado regular':
        color = const Color(0xff4e90cd);
        icon = Icons.sentiment_neutral;
        break;
      case 'Péssimo estado':
        color = const Color(0xffcd4e4e);
        icon = Icons.sentiment_very_dissatisfied;
        break;
      default:
        color = Colors.grey;
        icon = Icons.help;
        break;
    }

    return Container(
      padding: EdgeInsets.all(screenWidth * 0.035),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xfff6f5f2)),
          SizedBox(width: screenWidth * 0.02),
          Text(
            text,
            style: TextStyle(
              fontSize: responsiveFontSize(13.0),
              color: const Color(0xfff6f5f2),
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}

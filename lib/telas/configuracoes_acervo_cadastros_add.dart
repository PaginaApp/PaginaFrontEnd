import 'package:flutter/material.dart';
import 'package:projeto_pagina/data/models/estado_capa_model.dart';
import 'package:projeto_pagina/data/models/estado_paginas_model.dart';
import 'package:projeto_pagina/data/models/tipo_transacao_model.dart';
import 'package:projeto_pagina/data/repositories/produto_repository.dart';
import 'package:projeto_pagina/services/estado_capa_service.dart';
import 'package:projeto_pagina/services/estado_paginas_service.dart';
import 'package:projeto_pagina/services/tipo_transacao_service.dart';
import 'package:projeto_pagina/stores/produto_store.dart';

class ConfiguracoesAcervoCadastrosAdd extends StatefulWidget {
  const ConfiguracoesAcervoCadastrosAdd({super.key});

  @override
  State<ConfiguracoesAcervoCadastrosAdd> createState() =>
      _ConfiguracoesAcervoCadastrosAddState();
}

class _ConfiguracoesAcervoCadastrosAddState
    extends State<ConfiguracoesAcervoCadastrosAdd> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<bool> isPageStateSelected = [false, false, false];
  String selectedPageStateId = '';

  List<bool> isCoverStateSelected = [false, false, false];
  String selectedCoverStateId = '';

  bool isDonationSelected = false;
  bool isLoanSelected = false;
  bool isExchangeSelected = false;
  bool isSaleSelected = false;
  bool isNoneSelected = false;

  List<String> selectedNegotiationTypes = [];

  String dropdownValue = 'Selecione';

  // text controller para os campos de texto
  final TextEditingController isbnController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController publisherController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController synopsisController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController priceController = TextEditingController();
  final TextEditingController daysController = TextEditingController();

  Future<List<EstadoCapaModel>>? estadoCapaFuture;
  Future<List<EstadoPaginasModel>>? estadoPaginasFuture;
  Future<List<TipoTransacaoModel>>? tipoTransacaoFuture;

  final ProdutoStore produtoStore = ProdutoStore(
    produtoRepository: ProdutoRepository(),
  );

  @override
  void initState() {
    super.initState();
    produtoStore.getProdutos(1, 50);
    estadoCapaFuture = EstadoCapaService().fetchEstadoCapa();
    estadoPaginasFuture = EstadoPaginasService().fetchEstadoPaginas();
    tipoTransacaoFuture = TipoTransacaoService().fetchTipoTransacao();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double responsiveFontSize(double fontSize) {
      return fontSize * screenWidth / 375.0;
    }

    // ignore: no_leading_underscores_for_local_identifiers
    String? _validateRequiredField(String? value) {
      if (value == null || value.isEmpty) {
        return 'Campo obrigatório';
      }
      return null;
    }

    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                backgroundColor: const Color(0xfff6f5f2),
                iconTheme: const IconThemeData(color: Color(0xff4e90cd)),
                title: Text(
                  'Novo Livro',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: responsiveFontSize(20),
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff14131a),
                  ),
                ),
              ),

              // -----------------------------------------------------

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
                    return Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(screenWidth * 0.07),
                            child: TextField(
                              onSubmitted: (query) async {
                                bool success =
                                    await _handlePesquisarProdutos(query);

                                //bool success = true;

                                if (success && mounted) {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();

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
                                  final livro = produtoStore.state.value[0];

                                  isbnController.text = livro.isbn;
                                  titleController.text = livro.titulo;
                                  authorController.text = livro.autor;
                                  publisherController.text = livro.editora;
                                  yearController.text = livro.ano;
                                  synopsisController.text = livro.sinopse;
                                } else if (mounted) {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
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
                                      builder: (BuildContext context) =>
                                          super.widget,
                                    ),
                                  );
                                  isbnController.clear();
                                  titleController.clear();
                                  authorController.clear();
                                  publisherController.clear();
                                  yearController.clear();
                                  synopsisController.clear();
                                }
                              },
                              decoration: InputDecoration(
                                hintText:
                                    'Pesquise um livro por ISBN ou título',
                                hintStyle: TextStyle(
                                  color: const Color(0xff14131a),
                                  fontFamily: 'Poppins',
                                  fontSize: responsiveFontSize(14.0),
                                ),
                                fillColor: const Color(0xfff6f5f2),
                                filled: true,
                                prefixIcon: const Icon(Icons.search),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff4e90cd)),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff4e90cd)),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),

              // -----------------------------------------------------
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      'Sobre o livro',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: responsiveFontSize(18.0),
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff14131a),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    TextFormField(
                      controller: isbnController,
                      enabled: false,
                      maxLength: 100,
                      validator: _validateRequiredField,
                      decoration: InputDecoration(
                        labelText: 'ISBN',
                        hintText: 'ISBN do livro...',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: screenHeight * 0.02),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: responsiveFontSize(18.0),
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff14131a),
                        ),
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: responsiveFontSize(13.5),
                          color: const Color(0xff14131a),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    TextFormField(
                      controller: titleController,
                      enabled: false,
                      maxLength: 100,
                      validator: _validateRequiredField,
                      decoration: InputDecoration(
                        labelText: 'Título',
                        hintText: 'Título do livro...',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: screenHeight * 0.02),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xff1f1d34),
                          ), // Cor quando a caixa é selecionada
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xff1f1d34),
                          ), // Cor quando a caixa não é selecionada
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: responsiveFontSize(18.0),
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff14131a),
                        ),
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: responsiveFontSize(13.5),
                          color: const Color(0xff14131a),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    TextFormField(
                      controller: authorController,
                      enabled: false,
                      maxLength: 100,
                      validator: _validateRequiredField,
                      decoration: InputDecoration(
                        labelText: 'Autor(a)',
                        hintText: 'Autor(a) do livro...',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: screenHeight * 0.02),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: responsiveFontSize(18.0),
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff14131a),
                        ),
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: responsiveFontSize(13.5),
                          color: const Color(0xff14131a),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    TextFormField(
                      controller: publisherController,
                      enabled: false,
                      maxLength: 100,
                      validator: _validateRequiredField,
                      decoration: InputDecoration(
                        labelText: 'Editora',
                        hintText: 'Editora do livro...',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: screenHeight * 0.02),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: responsiveFontSize(18.0),
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff14131a),
                        ),
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: responsiveFontSize(13.5),
                          color: const Color(0xff14131a),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    TextFormField(
                      controller: yearController,
                      enabled: false,
                      maxLength: 4,
                      keyboardType: TextInputType.number,
                      validator: _validateRequiredField,
                      decoration: InputDecoration(
                        labelText: 'Ano de publicação',
                        hintText: 'Ano de publicação do livro...',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: screenHeight * 0.02),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: responsiveFontSize(18.0),
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff14131a),
                        ),
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: responsiveFontSize(13.5),
                          color: const Color(0xff14131a),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    TextFormField(
                      controller: synopsisController,
                      enabled: false,
                      validator: _validateRequiredField,
                      decoration: InputDecoration(
                        labelText: 'Sinopse',
                        hintText: 'Sinopse do livro...',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: screenHeight * 0.02),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: responsiveFontSize(18.0),
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff14131a),
                        ),
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: responsiveFontSize(13.5),
                          color: const Color(0xff14131a),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    Text(
                      'Estado de Conservação',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: responsiveFontSize(18.0),
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff14131a),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      'Capa',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: responsiveFontSize(14),
                        color: const Color(0xff14131a),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    // ------------------------------
                    // ESTADOS DE CONSERVAÇÃO DA CAPA

                    FutureBuilder<List<EstadoCapaModel>>(
                      future: estadoCapaFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              'Erro ao carregar estados de conservação da capa',
                              style: TextStyle(
                                color: const Color(0xffcd4e4e),
                                fontSize: responsiveFontSize(14.0),
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          );
                        } else {
                          final estadoCapa = snapshot.data!;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            // exemplo de estado de conservação
                            children: [
                              _buildCoverState(
                                  estadoCapa[2].nome, 0, estadoCapa[2].id),
                              _buildCoverState(
                                  estadoCapa[0].nome, 1, estadoCapa[0].id),
                              _buildCoverState(
                                  estadoCapa[1].nome, 2, estadoCapa[1].id),
                            ],
                          );
                        }
                      },
                    ),
                    // ------------------------------

                    SizedBox(height: screenHeight * 0.03),
                    Text(
                      'Páginas',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: responsiveFontSize(14),
                        color: const Color(0xff14131a),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    // ------------------------------
                    // ESTADOS DE CONSERVAÇÃO DAS PÁGINAS
                    FutureBuilder<List<EstadoPaginasModel>>(
                      future: estadoPaginasFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              'Erro ao carregar estados de conservação da página',
                              style: TextStyle(
                                color: const Color(0xffcd4e4e),
                                fontSize: responsiveFontSize(14.0),
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          );
                        } else {
                          final estadoPaginas = snapshot.data!;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildPagesState(estadoPaginas[1].nome, 0,
                                  estadoPaginas[1].id),
                              _buildPagesState(estadoPaginas[2].nome, 1,
                                  estadoPaginas[2].id),
                              _buildPagesState(estadoPaginas[0].nome, 2,
                                  estadoPaginas[0].id),
                            ],
                          );
                        }
                      },
                    ),

                    // ------------------------------
                    SizedBox(height: screenHeight * 0.05),
                    TextFormField(
                      validator: _validateRequiredField,
                      decoration: InputDecoration(
                        labelText: 'Descrição do Estado',
                        hintText: 'Insira uma descrição do estado do livro...',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: screenHeight * 0.02),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: responsiveFontSize(18.0),
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff14131a),
                        ),
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: responsiveFontSize(13.5),
                          color: const Color(0xff14131a),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    Text(
                      'Tipo de Negociação',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: responsiveFontSize(18.0),
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff14131a),
                      ),
                    ),
                    // ==============================================================

                    // -----------------------------------------

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
                              'Erro ao carregar estados de conservação da página',
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
                          Map<String, String> tipoTransacaoIds = {
                            'loan': tipoTransacao[0].id,
                            'sale': tipoTransacao[1].id,
                            'donation': tipoTransacao[2].id,
                            'exchange': tipoTransacao[3].id,
                          };
                          return Column(
                            children: [
                              SizedBox(height: screenHeight * 0.02),
                              _buildNoneButton(),
                              _buildDonationButton(
                                  tipoTransacaoIds['donation']!),
                              _buildLoanButton(tipoTransacaoIds['loan']!),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Quantidade de dias:',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: responsiveFontSize(14.0),
                                      color: const Color(0xff14131a),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: screenWidth * 0.3,
                                    child: TextFormField(
                                      controller: daysController,
                                      enabled: isLoanSelected,
                                      keyboardType: TextInputType.number,
                                      //validator: _validateRequiredField,
                                      decoration: InputDecoration(
                                        hintText: '00',
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: screenHeight * 0.02),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        hintStyle: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: responsiveFontSize(13.5),
                                          color: const Color(0xff14131a),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.015),
                              _buildExchangeButton(
                                  tipoTransacaoIds['exchange']!),
                              _buildSaleButton(tipoTransacaoIds['sale']!),
                              SizedBox(height: screenHeight * 0.02),
                              TextFormField(
                                controller: priceController,
                                enabled: isSaleSelected,
                                //validator: _validateRequiredField,
                                decoration: InputDecoration(
                                  labelText: 'Valor',
                                  hintText: 'R\$ 0,00',
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: screenHeight * 0.02),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  labelStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: responsiveFontSize(18.0),
                                    color: const Color(0xff14131a),
                                  ),
                                  hintStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: responsiveFontSize(13.5),
                                    color: const Color(0xff14131a),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),

                    // -----------------------------------------

                    // ==============================================================
                    SizedBox(height: screenHeight * 0.05),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: BorderSide(
                                    color: const Color(0xffcd4e4e),
                                    width: screenWidth * 0.005,
                                  ),
                                ),
                              ),
                              child: Text(
                                "Cancelar",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: responsiveFontSize(16.0),
                                  color: const Color(0xffcd4e4e),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // fazer uma validação quando a API estiver pronta
                                bool success =
                                    _formKey.currentState?.validate() ?? false;

                                String message = success
                                    ? "Livro cadastrado com sucesso!"
                                    : "Algo deu errado, verifique os dados.";

                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      message,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: responsiveFontSize(16.0),
                                      ),
                                    ),
                                    duration: const Duration(seconds: 5),
                                    backgroundColor: success
                                        ? const Color(0xff4ecd72)
                                        : const Color(0xffcd4e4e),
                                  ),
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
                                "Salvar",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: responsiveFontSize(16.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     // if (_formKey.currentState?.validate() ?? false) {
                        //     //   Navigator.push(
                        //     //     context,
                        //     //     MaterialPageRoute(
                        //     //         builder: (context) => const Tela()),
                        //     //   );
                        //     // }
                      ],
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

  Widget _buildCoverState(String text, int index, String id) {
    Color color;
    IconData icon;
    double screenWidth = MediaQuery.of(context).size.width;
    List<String> words = text.split(' ');

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

    return GestureDetector(
      onTap: () {
        setState(() {
          for (int i = 0; i < isCoverStateSelected.length; i++) {
            if (i == index) {
              isCoverStateSelected[i] = true;
              selectedCoverStateId = id;
            } else {
              isCoverStateSelected[i] = false;
            }
          }
        });
      },
      child: Container(
        padding: EdgeInsets.all(screenWidth * 0.035),
        decoration: BoxDecoration(
          color: isCoverStateSelected[index] ? color : const Color(0xfff6f5f2),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: color,
            width: screenWidth * 0.005,
          ),
        ),
        child: Row(
          children: [
            Icon(icon,
                color: isCoverStateSelected[index]
                    ? const Color(0xfff6f5f2)
                    : color),
            SizedBox(width: screenWidth * 0.02),
            Column(
              children: [
                Text(
                  words.first,
                  style: TextStyle(
                    fontSize: responsiveFontSize(13.0),
                    color: isCoverStateSelected[index]
                        ? const Color(0xfff6f5f2)
                        : color,
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  words.last,
                  style: TextStyle(
                    fontSize: responsiveFontSize(13.0),
                    color: isCoverStateSelected[index]
                        ? const Color(0xfff6f5f2)
                        : color,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPagesState(String text, int index, String id) {
    Color color;
    IconData icon;
    double screenWidth = MediaQuery.of(context).size.width;
    List<String> words = text.split(' ');

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

    return GestureDetector(
      onTap: () {
        setState(() {
          for (int i = 0; i < isPageStateSelected.length; i++) {
            if (i == index) {
              isPageStateSelected[i] = true;
              selectedPageStateId = id;
            } else {
              isPageStateSelected[i] = false;
            }
          }
        });
      },
      child: Container(
        padding: EdgeInsets.all(screenWidth * 0.035),
        decoration: BoxDecoration(
          color: isPageStateSelected[index] ? color : const Color(0xfff6f5f2),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: color,
            width: screenWidth * 0.005,
          ),
        ),
        child: Row(
          children: [
            Icon(icon,
                color: isPageStateSelected[index]
                    ? const Color(0xfff6f5f2)
                    : color),
            SizedBox(width: screenWidth * 0.02),
            Column(
              children: [
                Text(
                  words.first,
                  style: TextStyle(
                    fontSize: responsiveFontSize(13.0),
                    color: isPageStateSelected[index]
                        ? const Color(0xfff6f5f2)
                        : color,
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  words.last,
                  style: TextStyle(
                    fontSize: responsiveFontSize(13.0),
                    color: isPageStateSelected[index]
                        ? const Color(0xfff6f5f2)
                        : color,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDonationButton(String id) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double responsiveFontSize(double fontSize) {
      return fontSize * screenWidth / 375.0;
    }

    return Row(
      children: [
        InkWell(
          onTap: isNoneSelected
              ? null
              : () {
                  setState(() {
                    isDonationSelected = !isDonationSelected;
                    if (isDonationSelected) {
                      selectedNegotiationTypes.add(id);
                    } else {
                      selectedNegotiationTypes.remove(id);
                    }
                  });
                },
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.02, horizontal: screenWidth * 0.02),
            child: Row(
              children: [
                isDonationSelected && !isNoneSelected
                    ? const Icon(
                        Icons.check_box,
                        color: Color(0xff1f1d34),
                      )
                    : const Icon(
                        Icons.check_box_outline_blank,
                        color: Color(0xff1f1d34),
                      ),
                SizedBox(width: screenWidth * 0.015),
                Text(
                  'Doação',
                  style: TextStyle(
                      color: isNoneSelected
                          ? const Color(0xffd3d3d3)
                          : const Color(0xff1f1d34),
                      fontFamily: 'Poppins',
                      fontSize: responsiveFontSize(14.0)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoanButton(String id) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double responsiveFontSize(double fontSize) {
      return fontSize * screenWidth / 375.0;
    }

    return Row(
      children: [
        InkWell(
          onTap: isNoneSelected
              ? null
              : () {
                  setState(() {
                    isLoanSelected = !isLoanSelected;
                    if (isLoanSelected) {
                      selectedNegotiationTypes.add(id);
                    } else {
                      selectedNegotiationTypes.remove(id);
                      daysController.clear();
                    }
                  });
                },
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.02, horizontal: screenWidth * 0.02),
            child: Row(
              children: [
                isLoanSelected && !isNoneSelected
                    ? const Icon(
                        Icons.check_box,
                        color: Color(0xff1f1d34),
                      )
                    : const Icon(
                        Icons.check_box_outline_blank,
                        color: Color(0xff1f1d34),
                      ),
                SizedBox(width: screenWidth * 0.015),
                Text(
                  'Empréstimo',
                  style: TextStyle(
                      color: isNoneSelected
                          ? const Color(0xffd3d3d3)
                          : const Color(0xff1f1d34),
                      fontFamily: 'Poppins',
                      fontSize: responsiveFontSize(14.0)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExchangeButton(String id) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double responsiveFontSize(double fontSize) {
      return fontSize * screenWidth / 375.0;
    }

    return Row(
      children: [
        InkWell(
          onTap: isNoneSelected
              ? null
              : () {
                  setState(() {
                    isExchangeSelected = !isExchangeSelected;
                    if (isExchangeSelected) {
                      selectedNegotiationTypes.add(id);
                    } else {
                      selectedNegotiationTypes.remove(id);
                    }
                  });
                },
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.02, horizontal: screenWidth * 0.02),
            child: Row(
              children: [
                isExchangeSelected && !isNoneSelected
                    ? const Icon(
                        Icons.check_box,
                        color: Color(0xff1f1d34),
                      )
                    : const Icon(
                        Icons.check_box_outline_blank,
                        color: Color(0xff1f1d34),
                      ),
                SizedBox(width: screenWidth * 0.015),
                Text(
                  'Troca',
                  style: TextStyle(
                      color: isNoneSelected
                          ? const Color(0xffd3d3d3)
                          : const Color(0xff1f1d34),
                      fontFamily: 'Poppins',
                      fontSize: responsiveFontSize(14.0)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaleButton(String id) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double responsiveFontSize(double fontSize) {
      return fontSize * screenWidth / 375.0;
    }

    return Row(
      children: [
        InkWell(
          onTap: isNoneSelected
              ? null
              : () {
                  setState(() {
                    isSaleSelected = !isSaleSelected;
                    if (isSaleSelected) {
                      selectedNegotiationTypes.add(id);
                    } else {
                      selectedNegotiationTypes.remove(id);
                      priceController.clear();
                    }
                  });
                },
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.02, horizontal: screenWidth * 0.02),
            child: Row(
              children: [
                isSaleSelected && !isNoneSelected
                    ? const Icon(
                        Icons.check_box,
                        color: Color(0xff1f1d34),
                      )
                    : const Icon(
                        Icons.check_box_outline_blank,
                        color: Color(0xff1f1d34),
                      ),
                SizedBox(width: screenWidth * 0.015),
                Text(
                  'Venda',
                  style: TextStyle(
                      color: isNoneSelected
                          ? const Color(0xffd3d3d3)
                          : const Color(0xff1f1d34),
                      fontFamily: 'Poppins',
                      fontSize: responsiveFontSize(14.0)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNoneButton() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double responsiveFontSize(double fontSize) {
      return fontSize * screenWidth / 375.0;
    }

    return Row(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isNoneSelected = !isNoneSelected;
              priceController.clear();
              daysController.clear();
              isDonationSelected = false;
              isLoanSelected = false;
              isExchangeSelected = false;
              isSaleSelected = false;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.02, horizontal: screenWidth * 0.02),
            child: Row(
              children: [
                isNoneSelected
                    ? const Icon(
                        Icons.check_box,
                        color: Color(0xff1f1d34),
                      )
                    : const Icon(
                        Icons.check_box_outline_blank,
                        color: Color(0xff1f1d34),
                      ),
                SizedBox(width: screenWidth * 0.015),
                Text(
                  'Nenhuma',
                  style: TextStyle(
                      color: const Color(0xff1f1d34),
                      fontFamily: 'Poppins',
                      fontSize: responsiveFontSize(14.0)),
                ),
              ],
            ),
          ),
        ),
      ],
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
}

import 'package:flutter/material.dart';

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
  List<bool> isCoverStateSelected = [false, false, false];
  bool isDonationSelected = false;
  bool isLoanSelected = false;
  bool isExchangeSelected = false;
  bool isSaleSelected = false;
  bool isNoneSelected = false;
  String dropdownValue = 'Selecione';

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
                      maxLength: 100,
                      validator: _validateRequiredField,
                      decoration: InputDecoration(
                        labelText: 'ISBN',
                        hintText: 'Insira o ISBN do livro...',
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
                      maxLength: 100,
                      validator: _validateRequiredField,
                      decoration: InputDecoration(
                        labelText: 'Título',
                        hintText: 'Insira o título do livro...',
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
                      maxLength: 100,
                      validator: _validateRequiredField,
                      decoration: InputDecoration(
                        labelText: 'Autor(a)',
                        hintText: 'Insira o autor(a) do livro...',
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
                      maxLength: 100,
                      validator: _validateRequiredField,
                      decoration: InputDecoration(
                        labelText: 'Editora',
                        hintText: 'Insira a editora do livro...',
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
                      maxLength: 4,
                      keyboardType: TextInputType.number,
                      validator: _validateRequiredField,
                      decoration: InputDecoration(
                        labelText: 'Ano de publicação',
                        hintText: 'Insira o ano de publicação do livro...',
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
                      validator: _validateRequiredField,
                      decoration: InputDecoration(
                        labelText: 'Sinopse',
                        hintText: 'Insira a sinopse do livro...',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // exemplo de estado de conservação
                      children: [
                        _buildCoverState('Ótimo estado', 0),
                        _buildCoverState('Estado regular', 1),
                        _buildCoverState('Péssimo estado', 2),
                      ],
                    ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // exemplo de estado de conservação
                      children: [
                        _buildPagesState('Ótimo estado', 0),
                        _buildPagesState('Estado regular', 1),
                        _buildPagesState('Péssimo estado', 2),
                      ],
                    ),
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
                    SizedBox(height: screenHeight * 0.02),
                    _buildDonationButton(),
                    _buildLoanButton(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Período',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: responsiveFontSize(14.0),
                            color: const Color(0xff14131a),
                          ),
                        ),
                        Text(
                          'Quantidade',
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenHeight * 0.02),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              width: screenWidth * 0.00155,
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: dropdownValue == 'Selecione'
                                  ? null
                                  : dropdownValue,
                              hint: Text(
                                'Selecione',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: responsiveFontSize(13.5),
                                  color: const Color(0xff14131a),
                                ),
                              ),
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Color(0xff4e90cd),
                              ),
                              iconSize: responsiveFontSize(25.0),
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: responsiveFontSize(13.5),
                                color: const Color(0xff14131a),
                              ),
                              onChanged: (String? newValue) {
                                if (newValue != 'Selecione') {
                                  setState(() {
                                    dropdownValue = newValue!;
                                  });
                                }
                              },
                              items: <String>[
                                'Selecione',
                                'Semana',
                                'Mês',
                                'Ano'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        // ignore: sized_box_for_whitespace
                        Container(
                          width: screenWidth * 0.3,
                          child: TextFormField(
                            enabled: isLoanSelected,
                            keyboardType: TextInputType.number,
                            validator: _validateRequiredField,
                            decoration: InputDecoration(
                              hintText: '00',
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: screenHeight * 0.02),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
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
                    _buildExchangeButton(),
                    _buildSaleButton(),
                    SizedBox(height: screenHeight * 0.02),
                    TextFormField(
                      enabled: isSaleSelected,
                      validator: _validateRequiredField,
                      decoration: InputDecoration(
                        labelText: 'Valor',
                        hintText: 'R\$ 0,00',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: screenHeight * 0.02),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
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
                    SizedBox(height: screenHeight * 0.01),
                    _buildNoneButton(),
                    SizedBox(height: screenHeight * 0.15),
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
                                bool success = true;

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

  Widget _buildCoverState(String text, int index) {
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

  Widget _buildPagesState(String text, int index) {
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

  Widget _buildDonationButton() {
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
              isDonationSelected = !isDonationSelected;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.02, horizontal: screenWidth * 0.02),
            child: Row(
              children: [
                isDonationSelected
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

  Widget _buildLoanButton() {
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
              isLoanSelected = !isLoanSelected;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.02, horizontal: screenWidth * 0.02),
            child: Row(
              children: [
                isLoanSelected
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

  Widget _buildExchangeButton() {
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
              isExchangeSelected = !isExchangeSelected;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.02, horizontal: screenWidth * 0.02),
            child: Row(
              children: [
                isExchangeSelected
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

  Widget _buildSaleButton() {
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
              isSaleSelected = !isSaleSelected;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.02, horizontal: screenWidth * 0.02),
            child: Row(
              children: [
                isSaleSelected
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
}

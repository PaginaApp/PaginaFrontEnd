import 'package:flutter/material.dart';

class ConfiguracoesMeusDados extends StatefulWidget {
  const ConfiguracoesMeusDados({super.key});

  @override
  State<ConfiguracoesMeusDados> createState() => _ConfiguracoesMeusDadosState();
}

class _ConfiguracoesMeusDadosState extends State<ConfiguracoesMeusDados> {
  bool _isEditing = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
      backgroundColor: const Color(0xfff6f5f2),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                backgroundColor: const Color(0xfff6f5f2),
                iconTheme: const IconThemeData(color: Color(0xff4e90cd)),
                title: Text(
                  'Meus Dados',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: responsiveFontSize(18),
                    color: const Color(0xff14131a),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Dados Pessoais',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: responsiveFontSize(22.0),
                            color: const Color(0xff14131a),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'Nome completo',
                        // substituir esse hintText pelo nome do usuário
                        hintText: 'Insira seu nome completo',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: screenHeight * 0.02),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: responsiveFontSize(17.0),
                          fontWeight: FontWeight.bold,
                        ),
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: responsiveFontSize(13.5),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextFormField(
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: 'Data de Nascimento',
                              // substituir esse hintText pela data de nascimento do usuário
                              hintText: '00/00/0000',
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: screenHeight * 0.02),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: responsiveFontSize(17.0),
                                fontWeight: FontWeight.bold,
                              ),
                              hintStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: responsiveFontSize(13.5),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.035,
                          height: screenHeight * 0.12,
                        ),
                        Expanded(
                          child: TextFormField(
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: 'CPF',
                              // substituir esse hintText pelo CPF do usuário
                              hintText: '000.000.000-00',
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: screenHeight * 0.02),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: responsiveFontSize(17.0),
                                fontWeight: FontWeight.bold,
                              ),
                              hintStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: responsiveFontSize(13.5),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      maxLength: 11,
                      validator: _validateRequiredField,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Telefone',
                        hintText: '(00) 90000-0000',
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
                          fontSize: responsiveFontSize(17.0),
                          fontWeight: FontWeight.bold,
                        ),
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: responsiveFontSize(13.5),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        // substituir esse hintText pelo email do usuário
                        hintText: 'usuario123@email.com',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: screenHeight * 0.02),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: responsiveFontSize(17.0),
                          fontWeight: FontWeight.bold,
                        ),
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: responsiveFontSize(13.5),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    Row(
                      children: [
                        SizedBox(width: screenWidth * 0.01),
                        Text(
                          'Endereço',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: responsiveFontSize(22.0),
                            color: const Color(0xff14131a),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    TextFormField(
                      maxLength: 8,
                      validator: _validateRequiredField,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'CEP',
                        // substituir esse hintText pelo CEP do usuário
                        hintText: '00000-000',
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
                          fontSize: responsiveFontSize(17.0),
                          fontWeight: FontWeight.bold,
                        ),
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: responsiveFontSize(13.5),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'Cidade',
                        // substituir esse hintText pela cidade do usuário
                        hintText: 'Ex: Campinas',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: screenHeight * 0.02),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: responsiveFontSize(17.0),
                          fontWeight: FontWeight.bold,
                        ),
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: responsiveFontSize(13.5),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'Bairro',
                        // substituir esse hintText pelo bairro do usuário
                        hintText: 'Ex: Bonfim',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: screenHeight * 0.02),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: responsiveFontSize(17.0),
                          fontWeight: FontWeight.bold,
                        ),
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: responsiveFontSize(13.5),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'Rua',
                        // substituir esse hintText pela rua do usuário
                        hintText: 'Ex: Avenida Americana',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: screenHeight * 0.02),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: responsiveFontSize(17.0),
                          fontWeight: FontWeight.bold,
                        ),
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: responsiveFontSize(13.5),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextFormField(
                            maxLength: 100000,
                            validator: _validateRequiredField,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Número',
                              hintText: '00',
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
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: responsiveFontSize(17.0),
                                fontWeight: FontWeight.bold,
                              ),
                              hintStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: responsiveFontSize(13.5),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.035,
                          height: screenHeight * 0.11,
                        ),
                        Expanded(
                          child: TextFormField(
                            maxLength: 2,
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: 'Estado',
                              // substituir esse hintText pelo estado do usuário
                              hintText: 'Ex: SP',
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: screenHeight * 0.02),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: responsiveFontSize(17.0),
                                fontWeight: FontWeight.bold,
                              ),
                              hintStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: responsiveFontSize(13.5),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      maxLength: 100,
                      validator: _validateRequiredField,
                      decoration: InputDecoration(
                        labelText: 'Complemento',
                        // substituir esse hintText pelo complemento do usuário
                        hintText: 'Ex: Bloco 17, ap. 11',
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
                          fontSize: responsiveFontSize(17.0),
                          fontWeight: FontWeight.bold,
                        ),
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: responsiveFontSize(13.5),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_isEditing)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _isEditing = false;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.red,
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
                                  setState(() {
                                    _isEditing = false;
                                  });

                                  bool success = true;

                                  String message = success
                                      ? "Seus dados foram alterados com sucesso."
                                      : "Algo deu errado, verifique seus dados";

                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        message,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: responsiveFontSize(17.0),
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
                        if (!_isEditing)
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _isEditing = true;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff4e90cd),
                              foregroundColor: const Color(0xfff6f5f2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Text(
                              "Alterar",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: responsiveFontSize(16.0),
                              ),
                            ),
                          ),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     // if (_formKey.currentState?.validate() ?? false) {
                        //     //   Navigator.push(
                        //     //     context,
                        //     //     MaterialPageRoute(
                        //     //         builder: (context) => const Cadastro1()),
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
}

import 'package:flutter/material.dart';

class ConfiguracoesAvaliacoesTitulos extends StatefulWidget {
  const ConfiguracoesAvaliacoesTitulos({super.key});

  @override
  State<ConfiguracoesAvaliacoesTitulos> createState() =>
      _ConfiguracoesAvaliacoesTitulosState();
}

class _ConfiguracoesAvaliacoesTitulosState
    extends State<ConfiguracoesAvaliacoesTitulos> {
  String selectedText = 'Total';
  List<bool> isSelected = [false, false, false, false];
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
              'Avaliações e Títulos',
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
          SizedBox(height: screenHeight * 0.02),
          Text(
            'Veja seus pontos por categoria',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: responsiveFontSize(16.5),
              color: const Color(0xff14131a),
            ),
          ),
          SizedBox(height: screenHeight * 0.035),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCircle('Doação', 0),
              _buildCircle('Empréstimo', 1),
              _buildCircle('Troca', 2),
              _buildCircle('Venda', 3),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.06),
            child: Container(
              padding: EdgeInsets.all(screenWidth * 0.03),
              decoration: BoxDecoration(
                color: const Color(0xff4f5071),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: screenWidth * 0.07,
                    child: const Icon(
                      Icons.person,
                      color: Color(0xff4e90cd),
                    ),
                    //backgroundImage: NetworkImage('urlDaImagem'), //URL da imagem
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // preciso trocar o X pelo total de pontos
                          "X Pontos ($selectedText)",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: responsiveFontSize(14.0),
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff14131a),
                          ),
                        ),
                        Row(
                          children: [
                            // depois preciso descobrir como integrar com a API
                            Text(
                              "@título -",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: responsiveFontSize(12.0),
                                color: const Color(0xff14131a),
                              ),
                            ),
                            Icon(
                              Icons.star,
                              color: const Color(0xfff3e140),
                              size: responsiveFontSize(20.0),
                            ),
                            // depois preciso descobrir como integrar com a API
                            Text(
                              "X/5",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: responsiveFontSize(12.0),
                                color: const Color(0xff14131a),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: const Color(0xfff6f5f2),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(screenWidth * 0.06),
                      child: Text(
                        'Títulos disponíveis',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: responsiveFontSize(14.0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    _buildTitle('@Voluntário(a)', 500,
                        userHasEnoughPoints: false),
                    _buildTitle('@Bondoso(a)', 500, userHasEnoughPoints: false),
                    _buildTitle('@Caridoso(a)', 500,
                        userHasEnoughPoints: false),
                    _buildTitle('@Boa_Alma', 350, userHasEnoughPoints: true),
                    _buildTitle('@Doador_Nato', 300,
                        specialText: 'de doação', userHasEnoughPoints: true),
                    _buildTitle('@Projeto_Caridade', 250,
                        userHasEnoughPoints: true),
                    _buildTitle('@Ajudante', 50, userHasEnoughPoints: true),
                    _buildTitle('@Bom_Caminho', 40, userHasEnoughPoints: true),
                    _buildTitle('@Doador_Experiente', 30,
                        userHasEnoughPoints: true),
                    _buildTitle('@Doador_Intermediário', 20,
                        userHasEnoughPoints: true),
                    _buildTitle('@Doador_Amador', 10,
                        userHasEnoughPoints: true),
                    _buildTitle('@Bom_Começo', 5, userHasEnoughPoints: true),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(String title, int points,
      {bool userHasEnoughPoints = true, String specialText = ''}) {
    // preciso descobrir como pegar o total de pontos do usuário
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double responsiveFontSize(double size) {
      return size * MediaQuery.of(context).size.width / 375;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: screenHeight * 0.001, horizontal: screenWidth * 0.04),
        decoration: BoxDecoration(
          color: userHasEnoughPoints
              ? const Color(0xfff6f5f2)
              : const Color(0xff4f5071),
          border: Border.all(color: const Color(0xff14131a)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            ListTile(
              title: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: const Color(0xff14131a),
                  fontSize: responsiveFontSize(12.5),
                ),
              ),
              trailing: CircleAvatar(
                radius: screenWidth * 0.04,
                backgroundColor: const Color(0xff4e90cd),
                child: Icon(
                  userHasEnoughPoints ? Icons.push_pin : Icons.lock,
                  color: const Color(0xfff6f5f2),
                ),
              ),
            ),
            Positioned(
              right: screenWidth * 0.15,
              bottom: screenHeight * 0.01,
              child: Text(
                "$points pontos $specialText necessários",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: const Color(0xff14131a),
                  fontSize: responsiveFontSize(8.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircle(String text, int index) {
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
    return ToggleButtons(
      borderWidth: 0.0,
      isSelected: [isSelected[index]],
      onPressed: (int newIndex) {
        setState(() {
          for (int i = 0; i < isSelected.length; i++) {
            if (i == index) {
              isSelected[i] = true;
              selectedText = text;
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
                color: const Color(0xff4e90cd),
                fontFamily: 'Poppins',
                fontSize: responsiveFontSize(13.0),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

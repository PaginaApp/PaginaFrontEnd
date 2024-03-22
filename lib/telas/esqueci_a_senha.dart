import 'package:flutter/material.dart';

class EsqueciSenha extends StatelessWidget {
  const EsqueciSenha({super.key});

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
        child: Stack(
          children: [
            // Container(
            //   height: screenHeight / 4.5,
            //   color: const Color(0xffbabdd3),
            // ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: screenWidth,
                height: screenHeight * 1.2 / 3,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/png/background_login.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.001,
              right: screenWidth * 0.01,
              child: Image.asset(
                'assets/png/icone_livros.png',
                width: screenWidth * 0.15,
                height: screenHeight * 0.15,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.13),
                Center(
                  child: Image.asset(
                    'assets/png/pessoas_com_livros.png',
                    width: screenWidth * 0.6,
                    height: screenHeight * 0.22,
                  ),
                ),
                SizedBox(height: screenHeight * 0.055),
                Text(
                  "Esqueci minha senha",
                  style: TextStyle(
                    fontSize: responsiveFontSize(22.0),
                    color: const Color(0xff14131a),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  "Digite o Email cadastrado na",
                  style: TextStyle(
                    fontSize: responsiveFontSize(16.5),
                    color: const Color(0xff14131a),
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  "Plataforma para receber um link",
                  style: TextStyle(
                    fontSize: responsiveFontSize(16.5),
                    color: const Color(0xff14131a),
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  "e atualizar sua senha",
                  style: TextStyle(
                    fontSize: responsiveFontSize(16.5),
                    color: const Color(0xff14131a),
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),

                // Caixa para preencher com o email
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(
                        fontSize: responsiveFontSize(16.5),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                      prefixIcon: const Icon(Icons.email),
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
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.09),

                // Botão de enviar
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff4e90cd),
                    foregroundColor: const Color(0xfff6f5f2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    "Enviar",
                    style: TextStyle(
                      fontSize: responsiveFontSize(16.0),
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),

                // Voltar
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Voltar",
                    style: TextStyle(
                      color: Color(0xff1f1d34),
                      fontFamily: 'Poppins',
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

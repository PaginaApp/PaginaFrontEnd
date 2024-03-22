import 'package:flutter/material.dart';
import 'package:projeto_pagina/telas/cadastro.dart';
import 'package:projeto_pagina/telas/consulta_termos_uso.dart';
import 'package:projeto_pagina/telas/esqueci_a_senha.dart';
import 'package:projeto_pagina/telas/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _showPassword = false;

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
                  "Área de Login",
                  style: TextStyle(
                    fontSize: responsiveFontSize(24),
                    fontFamily: 'Poppins',
                    color: const Color(0xff14131a),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                // Caixa para preencher com o email
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(
                        fontSize: responsiveFontSize(16.5),
                        fontFamily: 'Poppins',
                        color: const Color(0xff14131a),
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

                SizedBox(height: screenHeight * 0.07),

                // Caixa para preencher com a senha
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: TextField(
                    obscureText: !_showPassword,
                    decoration: InputDecoration(
                      labelText: "Senha",
                      labelStyle: TextStyle(
                        fontSize: responsiveFontSize(16.5),
                        fontFamily: 'Poppins',
                        color: const Color(0xff14131a),
                        fontWeight: FontWeight.bold,
                      ),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(_showPassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                      ),
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

                SizedBox(height: screenHeight * 0.02),

                // Esqueci minha senha
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EsqueciSenha()),
                    );
                  },
                  child: Text(
                    "Esqueci minha senha",
                    style: TextStyle(
                      color: const Color(0xff1f1d34),
                      fontSize: responsiveFontSize(12.0),
                      fontFamily: 'Poppins',
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),

                // Botão de entrar
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
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
                    "Entrar",
                    style: TextStyle(
                      fontSize: responsiveFontSize(16.0),
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),

                // Cadastre-se
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Cadastro()),
                    );
                  },
                  child: Text(
                    "Não tem uma conta? Cadastre-se",
                    style: TextStyle(
                      color: const Color(0xff1f1d34),
                      fontSize: responsiveFontSize(12.0),
                      fontFamily: 'Poppins',
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),

                // Termos de uso
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ConsultaTermosUso()),
                    );
                  },
                  child: Text(
                    "Consulte nossos termos de uso e políticas de privacidade",
                    style: TextStyle(
                      color: const Color(0xff1f1d34),
                      fontSize: responsiveFontSize(12.0),
                      fontFamily: 'Poppins',
                      decoration: TextDecoration.underline,
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

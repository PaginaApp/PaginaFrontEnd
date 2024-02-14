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
            Container(
              height: screenHeight / 4.5,
              color: const Color(0xffbabdd3),
            ),
            // CustomPaint(
            //   painter: WavePainter(),
            //   child: SizedBox(
            //     height: screenHeight,
            //     width: screenWidth,
            //   ),
            // ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.2),
                // Caixa para preencher com o email
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(
                        fontSize: responsiveFontSize(16.5),
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
                  child: const Text(
                    "Esqueci minha senha",
                    style: TextStyle(
                      color: Color(0xff1f1d34),
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
                    style: TextStyle(fontSize: responsiveFontSize(17.0)),
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
                  child: const Text(
                    "Não tem uma conta? Cadastre-se",
                    style: TextStyle(
                      color: Color(0xff1f1d34),
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
                  child: const Text(
                    "Consulte nossos termos de uso e políticas de privacidade",
                    style: TextStyle(
                      color: Color(0xff1f1d34),
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

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xfff6f5f2)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width / 4.45, size.height * 0.8)
      ..quadraticBezierTo(size.width / 2, size.height / 2, size.width * 9 / 4,
          size.height * 0.05)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

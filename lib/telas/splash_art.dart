import 'package:flutter/material.dart';
import 'package:projeto_pagina/telas/login.dart';

class SplashArt extends StatelessWidget {
  const SplashArt({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double responsiveFontSize(double fontSize) {
      return fontSize * screenWidth / 375.0;
    }

    return Scaffold(
      backgroundColor: const Color(0xffbabdd3),
      body: Stack(
        children: [
          Container(
            height: screenHeight / 2,
            color: const Color(0xfff6f5f2),
          ),
          CustomPaint(
            painter: WavePainter(),
            child: SizedBox(
              height: screenHeight / 2,
              width: screenWidth,
            ),
          ),

          Padding(
            padding: EdgeInsets.all(screenWidth * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Venha fazer ",
                  style: TextStyle(
                    fontSize: responsiveFontSize(28.5),
                    color: const Color(0xff1f1d34),
                  ),
                ),
                Text(
                  "parte da",
                  style: TextStyle(
                    fontSize: responsiveFontSize(28.5),
                    color: const Color(0xff1f1d34),
                  ),
                ),
                Text(
                  "comunidade",
                  style: TextStyle(
                    fontSize: responsiveFontSize(28.5),
                    color: const Color(0xff1f1d34),
                  ),
                ),
                Text(
                  "da PÁGINA",
                  style: TextStyle(
                    fontSize: responsiveFontSize(28.5),
                    color: const Color(0xff1f1d34),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.365,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(screenWidth * 0.05),
                        backgroundColor: const Color(0xff1f1d34),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        "Entrar",
                        style: TextStyle(
                          fontSize: responsiveFontSize(16.5),
                          color: const Color(0xfff6f5f2),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.04,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(screenWidth * 0.05),
                        backgroundColor: const Color(0xfff6f5f2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: const BorderSide(
                            color: Color(0xff1f1d34),
                            width: 3.0,
                          ),
                        ),
                      ),
                      child: Text(
                        "Cadastrar-se",
                        style: TextStyle(
                          fontSize: responsiveFontSize(16.5),
                          color: const Color(0xff1f1d34),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ), // aqui tem q ter parenteses
        ], // aqui tem q ter colchete
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xffbabdd3)
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

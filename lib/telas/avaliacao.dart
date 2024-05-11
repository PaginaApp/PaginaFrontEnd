import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:projeto_pagina/telas/home.dart';

class Avaliacao extends StatefulWidget {
  const Avaliacao({super.key});

  @override
  State<Avaliacao> createState() => _AvaliacaoState();
}

class _AvaliacaoState extends State<Avaliacao> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

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
                'Avaliação',
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
            SizedBox(height: screenHeight * 0.04),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Avalie o livro',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: responsiveFontSize(18),
                    color: const Color(0xff14131a),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Capa',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: responsiveFontSize(16),
                    color: const Color(0xff14131a),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding:
                      EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Color(0xff4e90cd),
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Péssimo',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: responsiveFontSize(12.5),
                            color: const Color(0xff14131a),
                          ),
                        ),
                        Text(
                          'estado',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: responsiveFontSize(12.5),
                            color: const Color(0xff14131a),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: screenWidth * 0.4),
                    Column(
                      children: [
                        Text(
                          'Ótimo',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: responsiveFontSize(12.5),
                            color: const Color(0xff14131a),
                          ),
                        ),
                        Text(
                          'estado',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: responsiveFontSize(12.5),
                            color: const Color(0xff14131a),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: screenHeight * 0.04),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Páginas',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: responsiveFontSize(16),
                    color: const Color(0xff14131a),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding:
                      EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Color(0xff4e90cd),
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Péssimo',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: responsiveFontSize(12.5),
                            color: const Color(0xff14131a),
                          ),
                        ),
                        Text(
                          'estado',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: responsiveFontSize(12.5),
                            color: const Color(0xff14131a),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: screenWidth * 0.4),
                    Column(
                      children: [
                        Text(
                          'Ótimo',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: responsiveFontSize(12.5),
                            color: const Color(0xff14131a),
                          ),
                        ),
                        Text(
                          'estado',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: responsiveFontSize(12.5),
                            color: const Color(0xff14131a),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: screenHeight * 0.04),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Anúncio',
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding:
                      EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Color(0xff4e90cd),
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Não',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: responsiveFontSize(12.5),
                            color: const Color(0xff14131a),
                          ),
                        ),
                        Text(
                          'condizente',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: responsiveFontSize(12.5),
                            color: const Color(0xff14131a),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: screenWidth * 0.4),
                    Column(
                      children: [
                        Text(
                          'Condizente',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: responsiveFontSize(12.5),
                            color: const Color(0xff14131a),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: screenHeight * 0.04),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Avalie o anunciante',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: responsiveFontSize(18.0),
                    color: const Color(0xff14131a),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.04),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.all(screenWidth * 0.02),
                  color: const Color(0xffbabdd3),
                  // ignore: sized_box_for_whitespace
                  child: Container(
                    height: screenHeight * 0.2,
                    width: screenWidth * 2,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: screenWidth * 0.05,
                          child: const Icon(Icons.person),
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nome do anunciante',
                                style: TextStyle(
                                  fontSize: responsiveFontSize(14.0),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff14131a),
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      '@Doador intermediário = ',
                                      style: TextStyle(
                                        fontSize: responsiveFontSize(12.0),
                                        fontFamily: 'Poppins',
                                        color: const Color(0xff14131a),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: const Color(0xfff3e140),
                                        size: responsiveFontSize(20.0),
                                      ),
                                      Text(
                                        'x/5',
                                        style: TextStyle(
                                          fontSize: responsiveFontSize(12.0),
                                          fontFamily: 'Poppins',
                                          color: const Color(0xff14131a),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              Row(
                                children: [
                                  Icon(
                                    Icons.phone,
                                    color: const Color(0xfff6f5f2),
                                    size: responsiveFontSize(20.0),
                                  ),
                                  SizedBox(width: screenWidth * 0.01),
                                  Flexible(
                                    child: Text(
                                      '(11) 91234-5678',
                                      style: TextStyle(
                                        fontSize: responsiveFontSize(12.0),
                                        fontFamily: 'Poppins',
                                        color: const Color(0xff14131a),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.005),
                              Row(
                                children: [
                                  Icon(
                                    Icons.email,
                                    color: const Color(0xfff6f5f2),
                                    size: responsiveFontSize(20.0),
                                  ),
                                  SizedBox(width: screenWidth * 0.01),
                                  Flexible(
                                    child: Text(
                                      'usuario.exemplo@email.com',
                                      style: TextStyle(
                                        fontSize: responsiveFontSize(12.0),
                                        fontFamily: 'Poppins',
                                        color: const Color(0xff14131a),
                                      ),
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
              ),
            ),
            SizedBox(height: screenHeight * 0.04),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Comprometimento',
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding:
                      EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Color(0xff4e90cd),
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Não cumpriu',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: responsiveFontSize(12.5),
                            color: const Color(0xff14131a),
                          ),
                        ),
                        Text(
                          'os acordos',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: responsiveFontSize(12.5),
                            color: const Color(0xff14131a),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: screenWidth * 0.4),
                    Column(
                      children: [
                        Text(
                          'Cumpriu os',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: responsiveFontSize(12.5),
                            color: const Color(0xff14131a),
                          ),
                        ),
                        Text(
                          'acordos',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: responsiveFontSize(12.5),
                            color: const Color(0xff14131a),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: screenHeight * 0.04),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Conduta',
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding:
                      EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Color(0xff4e90cd),
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Foi',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: responsiveFontSize(12.5),
                            color: const Color(0xff14131a),
                          ),
                        ),
                        Text(
                          'desrespeitoso',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: responsiveFontSize(12.5),
                            color: const Color(0xff14131a),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: screenWidth * 0.4),
                    Column(
                      children: [
                        Text(
                          'Foi',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: responsiveFontSize(12.5),
                            color: const Color(0xff14131a),
                          ),
                        ),
                        Text(
                          'respeitoso',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: responsiveFontSize(12.5),
                            color: const Color(0xff14131a),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: screenHeight * 0.1),
            ElevatedButton(
              onPressed: () {
                // Condição temporária para simular sucesso ou falha
                bool success = true;

                String message = success
                    ? "Sua avaliação foi enviada com sucesso."
                    : "Algo deu errado. Tente novamente.";

                ScaffoldMessenger.of(context).hideCurrentSnackBar();

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
                if (success) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Home(),
                      ),
                      (route) => false);
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
                "Enviar",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: responsiveFontSize(16.0),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
          ],
        ),
      ),
    );
  }
}

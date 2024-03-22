import 'package:flutter/material.dart';

class HomeCategorias extends StatefulWidget {
  const HomeCategorias({super.key});

  @override
  State<HomeCategorias> createState() => _HomeCategoriasState();
}

class _HomeCategoriasState extends State<HomeCategorias> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double responsiveFontSize(double size) {
      return size * screenWidth / 375;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Categorias',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: responsiveFontSize(18),
            color: const Color(0xff14131a),
          ),
        ),
        backgroundColor: const Color(0xfff6f5f2),
        iconTheme: const IconThemeData(color: Color(0xff4e90cd)),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        children: List.generate(20, (index) {
          return _buildBox('Caixa $index', screenWidth, responsiveFontSize,
              'assets/png/venda.png');
        }),
        // Arrumar depois
        // children: [
        //   _buildBox(
        //       'Venda', screenWidth, responsiveFontSize, 'assets/png/venda.png'),
        // ],
      ),
    );
  }

  Widget _buildBox(String text, double screenWidth,
      double Function(double) responsiveFontSize, String image) {
    return Container(
      margin: EdgeInsets.all(screenWidth * 0.03),
      padding: EdgeInsets.all(screenWidth * 0.03),
      decoration: BoxDecoration(
        color: const Color(0xff4e90cd),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(
            image,
            width: screenWidth * 0.2,
            height: screenWidth * 0.2,
          ),
          SizedBox(width: screenWidth * 0.02),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: responsiveFontSize(15),
                color: const Color(0xfff6f5f2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

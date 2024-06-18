import 'package:flutter/material.dart';
import 'package:projeto_pagina/data/models/categoria_model.dart';
import 'package:projeto_pagina/services/categoria_service.dart';

class HomeCategorias extends StatefulWidget {
  const HomeCategorias({super.key});

  @override
  State<HomeCategorias> createState() => _HomeCategoriasState();
}

class _HomeCategoriasState extends State<HomeCategorias> {
  Future<List<CategoriaModel>>? categoriasFuture;

  @override
  void initState() {
    super.initState();
    categoriasFuture = CategoriaService().fetchCategorias();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

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
      body: FutureBuilder<List<CategoriaModel>>(
        future: categoriasFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
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
            final categorias = snapshot.data!;
            return GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              children: List.generate(categorias.length, (index) {
                return _buildBox(
                    categorias[index].catNome, screenWidth, responsiveFontSize);
              }),
            );
          }
        },
      ),
    );
  }

  Widget _buildBox(String text, double screenWidth,
      double Function(double) responsiveFontSize) {
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

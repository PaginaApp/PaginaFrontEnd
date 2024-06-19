import 'package:flutter/material.dart';
import 'package:projeto_pagina/data/models/categoria_model.dart';
import 'package:projeto_pagina/services/categoria_service.dart';

class HomeCategorias extends StatefulWidget {
  final List<String> selectedCategories;
  final List<String> removedCategories;

  const HomeCategorias(
      {Key? key,
      required this.selectedCategories,
      required this.removedCategories})
      : super(key: key);

  @override
  State<HomeCategorias> createState() => _HomeCategoriasState();
}

class _HomeCategoriasState extends State<HomeCategorias> {
  Future<List<CategoriaModel>>? categoriasFuture;
  List<String> _selectedCategories = [];
  // ignore: prefer_final_fields
  List<String> _removedCategories = [];

  @override
  void initState() {
    super.initState();
    _selectedCategories = List.from(widget.selectedCategories);
    categoriasFuture = CategoriaService().fetchCategorias();
    categoriasFuture!.then((categorias) {
      setState(() {
        categorias.removeWhere((element) => element.catNome == 'Aventura');
        categorias.removeWhere((element) => element.catNome == 'Biografia');
        categorias.removeWhere((element) => element.catNome == 'Contos');
        categorias.removeWhere((element) => element.catNome == 'Drama');
        categorias.removeWhere((element) => element.catNome == 'Fantasia');
        categorias.removeWhere((element) => element.catNome == 'Outros');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double responsiveFontSize(double size) {
      return size * screenWidth / 375;
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context, {
                'selectedCategories': _selectedCategories,
                'removedCategories': _removedCategories
              });
            },
            icon: const Icon(Icons.check),
          ),
        ],
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
    bool isSelected = _selectedCategories.contains(text);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedCategories.remove(text);
            _removedCategories.add(text);
          } else {
            _selectedCategories.add(text);
            _removedCategories.remove(text);
          }
        });
      },
      child: Container(
        margin: EdgeInsets.all(screenWidth * 0.03),
        padding: EdgeInsets.all(screenWidth * 0.03),
        decoration: BoxDecoration(
          color: const Color(0xff4e90cd),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
              color: isSelected
                  ? const Color(0xff1f1d34)
                  : Colors.grey.withOpacity(0.5)),
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
                  color: isSelected
                      ? const Color(0xff1f1d34)
                      : const Color(0xfff6f5f2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

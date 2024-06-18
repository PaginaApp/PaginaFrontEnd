import 'package:projeto_pagina/data/models/categoria_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CategoriaService {
  // método para pegar as categorias
  Future<List<CategoriaModel>> fetchCategorias() async {
    final url = Uri.parse('${dotenv.env['BASE_API_URL']}categoria');
    final response = await http.get(
      url,
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData is List<dynamic>) {
        final List<CategoriaModel> categorias = responseData
            .map((e) => CategoriaModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return categorias;
      } else {
        throw Exception('Formato de resposta inesperado');
      }
    } else {
      throw Exception('Falha ao carregar categorias');
    }
  }
}

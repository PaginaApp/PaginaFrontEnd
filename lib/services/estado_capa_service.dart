import 'package:projeto_pagina/data/models/estado_capa_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EstadoCapaService {
  // Método para buscar estados da capa
  Future<List<EstadoCapaModel>> fetchEstadoCapa() async {
    final url = Uri.parse('${dotenv.env['BASE_API_URL']}estadocapa');
    final response = await http.get(
      url,
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData is List<dynamic>) {
        final List<EstadoCapaModel> estadoCapa = responseData
            .map((e) => EstadoCapaModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return estadoCapa;
      } else {
        throw Exception('Formato de resposta inesperado');
      }
    } else {
      throw Exception('Falha ao carregar estados da capa');
    }
  }
}

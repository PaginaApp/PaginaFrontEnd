import 'package:projeto_pagina/data/models/estado_paginas_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EstadoPaginasService {
  // Método para buscar estados das páginas
  Future<List<EstadoPaginasModel>> fetchEstadoPaginas() async {
    final url = Uri.parse('${dotenv.env['BASE_API_URL']}estadopaginas');
    final response = await http.get(
      url,
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData is List<dynamic>) {
        final List<EstadoPaginasModel> estadoPaginas = responseData
            .map((e) => EstadoPaginasModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return estadoPaginas;
      } else {
        throw Exception('Formato de resposta inesperado');
      }
    } else {
      throw Exception('Falha ao carregar estado_paginas');
    }
  }
}

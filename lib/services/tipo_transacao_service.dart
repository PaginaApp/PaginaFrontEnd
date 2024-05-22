import 'package:projeto_pagina/data/models/tipo_transacao_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TipoTransacaoService {
  // Método para buscar tipos de transação
  Future<List<TipoTransacaoModel>> fetchTipoTransacao() async {
    final url = Uri.parse('${dotenv.env['BASE_API_URL']}tipotransacao');
    final response = await http.get(
      url,
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData is List<dynamic>) {
        final List<TipoTransacaoModel> tipoTransacao = responseData
            .map((e) => TipoTransacaoModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return tipoTransacao;
      } else {
        throw Exception('Formato de resposta inesperado');
      }
    } else {
      throw Exception('Falha ao carregar tipo_transacao');
    }
  }
}

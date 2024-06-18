import 'package:projeto_pagina/data/models/transacao_anunciante_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class ITransacaoAnuncianteRepository {
  Future<List<TransacaoAnuncianteModel>> getTransacoesAnuncianteById(String id);
}

class TransacaoAnuncianteRepository implements ITransacaoAnuncianteRepository {
  @override
  Future<List<TransacaoAnuncianteModel>> getTransacoesAnuncianteById(
      String id) async {
    final url =
        Uri.parse('${dotenv.env['BASE_API_URL']}transacao/anunciante/$id');
    final response = await http.get(
      url,
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData is Map<String, dynamic>) {
        final List<dynamic> transacoesData = responseData['results'];

        final List<TransacaoAnuncianteModel> transacoes =
            transacoesData.map((e) {
          final Map<String, dynamic> transacaoData = e as Map<String, dynamic>;
          final List<dynamic> exemplaresData = transacaoData['exemplares'];

          if (exemplaresData.length > 1) {
            exemplaresData.removeWhere((exemplar) => exemplar['exe_Id'] != id);
          }

          transacaoData['exemplares'] = exemplaresData[0];

          return TransacaoAnuncianteModel.fromJson(transacaoData);
        }).toList();

        return transacoes;
      } else {
        throw Exception('Formato de resposta inesperado');
      }
    } else {
      throw Exception('Erro ao buscar transações');
    }
  }
}

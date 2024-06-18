import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:projeto_pagina/data/models/tipo_transacao_model.dart';

class TransacaoService {
  // método para criar transacao
  Future<void> createTransacao(String data, String ttrId, String usuLeitorId,
      String usuAnuncianteId, String exemplarPrincipalId) async {
    final url = Uri.parse('${dotenv.env['BASE_API_URL']}transacao');

    final response = await http.post(
      url,
      body: json.encode({
        'trs_Data': data,
        'trs_ttr_id': ttrId,
        'trs_usu_Leitor_id': usuLeitorId,
        'trs_usu_Anunciante_id': usuAnuncianteId,
        'exe_Principal_id': exemplarPrincipalId,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 201) {
      throw Exception('Erro ao criar transação');
    }
  }

  // método para aceitar transacao
  Future<void> aceitarTransacao(String transacaoId) async {
    final url = Uri.parse(
        '${dotenv.env['BASE_API_URL']}transacao/$transacaoId/aceitar');

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao aceitar transação');
    }
  }

  // método para concluir transacao
  Future<void> concluirTransacao(String transacaoId) async {
    final url = Uri.parse(
        '${dotenv.env['BASE_API_URL']}transacao/$transacaoId/concluir');

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao concluir transação');
    }
  }

  // método para cancelar transacao
  Future<void> cancelarTransacao(String transacaoId) async {
    final url = Uri.parse(
        '${dotenv.env['BASE_API_URL']}transacao/$transacaoId/cancelar');

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao cancelar transação');
    }
  }

  // método para buscar tipos de transacao
  Future<List<TipoTransacaoModel>> getTiposTransacao() async {
    final url = Uri.parse('${dotenv.env['BASE_API_URL']}tipotransacao');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData is List<dynamic>) {
        final List<TipoTransacaoModel> tiposTransacao = responseData
            .map((e) => TipoTransacaoModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return tiposTransacao;
      } else {
        throw Exception('Formato de resposta inesperado');
      }
    } else {
      throw Exception('Erro ao buscar tipos de transação');
    }
  }
}

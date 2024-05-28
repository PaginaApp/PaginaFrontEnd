import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:projeto_pagina/data/models/exemplar_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class IExemplarRepository {
  Future<List<ExemplarModel>> getExemplares(int page, int limit);

  Future<List<ExemplarModel>> getExemplaresByUser(
      String id, int page, int limit);

  Future<void> createExemplar(
    String descricao,
    String livroId,
    String userId,
    String estadoPaginaId,
    String estadoCapaId,
    List<String> tiposTransacaoId,
    String? preco,
    int? prazo,
  );

  Future<void> updateExemplar(
    String id,
    String descricao,
    String livroId,
    String userId,
    String estadoPaginaId,
    String estadoCapaId,
    List<String> tiposTransacaoId,
    String? preco,
    int? prazo,
  );

  Future<void> deleteExemplar(String id);
}

class ExemplarRepository implements IExemplarRepository {
  @override
  Future<List<ExemplarModel>> getExemplares(int page, int limit) async {
    final url = Uri.parse(
        '${dotenv.env['BASE_API_URL']}exemplar/?page=$page&limit=$limit');
    final response = await http.get(
      url,
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData is Map<String, dynamic>) {
        final List<dynamic> exemplaresData = responseData['results'];

        final List<ExemplarModel> exemplares = exemplaresData
            .map((e) => ExemplarModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return exemplares;
      } else {
        throw Exception('Formato de resposta inesperado');
      }
    } else {
      throw Exception('Falha ao carregar exemplares');
    }
  }

  @override
  Future<List<ExemplarModel>> getExemplaresByUser(
      String id, int page, int limit) async {
    final url = Uri.parse(
        '${dotenv.env['BASE_API_URL']}exemplar/user/$id?page=$page&limit=$limit');
    final response = await http.get(
      url,
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData is Map<String, dynamic>) {
        final List<dynamic> exemplaresData = responseData['results'];

        final List<ExemplarModel> exemplares = exemplaresData
            .map((e) => ExemplarModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return exemplares;
      } else {
        throw Exception('Formato de resposta inesperado');
      }
    } else {
      throw Exception('Falha ao carregar exemplares');
    }
  }

  @override
  Future<void> createExemplar(
    String descricao,
    String livroId,
    String userId,
    String estadoPaginaId,
    String estadoCapaId,
    List<String> tiposTransacaoId,
    String? preco,
    int? prazo,
  ) async {
    final url = Uri.parse('${dotenv.env['BASE_API_URL']}exemplar/');

    Map<String, dynamic> body = {
      'exe_Descricao': descricao,
      'exe_Negociando': false,
      'exe_liv_id': livroId,
      'exe_usu_id': userId,
      'exe_epg_id': estadoPaginaId,
      'exe_ecp_id': estadoCapaId,
      'exe_trs_id': tiposTransacaoId,
    };
    if (preco != null) {
      body['exe_Preco'] = preco;
    }
    if (prazo != null) {
      body['exe_Prazo'] = prazo;
    }

    final response = await http.post(
      url,
      body: json.encode(body),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao criar exemplar');
    }
  }

  @override
  Future<void> updateExemplar(
    String id,
    String descricao,
    String livroId,
    String userId,
    String estadoPaginaId,
    String estadoCapaId,
    List<String> tiposTransacaoId,
    String? preco,
    int? prazo,
  ) async {
    final url = Uri.parse('${dotenv.env['BASE_API_URL']}exemplar/$id');

    Map<String, dynamic> body = {
      'exe_Descricao': descricao,
      'exe_Negociando': false,
      'exe_liv_id': livroId,
      'exe_usu_id': userId,
      'exe_epg_id': estadoPaginaId,
      'exe_ecp_id': estadoCapaId,
      'exe_trs_id': tiposTransacaoId,
    };
    if (preco != null) {
      body['exe_Preco'] = preco;
    }
    if (prazo != null) {
      body['exe_Prazo'] = prazo;
    }

    final response = await http.put(
      url,
      body: json.encode(body),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao atualizar exemplar');
    }
  }

  @override
  Future<void> deleteExemplar(String id) async {
    final url = Uri.parse('${dotenv.env['BASE_API_URL']}exemplar/$id');

    final response = await http.delete(
      url,
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao deletar exemplar');
    }
  }
}

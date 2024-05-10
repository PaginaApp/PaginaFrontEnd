import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:projeto_pagina/data/models/exemplar_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class IExemplarRepository {
  Future<List<ExemplarModel>> getExemplares(int page, int limit);
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
}

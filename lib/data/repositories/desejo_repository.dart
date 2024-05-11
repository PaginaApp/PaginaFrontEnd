import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:projeto_pagina/data/models/desejo_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class IDesejoRepository {
  Future<List<DesejoModel>> listDesejos(int page, int limit, String id);

  Future<void> addDesejo(String id, String idLivro);

  Future<void> deleteDesejo(String id, String idLivro);
}

class DesejoRepository implements IDesejoRepository {
  @override
  Future<List<DesejoModel>> listDesejos(int page, int limit, String id) async {
    final url = Uri.parse(
        '${dotenv.env['BASE_API_URL']}users/$id/ListaDeDesejo?page=$page&limit=$limit');
    final response = await http.get(
      url,
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData is Map<String, dynamic>) {
        final List<dynamic> desejosData = responseData['results'];

        final List<DesejoModel> desejos = desejosData
            .map((e) => DesejoModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return desejos;
      } else {
        throw Exception('Formato de resposta inesperado');
      }
    } else {
      throw Exception('Falha ao carregar produtos');
    }
  }

  @override
  Future<void> addDesejo(String id, String idLivro) async {
    final url =
        Uri.parse('${dotenv.env['BASE_API_URL']}users/$id/ListaDeDesejo');
    final response = await http.post(
      url,
      body: json.encode({
        'liv_Id': idLivro,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 201) {
      throw Exception('Falha ao adicionar desejo');
    }
  }

  @override
  Future<void> deleteDesejo(String id, String idLivro) async {
    final url = Uri.parse(
        '${dotenv.env['BASE_API_URL']}users/$id/ListaDeDesejo/$idLivro');
    final response = await http.delete(
      url,
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao remover desejo');
    }
  }
}

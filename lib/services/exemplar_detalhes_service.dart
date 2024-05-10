import 'package:flutter/material.dart';
import 'package:projeto_pagina/data/models/exemplar_detalhes_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

class ExemplarDetalhesService {
  Future<ExemplarDetalhesModel> fetchExemplarDetalhes(String id) async {
    final url = Uri.parse('${dotenv.env['BASE_API_URL']}exemplar/$id');
    final response = await http.get(
      url,
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData is Map<String, dynamic>) {
        final ExemplarDetalhesModel exemplarDetalhes =
            ExemplarDetalhesModel.fromJson(responseData);

        return exemplarDetalhes;
      } else {
        throw Exception('Formato de resposta inesperado');
      }
    } else {
      throw Exception('Falha ao carregar exemplar');
    }
  }

  Future<List<String>> fetchImagemExemplarId(String id) async {
    final url =
        Uri.parse('${dotenv.env['BASE_API_URL']}exemplar/$id/imagem-exemplar');
    final response = await http.get(
      url,
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData is List<dynamic>) {
        List<String> imageUrls =
            responseData.map((item) => item['iex_Id']).cast<String>().toList();

        return imageUrls;
      } else {
        throw Exception('Formato de resposta inesperado');
      }
    } else {
      throw Exception('Falha ao carregar IDs de imagens do exemplar');
    }
  }

  Future<Image> fetchImagemExemplar(String id) async {
    final url =
        Uri.parse('${dotenv.env['BASE_API_URL']}exemplar/imagem-exemplar/$id');
    final response = await http.get(
      url,
    );

    if (response.statusCode == 200) {
      return Image.memory(response.bodyBytes);
    } else {
      throw Exception('Falha ao carregar imagem do exemplar');
    }
  }
}

import 'package:projeto_pagina/data/models/produto_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class IProdutoRepository {
  Future<List<ProdutoModel>> getProdutos(int page, int limit);
  Future<ProdutoModel> findByTitulo(String titulo);
  Future<List<ProdutoModel>> findByISBN(String isbn);
  Future<List<ProdutoModel>> listByName(int page, int limit, String name);
}

class ProdutoRepository implements IProdutoRepository {
  @override
  Future<List<ProdutoModel>> getProdutos(int page, int limit) async {
    final url = Uri.parse(
        '${dotenv.env['BASE_API_URL']}livro/titulo?page=$page&limit=$limit');
    final response = await http.get(
      url,
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData is Map<String, dynamic>) {
        final List<dynamic> produtosData = responseData['results'];

        final List<ProdutoModel> produtos = produtosData
            .map((e) => ProdutoModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return produtos;
      } else {
        throw Exception('Formato de resposta inesperado');
      }
    } else {
      throw Exception('Falha ao carregar produtos');
    }
  }

  @override
  Future<ProdutoModel> findByTitulo(String titulo) async {
    final url = Uri.parse('${dotenv.env['BASE_API_URL']}livro/titulo/$titulo');
    final response = await http.get(
      url,
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData is Map<String, dynamic>) {
        final ProdutoModel produto = ProdutoModel.fromJson(responseData);

        return produto;
      } else {
        throw Exception('Formato de resposta inesperado');
      }
    } else {
      throw Exception('Falha ao carregar produtos');
    }
  }

  @override
  Future<List<ProdutoModel>> findByISBN(String isbn) async {
    final url = Uri.parse('${dotenv.env['BASE_API_URL']}livro/isbn/$isbn');
    final response = await http.get(
      url,
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData is Map<String, dynamic>) {
        final ProdutoModel produto = ProdutoModel.fromJson(responseData);

        return [produto];
      } else {
        throw Exception('Formato de resposta inesperado');
      }
    } else {
      throw Exception('Falha ao carregar produtos');
    }
  }

  @override
  Future<List<ProdutoModel>> listByName(
      int page, int limit, String name) async {
    final url = Uri.parse(
        '${dotenv.env['BASE_API_URL']}livro/titulo?page=$page&limit=$limit&liv_Titulo=$name');
    final response = await http.get(
      url,
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData is Map<String, dynamic>) {
        final List<dynamic> produtosData = responseData['results'];

        final List<ProdutoModel> produtos = produtosData
            .map((e) => ProdutoModel.fromJson(e as Map<String, dynamic>))
            .toList();

        return produtos;
      } else {
        throw Exception('Formato de resposta inesperado');
      }
    } else {
      throw Exception('Falha ao carregar produtos');
    }
  }
}

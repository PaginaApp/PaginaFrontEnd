import 'package:flutter/material.dart';
import 'package:projeto_pagina/data/models/produto_model.dart';
import 'package:projeto_pagina/data/repositories/produto_repository.dart';

class ProdutoStore {
  final IProdutoRepository produtoRepository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<ProdutoModel>> state =
      ValueNotifier<List<ProdutoModel>>([]);

  final ValueNotifier<String> error = ValueNotifier<String>('');

  ProdutoStore({required this.produtoRepository});

  Future getProdutos(int page, int limit) async {
    isLoading.value = true;
    try {
      final result = await produtoRepository.getProdutos(page, limit);
      state.value = result;
    } catch (e) {
      error.value = e.toString();
    }

    isLoading.value = false;
  }

  Future<void> pesquisarProdutos(String query) async {
    List<ProdutoModel> novosProdutos;

    // Se a query só contém números, busca por ISBN
    if (_isNumeric(query)) {
      novosProdutos = await produtoRepository.findByISBN(query);
    } else {
      // Se não, busca por uma parte do título
      novosProdutos = await produtoRepository.listByName(1, 50, query);

      // Se não, busca todo o titulo inteiro
      if (novosProdutos.isEmpty) {
        novosProdutos =
            (await produtoRepository.findByTitulo(query)) as List<ProdutoModel>;
      }
    }

    state.value = novosProdutos;
  }

  bool _isNumeric(String s) {
    return double.tryParse(s) != null;
  }
}

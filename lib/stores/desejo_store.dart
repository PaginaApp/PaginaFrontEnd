import 'package:flutter/material.dart';
import 'package:projeto_pagina/data/models/desejo_model.dart';
import 'package:projeto_pagina/data/repositories/desejo_repository.dart';

class DesejoStore {
  final IDesejoRepository desejoRepository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<DesejoModel>> state =
      ValueNotifier<List<DesejoModel>>([]);

  final ValueNotifier<String> error = ValueNotifier<String>('');

  DesejoStore({required this.desejoRepository});

  // método para obter a lista de desejos
  Future getDesejos(int page, int limit, String id) async {
    isLoading.value = true;
    try {
      final result = await desejoRepository.listDesejos(page, limit, id);
      state.value = result;
    } catch (e) {
      error.value = e.toString();
    }

    isLoading.value = false;
  }

  // método para adicionar um livro na lista de desejos
  Future<void> addDesejo(String id, String idLivro) async {
    try {
      await desejoRepository.addDesejo(id, idLivro);
    } catch (e) {
      error.value = e.toString();
    }
  }

  // método para remover um livro da lista de desejos
  Future<void> deleteDesejo(String id, String idLivro) async {
    try {
      await desejoRepository.deleteDesejo(id, idLivro);
    } catch (e) {
      error.value = e.toString();
    }
  }
}

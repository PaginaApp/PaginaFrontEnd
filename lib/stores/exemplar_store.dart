import 'package:flutter/material.dart';
import 'package:projeto_pagina/data/models/exemplar_model.dart';
import 'package:projeto_pagina/data/repositories/exemplar_repository.dart';

class ExemplarStore {
  final IExemplarRepository exemplarRepository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<ExemplarModel>> state =
      ValueNotifier<List<ExemplarModel>>([]);

  final ValueNotifier<String> error = ValueNotifier<String>('');

  ExemplarStore({required this.exemplarRepository});

  Future getExemplares(int page, int limit) async {
    isLoading.value = true;
    try {
      final result = await exemplarRepository.getExemplares(page, limit);
      state.value = result;
    } catch (e) {
      error.value = e.toString();
    }

    isLoading.value = false;
  }
}

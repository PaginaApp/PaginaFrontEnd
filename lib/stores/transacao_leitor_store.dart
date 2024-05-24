import 'package:flutter/material.dart';
import 'package:projeto_pagina/data/models/transacao_leitor_model.dart';
import 'package:projeto_pagina/data/repositories/transacao_leitor_repository.dart';

class TransacaoLeitorStore {
  final ITransacaoLeitorRepository transacaoLeitorRepository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<TransacaoLeitorModel>> state =
      ValueNotifier<List<TransacaoLeitorModel>>([]);

  final ValueNotifier<String> error = ValueNotifier<String>('');

  TransacaoLeitorStore({required this.transacaoLeitorRepository});

  Future getTransacoesLeitorById(String id) async {
    isLoading.value = true;
    try {
      final result =
          await transacaoLeitorRepository.getTransacoesLeitorById(id);
      state.value = result;
    } catch (e) {
      error.value = e.toString();
    }

    isLoading.value = false;
  }
}

import 'package:flutter/material.dart';
import 'package:projeto_pagina/data/models/transacao_anunciante_model.dart';
import 'package:projeto_pagina/data/repositories/transacao_anunciante_repository.dart';

class TransacaoAnuncianteStore {
  final ITransacaoAnuncianteRepository transacaoAnuncianteRepository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<TransacaoAnuncianteModel>> state =
      ValueNotifier<List<TransacaoAnuncianteModel>>([]);

  final ValueNotifier<String> error = ValueNotifier<String>('');

  TransacaoAnuncianteStore({required this.transacaoAnuncianteRepository});

  Future getTransacoesAnuncianteById(String id) async {
    isLoading.value = true;
    try {
      final result =
          await transacaoAnuncianteRepository.getTransacoesAnuncianteById(id);
      state.value = result;
    } catch (e) {
      error.value = e.toString();
    }

    isLoading.value = false;
  }
}

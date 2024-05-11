import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:projeto_pagina/data/models/endereco_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EnderecoService {
  Future<EnderecoModel> fetchEndereco(String id) async {
    final url = Uri.parse('${dotenv.env['BASE_API_URL']}users/$id/endereco');
    final response = await http.get(
      url,
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData is Map<String, dynamic>) {
        final EnderecoModel endereco = EnderecoModel.fromJson(responseData);

        return endereco;
      } else {
        throw Exception('Formato de resposta inesperado');
      }
    } else {
      throw Exception('Falha ao carregar endereço');
    }
  }

  // Registro de endereço
  Future<void> registerEndereco(
    String userId,
    String cep,
    String city,
    String neighborhood,
    String street,
    String number,
    String state,
    String complement,
  ) async {
    final urlAdress =
        Uri.parse('${dotenv.env['BASE_API_URL']}users/$userId/endereco');

    final responseAdress = await http.post(
      urlAdress,
      body: json.encode({
        'usu_CEP': cep,
        'usu_cid_nome': city,
        'usu_Bairro': neighborhood,
        'usu_Rua': street,
        'usu_Numero': number,
        'usu_est_UF': state,
        'usu_Complemento': complement,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (responseAdress.statusCode != 201) {
      throw Exception('Erro ao registrar endereço');
    }
  }

  // Atualização de endereço
  Future<void> updateEndereco(
    String id,
    String cep,
    String city,
    String neighborhood,
    String street,
    String number,
    String state,
    String complement,
  ) async {
    final url = Uri.parse('${dotenv.env['BASE_API_URL']}users/$id/endereco');
    final response = await http.put(
      url,
      body: json.encode({
        'usu_CEP': cep,
        'usu_cid_nome': city,
        'usu_Bairro': neighborhood,
        'usu_Rua': street,
        'usu_Numero': number,
        'usu_est_UF': state,
        'usu_Complemento': complement,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao atualizar endereço');
    }
  }
}

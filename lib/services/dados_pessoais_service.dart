import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projeto_pagina/data/models/dados_pessoais_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class DadosPessoaisService {
  // método para pegar os dados pessoais do usuário
  Future<DadosPessoaisModel> fetchDadosPessoais(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final url = Uri.parse('${dotenv.env['BASE_API_URL']}users/$userId');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData is Map<String, dynamic>) {
        final DadosPessoaisModel dadosPessoais =
            DadosPessoaisModel.fromJson(responseData);

        return dadosPessoais;
      } else {
        throw Exception('Formato de resposta inesperado');
      }
    } else {
      throw Exception('Erro ao carregar dados pessoais');
    }
  }

  // método para atualizar os dados pessoais do usuário
  Future<void> updateDadosPessoais(String userId, String phoneNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = Uri.parse('${dotenv.env['BASE_API_URL']}users/$userId');

    final response = await http.put(
      url,
      body: json.encode({
        'usu_Telefone': phoneNumber,
      }),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao atualizar dados pessoais');
    }
  }

  // método para pegar o avatar (foto de perfil) do usuário
  Future<Image> fetchAvatar(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = Uri.parse('${dotenv.env['BASE_API_URL']}users/$userId/avatar');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return Image.memory(response.bodyBytes);
    } else {
      throw Exception('Erro ao carregar avatar');
    }
  }
}

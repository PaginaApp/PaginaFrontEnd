import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService {
  // Método para autenticar usuário
  Future<void> loginUser(String email, String password) async {
    final url = Uri.parse('${dotenv.env['BASE_API_URL']}session/');

    final response = await http.post(
      url,
      body: json.encode({
        'usu_Email': email.trim(),
        'usu_Senha': password,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final token = responseData['accessToken'];
      final userId = responseData['user']['usu_Id'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token.toString());
      await prefs.setString('userId', userId.toString());
    } else {
      throw Exception('Erro ao autenticar usuário');
    }
  }

  // Método para deslogar usuário
  Future<void> logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('token');
    prefs.remove('userId');
  }

  // Método para registrar usuário e endereço
  Future<void> registerUserAndAdress(
    String name,
    String birthDate,
    String cpf,
    String phoneNumber,
    String email,
    String password,
    String cep,
    String city,
    String neighborhood,
    String street,
    String number,
    String state,
    String complement,
  ) async {
    final urlRegister = Uri.parse('${dotenv.env['BASE_API_URL']}users');

    DateTime dateTime = DateTime.parse(birthDate.split('/').reversed.join('-'));
    String birthDateIso = dateTime.toIso8601String();

    final responseRegister = await http.post(
      urlRegister,
      body: json.encode({
        'usu_Nome': name.trim(),
        'usu_Nasc': birthDateIso,
        'usu_CPF': cpf,
        'usu_Telefone': phoneNumber,
        'usu_Email': email.trim(),
        'usu_Senha': password,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (responseRegister.statusCode == 201) {
      final responseData = json.decode(responseRegister.body);
      final userId = responseData['usu_Id'];

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
    } else {
      throw Exception('Erro ao registrar usuário');
    }
  }

  // Método para alterar a senha do usuário
  Future<void> changePassword(
      String currentPassword, String newPassword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final token = prefs.getString('token');

    final url = Uri.parse('${dotenv.env['BASE_API_URL']}users/$userId/senha');

    final response = await http.put(
      url,
      body: json.encode({
        'usu_Senha': currentPassword,
        'novaSenha': newPassword,
      }),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao alterar senha');
    }
  }

  // Método para deletar a conta do usuário
  Future<void> deleteUserAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    //final token = prefs.getString('token');

    final url = Uri.parse('${dotenv.env['BASE_API_URL']}users/$userId');

    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        //'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Erro ao deletar conta');
    } else {
      logoutUser();
    }
  }
}

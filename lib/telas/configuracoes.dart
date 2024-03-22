import 'package:flutter/material.dart';
import 'package:projeto_pagina/telas/configuracoes_acervo_cadastros.dart';
import 'package:projeto_pagina/telas/configuracoes_alterar_senha.dart';
import 'package:projeto_pagina/telas/configuracoes_avaliacoes_titulos.dart';
import 'package:projeto_pagina/telas/configuracoes_excluir.dart';
import 'package:projeto_pagina/telas/configuracoes_historico.dart';
import 'package:projeto_pagina/telas/configuracoes_lista_de_desejos.dart';
import 'package:projeto_pagina/telas/configuracoes_logout.dart';
import 'package:projeto_pagina/telas/configuracoes_meus_dados.dart';
import 'package:projeto_pagina/telas/configuracoes_suporte.dart';
import 'package:projeto_pagina/telas/configuracoes_termos_uso.dart';

class Configuracoes extends StatefulWidget {
  const Configuracoes({super.key});

  @override
  State<Configuracoes> createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double responsiveFontSize(double size) {
      return size * screenWidth / 375;
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight / 6),
        child: AppBar(
          backgroundColor: const Color(0xff4e90cd),
          iconTheme: const IconThemeData(color: Color(0xfff6f5f2)),
          flexibleSpace: Stack(
            children: [
              Positioned(
                left: screenWidth * 0.05,
                top: screenHeight * 0.1,
                child: CircleAvatar(
                  radius: screenWidth * 0.08,
                  backgroundColor: const Color(0xfff6f5f2),
                  child: Icon(Icons.person, size: screenWidth * 0.07),
                ),
              ),
              Positioned(
                left: screenWidth * 0.23,
                top: screenHeight * 0.07,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nome do usuário',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: responsiveFontSize(18),
                          color: const Color(0xfff6f5f2),
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '@título',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: responsiveFontSize(15),
                          color: const Color(0xfff6f5f2)),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: screenWidth * 0.01,
                bottom: screenHeight * 0.01,
                child: Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xfff6f5f2),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.person),
                        color: const Color(0xff4e90cd),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ConfiguracoesMeusDados(),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xfff6f5f2),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.lock),
                        color: const Color(0xff4e90cd),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ConfiguracoesAlterarSenha(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        color: const Color(0xfff6f5f2),
        child: ListView(
          padding: EdgeInsets.all(screenWidth * 0.05),
          children: [
            Text(
              'Minha Conta',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: responsiveFontSize(18),
                  color: const Color(0xff14131a),
                  fontWeight: FontWeight.bold),
            ),
            _buildButton(
                'Meu acervo', Icons.book, const ConfiguracoesAcervoCadastros()),
            _buildButton('Avaliações e Títulos', Icons.star,
                const ConfiguracoesAvaliacoesTitulos()),
            _buildButton(
                'Histórico', Icons.history, const ConfiguracoesHistorico()),
            _buildButton('Lista de desejos', Icons.favorite,
                const ConfiguracoesListaDeDesejos()),
            SizedBox(height: screenHeight * 0.01),
            Text(
              'Configurações',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: responsiveFontSize(18),
                  color: const Color(0xff14131a),
                  fontWeight: FontWeight.bold),
            ),
            _buildButton(
                'Suporte', Icons.support_agent, const ConfiguracoesSuporte()),
            _buildButton('Termos de uso', Icons.description,
                const ConfiguracoesTermosUso()),
            _buildButton('Logout', Icons.logout, const ConfiguracoesLogout()),
            _buildButton(
                'Excluir Conta', Icons.delete, const ConfiguracoesExcluir()),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String title, IconData icon, Widget screen) {
    double screenHeight = MediaQuery.of(context).size.height;

    double responsiveFontSize(double size) {
      return size * MediaQuery.of(context).size.width / 375;
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xff14131a)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xff14131a)),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'Poppins',
            color: const Color(0xff14131a),
            fontSize: responsiveFontSize(14),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
      ),
    );
  }
}

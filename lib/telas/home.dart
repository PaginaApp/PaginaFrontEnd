import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            child: Column(
              children: [
                // Barra de pesquisa
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Pesquisar...',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                // Caixa com rolagem
                Container(
                  height: 200,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        // Adicione suas caixas aqui
                      ],
                    ),
                  ),
                ),
                // 4 Círculos
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCircle('doação'),
                    _buildCircle('empréstimo'),
                    _buildCircle('troca'),
                    _buildCircle('venda'),
                  ],
                ),
              ],
            ),
          ),
          // Parte branca
          Expanded(
            child: Container(
              color: Colors.white,
              // Adicione conteúdo branco aqui
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircle(String text) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 20,
          child: Icon(
            Icons.shopping_cart,
            color: Colors.blue,
          ), // Adicione ícones correspondentes aqui
        ),
        SizedBox(height: 4),
        Text(text),
      ],
    );
  }
}

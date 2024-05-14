class ExemplarDetalhesModel {
  final String id;
  final String descricao;
  final bool negociando;
  final String usuID;
  final String titulo;
  final String livID;
  final String isbn;
  final String autor;
  final String editora;
  final List<String> categorias;
  final String sinopse;
  final String estadoCapa;
  final String estadoPaginas;

  ExemplarDetalhesModel({
    required this.id,
    required this.descricao,
    required this.negociando,
    required this.usuID,
    required this.titulo,
    required this.livID,
    required this.isbn,
    required this.autor,
    required this.editora,
    required this.categorias,
    required this.sinopse,
    required this.estadoCapa,
    required this.estadoPaginas,
  });

  factory ExemplarDetalhesModel.fromJson(Map<String, dynamic> json) {
    return ExemplarDetalhesModel(
      id: json['exe_Id'],
      descricao: json['exe_Descricao'],
      negociando: json['exe_Negociando'],
      usuID: json['exe_usu_id'],
      titulo: json['livro']['liv_Titulo'],
      livID: json['livro']['liv_Id'],
      isbn: json['livro']['liv_ISBN'],
      autor: json['livro']['autor']['aut_Nome'],
      editora: json['livro']['editora']['edi_Nome'],
      categorias: [
        for (var item in json['livro']['categorias']) item['cat_Nome']
      ],
      sinopse: json['livro']['liv_Sinopse'],
      estadoCapa: json['estadoCapa']['ecp_Nome'],
      estadoPaginas: json['estadoPaginas']['epg_Nome'],
    );
  }
}

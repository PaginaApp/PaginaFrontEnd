class ExemplarDetalhesModel {
  final String id;
  final String descricao;
  final bool negociando;
  final String usuID;
  final String titulo;
  final String ano;
  final String livID;
  final String isbn;
  final String autor;
  final String editora;
  final List<String> categorias;
  final String sinopse;
  final String estadoCapa;
  final String ecpId;
  final String estadoPaginas;
  final String epgId;

  ExemplarDetalhesModel({
    required this.id,
    required this.descricao,
    required this.negociando,
    required this.usuID,
    required this.titulo,
    required this.ano,
    required this.livID,
    required this.isbn,
    required this.autor,
    required this.editora,
    required this.categorias,
    required this.sinopse,
    required this.estadoCapa,
    required this.ecpId,
    required this.estadoPaginas,
    required this.epgId,
  });

  factory ExemplarDetalhesModel.fromJson(Map<String, dynamic> json) {
    return ExemplarDetalhesModel(
      id: json['exe_Id'],
      descricao: json['exe_Descricao'],
      negociando: json['exe_Negociando'],
      usuID: json['exe_usu_id'],
      titulo: json['livro']['liv_Titulo'],
      ano: json['livro']['liv_Ano'],
      livID: json['livro']['liv_Id'],
      isbn: json['livro']['liv_ISBN'],
      autor: json['livro']['autor']['aut_Nome'],
      editora: json['livro']['editora']['edi_Nome'],
      categorias: [
        for (var item in json['livro']['categorias']) item['cat_Nome']
      ],
      sinopse: json['livro']['liv_Sinopse'],
      estadoCapa: json['estadoCapa']['ecp_Nome'],
      ecpId: json['estadoCapa']['ecp_Id'],
      estadoPaginas: json['estadoPaginas']['epg_Nome'],
      epgId: json['estadoPaginas']['epg_Id'],
    );
  }
}

class ExemplarDetalhesModel {
  final String id;
  final String descricao;
  final bool negociando;
  final String? preco;
  final int? prazo;
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
  final List<String> tiposTransacoes;

  ExemplarDetalhesModel({
    required this.id,
    required this.descricao,
    required this.negociando,
    required this.preco,
    required this.prazo,
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
    required this.tiposTransacoes,
  });

  factory ExemplarDetalhesModel.fromJson(Map<String, dynamic> json) {
    return ExemplarDetalhesModel(
      id: json['exe_Id'],
      descricao: json['exe_Descricao'],
      negociando: json['exe_Negociando'],
      preco: json['exe_Preco'] != null && json['exe_Preco'] is String
          ? json['exe_Preco']
          : null,
      prazo: json['exe_Prazo'] != null && json['exe_Prazo'] is num
          ? json['exe_Prazo'].toInt()
          : null,
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
      tiposTransacoes: [
        for (var item in json['tiposTransacoes']) item['ttr_Nome']
      ],
    );
  }
}

class TransacaoLeitorModel {
  final String id;
  final double? preco;
  final int? prazo;
  final String usuLeitorId;
  final String usuAnuncianteId;
  final String tipoTransacao;
  final String statusTransacao;
  final String exemplaresId;
  final bool exemplarNegociando;
  final String exemplaresUsuarioId;
  final String titulo;
  final List<String> categorias;

  TransacaoLeitorModel({
    required this.id,
    required this.preco,
    required this.prazo,
    required this.usuLeitorId,
    required this.usuAnuncianteId,
    required this.tipoTransacao,
    required this.statusTransacao,
    required this.exemplaresId,
    required this.exemplarNegociando,
    required this.exemplaresUsuarioId,
    required this.titulo,
    required this.categorias,
  });

  factory TransacaoLeitorModel.fromJson(Map<String, dynamic> json) {
    return TransacaoLeitorModel(
      id: json['trs_Id'],
      preco: json['trs_Preco'] != null && json['trs_Preco'] is num
          ? json['trs_Preco'].toDouble()
          : null,
      prazo: json['trs_Prazo'] != null && json['trs_Prazo'] is num
          ? json['trs_Prazo'].toInt()
          : null,
      usuLeitorId: json['trs_usu_Leitor_id'],
      usuAnuncianteId: json['trs_usu_Anunciante_id'],
      tipoTransacao: json['tipoTransacao']['ttr_Nome'],
      statusTransacao: json['statusTransacao']['str_Nome'],
      exemplaresId: json['exemplares']['exe_Id'],
      exemplarNegociando: json['exemplares']['exe_Negociando'],
      exemplaresUsuarioId: json['exemplares']['exe_usu_id'],
      titulo: json['exemplares']['livro']['liv_Titulo'],
      categorias: [
        for (var item in json['exemplares']['livro']['categorias'])
          item['cat_Nome']
      ],
    );
  }
}

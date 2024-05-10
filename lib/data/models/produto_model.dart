class ProdutoModel {
  final String id;
  final String titulo;
  final String ano;
  final String sinopse;
  final String isbn;
  final String autor;
  final String editora;

  ProdutoModel({
    required this.id,
    required this.titulo,
    required this.ano,
    required this.sinopse,
    required this.isbn,
    required this.autor,
    required this.editora,
  });

  factory ProdutoModel.fromJson(Map<String, dynamic> json) {
    return ProdutoModel(
      id: json['liv_Id'],
      titulo: json['liv_Titulo'],
      ano: json['liv_Ano'],
      sinopse: json['liv_Sinopse'],
      isbn: json['liv_ISBN'],
      autor: json['liv_aut_id'],
      editora: json['liv_edi_id'],
    );
  }
}

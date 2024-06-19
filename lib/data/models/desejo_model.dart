class DesejoModel {
  final String livID;
  final String titulo;
  final String isbn;
  final List<String> categorias;

  DesejoModel({
    required this.livID,
    required this.titulo,
    required this.isbn,
    required this.categorias,
  });

  factory DesejoModel.fromJson(Map<String, dynamic> json) {
    return DesejoModel(
      livID: json['livro']['liv_Id'],
      titulo: json['livro']['liv_Titulo'],
      isbn: json['livro']['liv_ISBN'],
      categorias: [for (var item in json['categorias']) item['cat_Nome']],
    );
  }
}

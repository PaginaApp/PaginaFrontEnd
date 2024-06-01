class DesejoModel {
  final String livID;
  final String titulo;
  final String isbn;

  DesejoModel({
    required this.livID,
    required this.titulo,
    required this.isbn,
  });

  factory DesejoModel.fromJson(Map<String, dynamic> json) {
    return DesejoModel(
      livID: json['livro']['liv_Id'],
      titulo: json['livro']['liv_Titulo'],
      isbn: json['livro']['liv_ISBN'],
    );
  }
}

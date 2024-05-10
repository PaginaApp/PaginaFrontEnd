class DesejoModel {
  final String livID;
  final String titulo;

  DesejoModel({
    required this.livID,
    required this.titulo,
  });

  factory DesejoModel.fromJson(Map<String, dynamic> json) {
    return DesejoModel(
      livID: json['livro']['liv_Id'],
      titulo: json['livro']['liv_Titulo'],
    );
  }
}

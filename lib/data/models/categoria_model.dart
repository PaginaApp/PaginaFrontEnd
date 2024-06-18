class CategoriaModel {
  final String catNome;

  CategoriaModel({
    required this.catNome,
  });

  factory CategoriaModel.fromJson(Map<String, dynamic> json) {
    return CategoriaModel(
      catNome: json['cat_Nome'],
    );
  }
}

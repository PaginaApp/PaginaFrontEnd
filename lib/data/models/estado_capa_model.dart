class EstadoCapaModel {
  final String id;
  final String nome;

  EstadoCapaModel({
    required this.id,
    required this.nome,
  });

  factory EstadoCapaModel.fromJson(Map<String, dynamic> json) {
    return EstadoCapaModel(
      id: json['ecp_Id'],
      nome: json['ecp_Nome'],
    );
  }
}

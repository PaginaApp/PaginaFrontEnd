class EstadoPaginasModel {
  final String id;
  final String nome;

  EstadoPaginasModel({
    required this.id,
    required this.nome,
  });

  factory EstadoPaginasModel.fromJson(Map<String, dynamic> json) {
    return EstadoPaginasModel(
      id: json['epg_Id'],
      nome: json['epg_Nome'],
    );
  }
}

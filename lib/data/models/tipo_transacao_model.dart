class TipoTransacaoModel {
  final String id;
  final String nome;

  TipoTransacaoModel({
    required this.id,
    required this.nome,
  });

  factory TipoTransacaoModel.fromJson(Map<String, dynamic> json) {
    return TipoTransacaoModel(
      id: json['ttr_Id'],
      nome: json['ttr_Nome'],
    );
  }
}

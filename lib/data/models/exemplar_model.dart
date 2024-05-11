class ExemplarModel {
  final String id;
  final String descricao;
  final bool negociando;
  final String livID;
  final String usuID;
  final String epgID;
  final String ecpID;

  ExemplarModel({
    required this.id,
    required this.descricao,
    required this.negociando,
    required this.livID,
    required this.usuID,
    required this.epgID,
    required this.ecpID,
  });

  factory ExemplarModel.fromJson(Map<String, dynamic> json) {
    return ExemplarModel(
      id: json['exe_Id'],
      descricao: json['exe_Descricao'],
      negociando: json['exe_Negociando'],
      livID: json['exe_liv_id'],
      usuID: json['exe_usu_id'],
      epgID: json['exe_epg_id'],
      ecpID: json['exe_ecp_id'],
    );
  }
}

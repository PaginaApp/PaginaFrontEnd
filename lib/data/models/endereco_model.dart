class EnderecoModel {
  final String cep;
  final String rua;
  final String bairro;
  final String localidade;
  final String uf;
  final String numero;
  final String complemento;

  EnderecoModel(
      {required this.cep,
      required this.rua,
      required this.bairro,
      required this.localidade,
      required this.uf,
      required this.numero,
      required this.complemento});

  factory EnderecoModel.fromJson(Map<String, dynamic> json) {
    return EnderecoModel(
      cep: json['usu_CEP'],
      rua: json['usu_Rua'],
      bairro: json['usu_Bairro'],
      localidade: json['usu_cid']['cid_Nome'],
      uf: json['usu_cid']['cid_est']['est_Nome'],
      numero: json['usu_Numero'],
      complemento: json['usu_Complemento'],
    );
  }
}

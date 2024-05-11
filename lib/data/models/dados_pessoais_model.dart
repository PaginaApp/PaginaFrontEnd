class DadosPessoaisModel {
  String nome;
  String dataNascimento;
  String cpf;
  String telefone;
  String email;
  //String titulo;

  DadosPessoaisModel({
    required this.nome,
    required this.dataNascimento,
    required this.cpf,
    required this.telefone,
    required this.email,
    //required this.titulo,
  });

  factory DadosPessoaisModel.fromJson(Map<String, dynamic> json) {
    return DadosPessoaisModel(
      nome: json['usu_Nome'],
      dataNascimento: json['usu_Nasc'],
      cpf: json['usu_CPF'],
      telefone: json['usu_Telefone'],
      email: json['usu_Email'],
      //titulo: json['usu_Titulo'],
    );
  }
}

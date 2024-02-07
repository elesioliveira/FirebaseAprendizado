// ignore_for_file: public_member_api_docs, sort_constructors_first

class Client {
  String nome;
  String cpf;
  String dataNascimento;
  String endereco;
  String numero;
  String bairro;
  String cidade;
  String estado;
  String cep;
  String? numeroResindencia;
  String? telefone1;
  String? telefone2;
  String? email;

  Client({
    required this.nome,
    required this.cpf,
    required this.dataNascimento,
    required this.endereco,
    required this.numero,
    required this.bairro,
    required this.cidade,
    required this.estado,
    required this.cep,
    this.numeroResindencia,
    this.telefone1,
    this.telefone2,
    this.email,
  });

  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      nome: map['nome'],
      cpf: map['cpf'],
      dataNascimento: map['dataNascimento'],
      endereco: map['endereco'],
      numero: map['numero'],
      bairro: map['bairro'],
      cidade: map['cidade'],
      estado: map['estado'],
      cep: map['cep'],
      numeroResindencia: map['numeroResindencia'] ?? '0',
      telefone1: map['telefone1'] ?? 'sem telefone',
      telefone2: map['telefone2'] ?? 'sem telefone',
      email: map['email'] ?? 'sem email',
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class Venda {
  String cliente;
  String cpf;
  String dataVenda;
  String entregarAte;
  String numeroVenda;
  String produto;
  String valor;
  String vendedor;

  Venda({
    required this.cliente,
    required this.cpf,
    required this.dataVenda,
    required this.entregarAte,
    required this.numeroVenda,
    required this.produto,
    required this.valor,
    required this.vendedor,
  });

  factory Venda.fromMap(Map<String, dynamic> map) {
    return Venda(
      numeroVenda: map['numeroVenda'] ?? '',
      cliente: map['cliente'] ?? '',
      cpf: map['cpf'] ?? '',
      dataVenda: map['dataVenda'] ?? '',
      entregarAte: map['entregarAte'] ?? '',
      produto: map['produto'] ?? '',
      valor: map['valor'] ?? '',
      vendedor: map['vendedor'] ?? '',
    );
  }
}

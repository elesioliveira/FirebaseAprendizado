// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:teste_firebase/pages/venda/model/model_vendas.dart';

abstract class EstadoDaVenda {}

class EstadoInicialVenda extends EstadoDaVenda {}

class CarregandoVenda extends EstadoDaVenda {}

class VendaCarregada extends EstadoDaVenda {
  final List<Venda> vendas;
  VendaCarregada({
    required this.vendas,
  });
}

class ErrorEstadoVenda extends EstadoDaVenda {
  final String mensagem;
  ErrorEstadoVenda({
    required this.mensagem,
  });
}

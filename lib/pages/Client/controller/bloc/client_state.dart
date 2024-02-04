import 'package:teste_firebase/pages/Client/model/novo_cliente_model.dart';

abstract class EstadoCliente {}

class StateInitialClient extends EstadoCliente {}

class StateLoadingClient extends EstadoCliente {}

class StateSucessedClien extends EstadoCliente {
  final List<Client> client;
  StateSucessedClien({
    required this.client,
  });
}

class StateErrorClient extends EstadoCliente {
  final String mensagem;
  StateErrorClient({
    required this.mensagem,
  });
}

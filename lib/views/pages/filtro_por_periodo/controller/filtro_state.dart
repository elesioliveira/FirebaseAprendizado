import 'package:teste_firebase/views/pages/venda/model/model_vendas.dart';

abstract class StateFilterToDateTime {}

class StateInitialFilterDate extends StateFilterToDateTime {}

class StateLoadingFilterDate extends StateFilterToDateTime {}

class StateSucessedFilterDate extends StateFilterToDateTime {
  final List<Venda> vendas;

  StateSucessedFilterDate({required this.vendas});
}

class StateErrorFilterDate extends StateFilterToDateTime {
  final String errorMensagem;

  StateErrorFilterDate({required this.errorMensagem});
}

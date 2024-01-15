// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_firebase/blocs/venda_state.dart';
import 'package:teste_firebase/model/model_vendas.dart';

class VendaCubit extends Cubit<EstadoDaVenda> {
  final List<Venda> _vendas = [];
  List<Venda> get vendas => _vendas;

  VendaCubit() : super(EstadoInicialVenda());

  Future getData() async {
    CollectionReference venda = FirebaseFirestore.instance.collection('vendas');
    emit(CarregandoVenda());
    try {
      QuerySnapshot querySnapshot = await venda.get();

      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Venda venda =
            Venda.fromMap(documentSnapshot.data() as Map<String, dynamic>);
        vendas.add(venda);
        emit(VendaCarregada(vendas: _vendas));
      }
    } catch (e) {
      emit(ErrorEstadoVenda(menssagem: "Erro ao obter dados da coleção: $e"));
    }
  }
}

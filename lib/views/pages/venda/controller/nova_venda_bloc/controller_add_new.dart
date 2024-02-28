import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_alert_snackbar/custom_alert_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_firebase/views/pages/venda/controller/nova_venda_bloc/cubit_state.dart';
import 'package:teste_firebase/views/pages/venda/model/model_vendas.dart';

class AddNewSale extends Cubit<StateOfNewSale> {
  AddNewSale() : super(StateInitialAdd());
  TextEditingController cliente = TextEditingController();

  Future<void> addNewSale({
    required BuildContext context,
    required Venda venda,
    required List<Venda> vendas,
  }) async {
    emit(LoadingState());
    CollectionReference reference =
        FirebaseFirestore.instance.collection('vendas');
    if (vendas.any((v) => v.numeroVenda == venda.numeroVenda)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Numero da venda já existe!'),
        ),
      );
      return;
    }

    Map<String, dynamic> dados = {
      'numeroVenda': venda.numeroVenda.toUpperCase(),
      'cpf': venda.cpf.toUpperCase(),
      'cliente': venda.cliente.toUpperCase(),
      'vendedor': venda.vendedor.toUpperCase(),
      'dataVenda': venda.dataVenda.toUpperCase(),
      'produto': venda.produto.toUpperCase(),
      'valor': venda.valor.toUpperCase(),
      'entregarAte': venda.entregarAte.toUpperCase(),
    };

    await reference.doc(venda.numeroVenda).set(dados).then((value) {
      CustomAlertSnack.init(context,
          size: MediaQuery.sizeOf(context),
          backgrounds: Colors.green[800],
          title: 'OK',
          text: 'Venda adicionada com sucesso!',
          textAlign: TextAlign.center,
          color: Colors.green[800],
          alignCenter: true);
      emit(StateInitialAdd());
    }).catchError(
      (error) {
        emit(StateInitialAdd());
        CustomAlertSnack.init(context,
            size: MediaQuery.sizeOf(context),
            title: 'Erro',
            text: 'Erro ao lançar a venda!',
            textAlign: TextAlign.center,
            alignCenter: true);
      },
    );
  }
}

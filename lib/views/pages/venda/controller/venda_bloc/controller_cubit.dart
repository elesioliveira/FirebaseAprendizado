import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:teste_firebase/views/pages/venda/controller/venda_bloc/cubit_state.dart';
import 'package:teste_firebase/views/pages/venda/model/model_vendas.dart';

class VendaCubit extends Cubit<EstadoDaVenda> {
  final List<Venda> vendas = [];
  VendaCubit() : super(EstadoInicialVenda());

  Future<void> fetchDataSell() async {
    CollectionReference venda = FirebaseFirestore.instance.collection('vendas');
    emit(CarregandoVenda());

    try {
      QuerySnapshot querySnapshot = await venda.get();

      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Venda venda =
            Venda.fromMap(documentSnapshot.data() as Map<String, dynamic>);

        vendas.add(venda);
      }

      if (vendas.isNotEmpty) {
        emit(VendaCarregada(vendas: vendas));
      } else {
        emit(EstadoInicialVenda());
      }
    } catch (e) {
      print(e.toString());
      emit(ErrorEstadoVenda(mensagem: "Erro ao obter dados da coleção: $e"));
    }
  }

  Future<void> deleteSale(
      {required String idDoDocumento, required BuildContext context}) async {
    CollectionReference usuariosCollection =
        FirebaseFirestore.instance.collection('vendas');
    DocumentReference documentReference = usuariosCollection.doc(idDoDocumento);

    await documentReference.delete().then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Venda excluída com sucesso!'),
        ),
      );
      if (vendas.isEmpty) {
        emit(EstadoInicialVenda());
      }

      Navigator.of(context).pop();
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao excluir venda: $error'),
        ),
      );
    });
  }

  emiteScreenInitial() {
    emit(EstadoInicialVenda());
  }

  Future atualizarVenda({
    required BuildContext context,
    required String numeroVenda,
    required String cpf,
    required String cliente,
    required String vendedor,
    required String dataVenda,
    required String valor,
    required String produto,
    required String entregarAte,
    required List<Venda> venda,
  }) async {
    CollectionReference reference =
        FirebaseFirestore.instance.collection('vendas');

    Map<String, dynamic> dados = {
      'numeroVenda': numeroVenda,
      'cpf': cpf,
      'cliente': cliente,
      'vendedor': vendedor,
      'dataVenda': dataVenda,
      'produto': produto,
      'valor': valor,
      'entregarAte': entregarAte,
    };

    await reference.doc(numeroVenda).set(dados).then((value) {
      // Adicionar a nova venda à lista local
      venda.add(Venda.fromMap(dados));
      Navigator.pop(context);
    }).catchError(
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
          ),
        );
      },
    );

    // Mostrar a mensagem de sucesso
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Venda atualizada!'),
      ),
    );
  }

  Future<void> filtrarVendas({required String cliente}) async {
    CollectionReference venda = FirebaseFirestore.instance.collection('vendas');

    emit(CarregandoVenda());

    try {
      QuerySnapshot querySnapshot =
          await venda.where('cliente', isGreaterThanOrEqualTo: cliente).get();

      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Venda venda =
            Venda.fromMap(documentSnapshot.data() as Map<String, dynamic>);

        vendas.add(venda);
      }

      if (vendas.isNotEmpty) {
        emit(VendaCarregada(vendas: vendas));
      } else {
        emit(EstadoInicialVenda());
      }
    } catch (e) {
      emit(ErrorEstadoVenda(mensagem: "Erro ao obter dados $e"));
    }
  }
}

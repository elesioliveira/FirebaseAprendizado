import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_firebase/views/pages/filtro_por_periodo/controller/filtro_state.dart';
import 'package:teste_firebase/views/pages/venda/model/model_vendas.dart';

class FilterSaleToDate extends Cubit<StateFilterToDateTime> {
  FilterSaleToDate() : super(StateInitialFilterDate());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final List<Venda> vendas = [];
  TextEditingController vendedor = TextEditingController();
  TextEditingController cliente = TextEditingController();
  TextEditingController data = TextEditingController();
  TextEditingController cpf = TextEditingController();

  limparTextEditingControllers() {
    vendedor.clear();
    cliente.clear();
    cpf.clear();
    data.clear();
  }

  Future<void> fetchSaleFilter({
    String? dataVenda,
    String? cliente,
    String? vendedor,
    String? cpf,
  }) async {
    print(cliente);

    if (cpf != null) {
      Query query = FirebaseFirestore.instance
          .collection('vendas')
          .where('cpf', isEqualTo: cpf);
      QuerySnapshot querySnapshot = await query.get();

      try {
        for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
          Venda venda =
              Venda.fromMap(documentSnapshot.data() as Map<String, dynamic>);
          vendas.add(venda);
        }

        if (vendas.isNotEmpty) {
          emit(StateSucessedFilterDate(vendas: vendas));
        } else {
          emit(StateInitialFilterDate());
        }
      } catch (e) {
        emit(StateErrorFilterDate(errorMensagem: e.toString()));
      }
    }
    if (cliente != null) {
      Query query = FirebaseFirestore.instance
          .collection('vendas')
          .where('cliente', isEqualTo: cliente);
      QuerySnapshot querySnapshot = await query.get();

      try {
        for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
          Venda venda =
              Venda.fromMap(documentSnapshot.data() as Map<String, dynamic>);
          vendas.add(venda);
        }

        if (vendas.isNotEmpty) {
          emit(StateSucessedFilterDate(vendas: vendas));
        } else {
          emit(StateInitialFilterDate());
        }
      } catch (e) {
        emit(StateErrorFilterDate(errorMensagem: e.toString()));
      }
    }
    if (vendedor != null) {
      Query query = FirebaseFirestore.instance
          .collection('vendas')
          .where('vendedor', isEqualTo: vendedor);
      QuerySnapshot querySnapshot = await query.get();

      try {
        for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
          Venda venda =
              Venda.fromMap(documentSnapshot.data() as Map<String, dynamic>);
          vendas.add(venda);
        }

        if (vendas.isNotEmpty) {
          emit(StateSucessedFilterDate(vendas: vendas));
        } else {
          emit(StateInitialFilterDate());
        }
      } catch (e) {
        emit(StateErrorFilterDate(errorMensagem: e.toString()));
      }
    }
    if (dataVenda != null) {
      Query query = FirebaseFirestore.instance
          .collection('vendas')
          .where('data', isEqualTo: dataVenda);
      QuerySnapshot querySnapshot = await query.get();

      try {
        for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
          Venda venda =
              Venda.fromMap(documentSnapshot.data() as Map<String, dynamic>);
          vendas.add(venda);
        }

        if (vendas.isNotEmpty) {
          emit(StateSucessedFilterDate(vendas: vendas));
        } else {
          emit(StateInitialFilterDate());
        }
      } catch (e) {
        emit(StateErrorFilterDate(errorMensagem: e.toString()));
      }
    }
  }
}

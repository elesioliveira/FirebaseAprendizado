import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:teste_firebase/model/model_vendas.dart';

class VendasRepository {
  List<Venda> vendas = [];

  Future registrarNovoUsuario(String emailAddress, String password, String nome,
      BuildContext context) async {
    try {
      final UserCredential usercredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      await usercredential.user!.updateDisplayName(nome);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Senha fraca.'),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('A conta já existe para esse e-mail.'),
          ),
        );
        // print('A conta já existe para esse e-mail.');
      }
    }
  }

  // Função para excluir o documento
  Future<void> excluirVenda(String idDoDocumento, BuildContext context) async {
    CollectionReference usuariosCollection =
        FirebaseFirestore.instance.collection('vendas');
    DocumentReference documentReference = usuariosCollection.doc(idDoDocumento);

    await documentReference.delete().then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Venda excluída com sucesso!'),
        ),
      );
      Navigator.of(context).pop(); // Fechar o diálogo
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao excluir venda: $error'),
        ),
      );
    });
  }

  Future<void> adicionarNovaVenda({
    required BuildContext context,
    required String numeroVenda,
    required String cpf,
    required String cliente,
    required String vendedor,
    required String dataVenda,
    required String valor,
    required String produto,
    required String entregarAte,
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

      // Adicione outros campos conforme necessário
    };

    // Adicionar o novo documento com o ID específico
    await reference.doc(numeroVenda).set(dados).then((value) {
      Navigator.pop(context);
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
        ),
      );
    });
  }
}

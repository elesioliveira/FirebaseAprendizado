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
}

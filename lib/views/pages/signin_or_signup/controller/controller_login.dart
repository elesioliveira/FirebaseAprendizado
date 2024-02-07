import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:teste_firebase/views/pages/base/view/pagina_base.dart';

class VendasRepository {
  ValueNotifier<bool> logandoSistema = ValueNotifier<bool>(false);
  ValueNotifier<bool> concordarTermos = ValueNotifier<bool>(false);

  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();

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

  Future<void> signInWithEmailAndPassword(
      String email, String password, context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BaseScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao fazer login: $e'),
        ),
      );
    }
  }
}

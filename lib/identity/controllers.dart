import 'package:flutter/material.dart';

class ControllersText extends ChangeNotifier {
  TextEditingController nomeTextEditController = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();
  TextEditingController nome = TextEditingController();
  TextEditingController telefone = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final FocusScopeNode focusScopeNode = FocusScopeNode();
}

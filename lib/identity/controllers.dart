import 'package:flutter/material.dart';

class PagevViewTextControllers extends ChangeNotifier {}

class SellControllers extends ChangeNotifier {
  TextEditingController nome = TextEditingController();
  TextEditingController telefone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final FocusScopeNode focusScopeNode = FocusScopeNode();
}

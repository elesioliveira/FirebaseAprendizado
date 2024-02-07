import 'package:flutter/material.dart';

class StringListener extends ValueNotifier<String> {
  StringListener(String value) : super(value);

  // Método para atualizar o valor da String
  void updateString(String newValue) {
    value = newValue;
  }
}

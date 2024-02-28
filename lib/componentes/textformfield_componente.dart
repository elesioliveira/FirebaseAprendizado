import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EntradaDeTexto extends StatelessWidget {
  const EntradaDeTexto({
    Key? key,
    this.controller,
    this.keyboardType,
    required this.labelText,
    this.inputFormatters,
    this.validator,
    this.initialValue,
    this.suffixIcon,
    this.temBorda = false,
  }) : super(key: key);

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? labelText;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final String? initialValue;
  final Widget? suffixIcon;
  final bool temBorda;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      validator: validator,
      inputFormatters: inputFormatters,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: temBorda ? const OutlineInputBorder() : null,
        suffixIcon: suffixIcon,
        labelText: labelText,
      ),
    );
  }
}

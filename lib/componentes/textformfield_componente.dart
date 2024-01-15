import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EntradaDeTexto extends StatefulWidget {
  EntradaDeTexto(
      {super.key,
      required this.controller,
      required this.keyboardType,
      required this.labelText,
      this.inputFormatters});
  late TextEditingController? controller;
  TextInputType? keyboardType;
  String? labelText;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<EntradaDeTexto> createState() => _EntradaDeTextoState();
}

class _EntradaDeTextoState extends State<EntradaDeTexto> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: widget.inputFormatters,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        labelText: widget.labelText,
      ),
    );
  }
}

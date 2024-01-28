import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EntradaDeTexto extends StatefulWidget {
  EntradaDeTexto(
      {super.key,
      required this.controller,
      required this.keyboardType,
      required this.labelText,
      this.inputFormatters,
      this.validator,
      this.initialValue});

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? labelText;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  String? initialValue;

  @override
  State<EntradaDeTexto> createState() => _EntradaDeTextoState();
}

class _EntradaDeTextoState extends State<EntradaDeTexto> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        initialValue: widget.initialValue,
        validator: widget.validator,
        inputFormatters: widget.inputFormatters,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          labelText: widget.labelText,
        ),
      ),
    );
  }
}

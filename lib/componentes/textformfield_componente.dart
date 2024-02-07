import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EntradaDeTexto extends StatefulWidget {
  const EntradaDeTexto(
      {super.key,
      this.controller,
      required this.keyboardType,
      required this.labelText,
      this.inputFormatters,
      this.validator,
      this.initialValue,
      this.suffixIcon});

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? labelText;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final String? initialValue;
  final Widget? suffixIcon;

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
          suffixIcon: widget.suffixIcon,
          labelText: widget.labelText,
        ),
      ),
    );
  }
}

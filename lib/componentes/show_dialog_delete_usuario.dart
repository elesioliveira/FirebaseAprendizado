// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:teste_firebase/views/pages/signin_or_signup/controller/controller_login.dart';
import 'package:teste_firebase/views/pages/venda/controller/venda_bloc/controller_cubit.dart';

class MostrarDialog extends StatefulWidget {
  const MostrarDialog({
    Key? key,
    required this.idDoDocumento,
    required this.titulo,
    required this.subTitulo,
  }) : super(key: key);

  final String idDoDocumento;
  final String titulo;
  final String subTitulo;

  @override
  State<MostrarDialog> createState() => _MostrarDialogState();
}

class _MostrarDialogState extends State<MostrarDialog> {
  ControllerLogin vendasRepository = ControllerLogin();
  late final VendaCubit cubit; //começo do get.find()

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<VendaCubit>(context); //seria o Get.find()
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.titulo),
      content: Text(widget.subTitulo),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Fechar o diálogo
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () async {
            // Excluir o documento ao confirmar
            await cubit.deleteSale(
                context: context, idDoDocumento: widget.idDoDocumento);
            cubit.vendas.clear();
            await cubit.fetchDataSell();
          },
          child: const Text('Confirmar'),
        ),
      ],
    );
  }
}

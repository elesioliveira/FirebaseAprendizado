import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:teste_firebase/views/pages/Client/controller/controller/client_cubit.dart';
import 'package:teste_firebase/views/pages/venda/controller/nova_venda_bloc/controller_add_new.dart';

class AutocompleteBasicExample extends StatefulWidget {
  AutocompleteBasicExample({super.key});
  late List<String> nomeDosClientes;

  @override
  State<AutocompleteBasicExample> createState() =>
      _AutocompleteBasicExampleState();
}

class _AutocompleteBasicExampleState extends State<AutocompleteBasicExample> {
  late ClientController clientCubit;
  late List<String> nomeDosClientes;
  AddNewSale controllerNewSale = AddNewSale();

  @override
  void initState() {
    super.initState();
    clientCubit = BlocProvider.of<ClientController>(context);
    clientCubit.fetchClient();
    controllerNewSale = BlocProvider.of<AddNewSale>(context);
  }

  @override
  Widget build(BuildContext context) {
    // Inicializa nomeDosClientes no build
    nomeDosClientes =
        clientCubit.clientes.map((cliente) => cliente.nome).toList();

    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return nomeDosClientes.where((String option) {
          return option.contains(textEditingValue.text.toUpperCase());
        });
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextFormField(
          controller: textEditingController,
          focusNode: focusNode,
          onFieldSubmitted: (String value) {
            onFieldSubmitted();
          },
          decoration: const InputDecoration(
            labelText: 'Cliente',

            // border: OutlineInputBorder(),
          ),
        );
      },
      displayStringForOption: (String option) => option.toUpperCase(),
      onSelected: (String selection) {
        controllerNewSale.cliente.text = selection;
      },
    );
  }
}

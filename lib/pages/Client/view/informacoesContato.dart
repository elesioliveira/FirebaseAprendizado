import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_firebase/componentes/textformfield_componente.dart';
import 'package:teste_firebase/identity/controllers.dart';

import 'package:teste_firebase/pages/Client/controller/bloc/client_cubit.dart';

class MeiosDeContato extends StatefulWidget {
  const MeiosDeContato({super.key});

  @override
  State<MeiosDeContato> createState() => _MeiosDeContatoState();
}

class _MeiosDeContatoState extends State<MeiosDeContato> {
  late final NovoClienteController cubit;
  @override
  void initState() {
    super.initState();
    cubit =
        BlocProvider.of<NovoClienteController>(context); //seria o Get.find()
  }

  @override
  Widget build(BuildContext context) {
    final PagevViewTextControllers controllers = PagevViewTextControllers();
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 0.3),
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: const Center(
                        child: Text(
                      'DADOS PESSOAIS',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      children: [
                        EntradaDeTexto(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              TelefoneInputFormatter()
                            ],
                            controller: cubit.telefone1,
                            keyboardType: TextInputType.name,
                            labelText: 'TELEFONE 1'),
                        EntradaDeTexto(
                            controller: cubit.telefone2,
                            keyboardType: TextInputType.name,
                            labelText: 'TELEFONE 2'),
                        EntradaDeTexto(
                            controller: cubit.email,
                            keyboardType: TextInputType.name,
                            labelText: 'EMAIL'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

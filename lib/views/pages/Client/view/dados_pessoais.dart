import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_firebase/componentes/textformfield_componente.dart';
import 'package:teste_firebase/validadores/validadores.dart';

import 'package:teste_firebase/views/pages/Client/controller/bloc/client_cubit.dart';

import 'package:teste_firebase/views/pages/Client/controller/pageview/controller_page_view.dart';

class DadosPessoais extends StatefulWidget {
  const DadosPessoais({super.key});

  @override
  State<DadosPessoais> createState() => _DadosPessoaisState();
}

class _DadosPessoaisState extends State<DadosPessoais> {
  late PageviewController clienteControllers = PageviewController();

  late final ClientController cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<ClientController>(context); //seria o Get.find()
  }

  @override
  Widget build(BuildContext context) {
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
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Form(
                      key: cubit.dadosPessoaisFormKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          EntradaDeTexto(
                              validator: Validadores.nome,
                              controller: cubit.nome,
                              keyboardType: TextInputType.name,
                              labelText: 'NOME COMPLETO'),
                          EntradaDeTexto(
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                CpfInputFormatter()
                              ],
                              validator: Validadores.cpf,
                              controller: cubit.cpf,
                              keyboardType: TextInputType.name,
                              labelText: 'CPF'),
                          EntradaDeTexto(
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                DataInputFormatter()
                              ],
                              validator: Validadores.data,
                              controller: cubit.dataNascimento,
                              keyboardType: TextInputType.name,
                              labelText: 'DATA NASCIMENTO'),
                        ],
                      ),
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

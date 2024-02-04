import 'package:custom_alert_snackbar/custom_alert_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_cep/search_cep.dart';
import 'package:teste_firebase/componentes/textformfield_componente.dart';
import 'package:teste_firebase/metodos/validadores.dart';

import 'package:teste_firebase/pages/Client/controller/bloc/client_cubit.dart';

class ClienteEndereco extends StatefulWidget {
  const ClienteEndereco({super.key});

  @override
  State<ClienteEndereco> createState() => _ClienteEnderecoState();
}

class _ClienteEnderecoState extends State<ClienteEndereco> {
  late final NovoClienteController cubit;
  final postmonSearchCep = PostmonSearchCep();

  @override
  void initState() {
    super.initState();
    cubit =
        BlocProvider.of<NovoClienteController>(context); //seria o Get.find()
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
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
                          'INFORMAÇÕES DE ENDEREÇO',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Form(
                          key: cubit.enderecoFormKey,
                          child: Column(
                            children: [
                              EntradaDeTexto(
                                  validator: Validadores.nome,
                                  controller: cubit.endereco,
                                  keyboardType: TextInputType.name,
                                  labelText: 'Rua'),
                              EntradaDeTexto(
                                  controller: cubit.numero,
                                  keyboardType: TextInputType.name,
                                  labelText: 'Numero'),
                              EntradaDeTexto(
                                  controller: cubit.bairro,
                                  keyboardType: TextInputType.name,
                                  labelText: 'Bairro'),
                              EntradaDeTexto(
                                  controller: cubit.cidade,
                                  keyboardType: TextInputType.name,
                                  labelText: 'Cidade'),
                              EntradaDeTexto(
                                  controller: cubit.estado,
                                  keyboardType: TextInputType.name,
                                  labelText: 'Estado'),
                              ValueListenableBuilder(
                                valueListenable: cubit.cep,
                                builder: (context, value, child) {
                                  return EntradaDeTexto(
                                      suffixIcon: cubit.cep.text.isEmpty
                                          ? null
                                          : IconButton(
                                              onPressed: () async {
                                                cubit.fetchCep(context,
                                                    cubit.bairro.toString());
                                              },
                                              icon: const Icon(
                                                  Icons.location_searching)),
                                      controller: cubit.cep,
                                      keyboardType: TextInputType.name,
                                      labelText: 'CEP');
                                },
                              ),
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
        ],
      ),
    );
  }
}

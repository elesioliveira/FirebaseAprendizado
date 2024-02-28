import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_firebase/componentes/auto_complete_textfield.dart';

import 'package:teste_firebase/validadores/validadores.dart';
import 'package:teste_firebase/views/pages/base/view/pagina_base.dart';
import 'package:teste_firebase/views/pages/venda/controller/nova_venda_bloc/controller_add_new.dart';
import 'package:teste_firebase/views/pages/venda/controller/nova_venda_bloc/cubit_state.dart';
import 'package:teste_firebase/views/pages/venda/controller/venda_bloc/controller_cubit.dart';
import 'package:teste_firebase/views/pages/venda/model/model_vendas.dart';
import '../../../../componentes/textformfield_componente.dart';

class NovaVenda extends StatefulWidget {
  const NovaVenda({super.key});

  @override
  State<NovaVenda> createState() => _NovaVendaState();
}

class _NovaVendaState extends State<NovaVenda> {
  TextEditingController numeroVenda = TextEditingController();
  TextEditingController cpf = TextEditingController();

  TextEditingController vendedor = TextEditingController();
  TextEditingController dataVenda = TextEditingController();
  TextEditingController valor = TextEditingController();
  TextEditingController entregarAte = TextEditingController();
  TextEditingController produto = TextEditingController();
  late AddNewSale controllerNewSale;
  late VendaCubit controllerSale;

  @override
  void initState() {
    super.initState();

    controllerNewSale = BlocProvider.of<AddNewSale>(context);
    controllerSale = BlocProvider.of<VendaCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.deepPurple,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(15)),
              ),
              child: const Center(
                  child: Text(
                'Nova venda',
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                    color: Colors.white),
              )),
            ),
            BlocBuilder(
                bloc: controllerNewSale,
                builder: (context, state) {
                  if (state is StateInitialAdd) {
                    return Container(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 25,
                            ),
                            EntradaDeTexto(
                              validator: Validadores.numeroVenda,
                              controller: numeroVenda,
                              keyboardType: TextInputType.number,
                              labelText: 'Numero Venda',
                            ),
                            EntradaDeTexto(
                              validator: Validadores.cpf,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                CpfInputFormatter(),
                              ],
                              controller: cpf,
                              keyboardType: TextInputType.number,
                              labelText: 'CPF',
                            ),
                            AutocompleteBasicExample(),
                            EntradaDeTexto(
                              validator: Validadores.vendedor,
                              controller: vendedor,
                              keyboardType: TextInputType.text,
                              labelText: 'Vendedor',
                            ),
                            EntradaDeTexto(
                              validator: Validadores.data,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                DataInputFormatter(),
                              ],
                              controller: dataVenda,
                              keyboardType: TextInputType.datetime,
                              labelText: 'Data Venda',
                            ),
                            EntradaDeTexto(
                              validator: Validadores.produto,
                              controller: produto,
                              keyboardType: TextInputType.text,
                              labelText: 'Produto',
                            ),
                            EntradaDeTexto(
                              validator: Validadores.valor,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                CentavosInputFormatter()
                              ],
                              controller: valor,
                              keyboardType: TextInputType.datetime,
                              labelText: 'Valor',
                            ),
                            EntradaDeTexto(
                              validator: Validadores.data,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                DataInputFormatter(),
                              ],
                              controller: entregarAte,
                              keyboardType: TextInputType.datetime,
                              labelText: 'Entregar Até',
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: Colors.transparent,
                                        border: Border.all(
                                            width: 1, color: Colors.deepPurple),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: const Text(
                                      'Cancelar',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    if (formKey.currentState!.validate()) {
                                      final venda = Venda(
                                          cliente:
                                              controllerNewSale.cliente.text,
                                          cpf: cpf.text,
                                          dataVenda: dataVenda.text,
                                          entregarAte: entregarAte.text,
                                          numeroVenda: numeroVenda.text,
                                          produto: produto.text,
                                          valor: valor.text,
                                          vendedor: vendedor.text);
                                      await controllerNewSale.addNewSale(
                                          context: context,
                                          venda: venda,
                                          vendas: controllerSale.vendas);
                                      controllerSale.vendas.clear();
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const BaseScreen()),
                                      );
                                      // await controllerSale.fetchDataSell();
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: Colors.deepPurple,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: const Text(
                                      'Salvar',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  if (state is LoadingState) {
                    return SizedBox(
                      height: MediaQuery.sizeOf(context).height,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return SizedBox(
                      height: MediaQuery.sizeOf(context).height,
                      child: const Center(
                        child: Text('Algo deu errado'),
                      ),
                    );
                  }
                })
          ],
        ),
      ),
    ));
  }
}

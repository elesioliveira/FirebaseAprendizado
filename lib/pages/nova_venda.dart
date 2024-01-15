import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_firebase/blocs/venda_cubit.dart';
import '../componentes/textformfield_componente.dart';
import '../repository/repository_vendas.dart';

class NovaVenda extends StatefulWidget {
  const NovaVenda({super.key});

  @override
  State<NovaVenda> createState() => _NovaVendaState();
}

class _NovaVendaState extends State<NovaVenda> {
  TextEditingController numeroVenda = TextEditingController();
  TextEditingController cpf = TextEditingController();
  TextEditingController cliente = TextEditingController();
  TextEditingController vendedor = TextEditingController();
  TextEditingController dataVenda = TextEditingController();
  TextEditingController valor = TextEditingController();
  TextEditingController entregarAte = TextEditingController();
  TextEditingController produto = TextEditingController();
  late final VendaCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<VendaCubit>(context); //seria o Get.find()
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    VendasRepository vendasRepository = VendasRepository();

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
                    BorderRadius.vertical(bottom: Radius.circular(50)),
              ),
              child: const Center(
                  child: Text(
                'Nova venda',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white54),
              )),
            ),
            Container(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  EntradaDeTexto(
                    controller: numeroVenda,
                    keyboardType: TextInputType.number,
                    labelText: 'Numero Venda',
                  ),
                  EntradaDeTexto(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CpfInputFormatter(),
                    ],
                    controller: cpf,
                    keyboardType: TextInputType.number,
                    labelText: 'CPF',
                  ),
                  EntradaDeTexto(
                    controller: cliente,
                    keyboardType: TextInputType.text,
                    labelText: 'Cliente',
                  ),
                  EntradaDeTexto(
                    controller: vendedor,
                    keyboardType: TextInputType.text,
                    labelText: 'Vendedor',
                  ),
                  EntradaDeTexto(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      DataInputFormatter(),
                    ],
                    controller: dataVenda,
                    keyboardType: TextInputType.datetime,
                    labelText: 'Data Venda',
                  ),
                  EntradaDeTexto(
                    controller: produto,
                    keyboardType: TextInputType.text,
                    labelText: 'Produto',
                  ),
                  EntradaDeTexto(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CentavosInputFormatter()
                    ],
                    controller: valor,
                    keyboardType: TextInputType.datetime,
                    labelText: 'Valor',
                  ),
                  EntradaDeTexto(
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
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20)),
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
                          //NOVA VENDA AQUI
                          await vendasRepository.adicionarNovaVenda(
                              context: context,
                              numeroVenda: numeroVenda.text,
                              cpf: cpf.text,
                              cliente: cliente.text,
                              vendedor: vendedor.text,
                              dataVenda: dataVenda.text,
                              valor: valor.text,
                              produto: produto.text,
                              entregarAte: entregarAte.text);
                          await cubit.getData();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(20)),
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
          ],
        ),
      ),
    ));
  }
}

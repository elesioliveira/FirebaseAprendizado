import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_firebase/blocs/venda/venda_cubit.dart';
import 'package:teste_firebase/componentes/textformfield_componente.dart';
import 'package:teste_firebase/metodos/validadores.dart';
import 'package:teste_firebase/model/model_vendas.dart';

class AtualizarVendaPage extends StatefulWidget {
  const AtualizarVendaPage({super.key, required this.venda});

  final Venda venda;

  @override
  State<AtualizarVendaPage> createState() => _AtualizarVendaPageState();
}

class _AtualizarVendaPageState extends State<AtualizarVendaPage> {
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
    // Preencher os controladores com os valores da venda
    numeroVenda.text = widget.venda.numeroVenda;
    cpf.text = widget.venda.cpf;
    cliente.text = widget.venda.cliente;
    vendedor.text = widget.venda.vendedor;
    dataVenda.text = widget.venda.dataVenda;
    valor.text = widget.venda.valor;
    entregarAte.text = widget.venda.entregarAte;
    produto.text = widget.venda.produto;
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
                'Atualizar venda',
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                    color: Colors.white),
              )),
            ),
            Container(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Form(
                key: formKey,
                child: Column(
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
                    EntradaDeTexto(
                      validator: Validadores.nome,
                      controller: cliente,
                      keyboardType: TextInputType.text,
                      labelText: 'Cliente',
                    ),
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
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.transparent,
                                border: Border.all(
                                    width: 1, color: Colors.deepPurple),
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
                            if (formKey.currentState!.validate()) {
                              await cubit.atualizarVenda(
                                  venda: cubit.vendas,
                                  context: context,
                                  numeroVenda: numeroVenda.text,
                                  cpf: cpf.text,
                                  cliente: cliente.text,
                                  vendedor: vendedor.text,
                                  dataVenda: dataVenda.text,
                                  valor: valor.text,
                                  produto: produto.text,
                                  entregarAte: entregarAte.text);
                              cubit.vendas.clear();
                              await cubit.getData();
                            }
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
            ),
          ],
        ),
      ),
    ));
  }
}

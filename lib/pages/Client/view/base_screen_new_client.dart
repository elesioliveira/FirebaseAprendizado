import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_firebase/identity/controllers.dart';
import 'package:teste_firebase/pages/Client/controller/bloc/client_cubit.dart';
import 'package:teste_firebase/pages/Client/controller/controller_page_view.dart';
import 'package:teste_firebase/pages/Client/model/novo_cliente_model.dart';
import 'package:teste_firebase/pages/Client/view/dados_pessoais.dart';
import 'package:teste_firebase/pages/Client/view/endereco.dart';
import 'package:teste_firebase/pages/Client/view/informacoesContato.dart';

class NovoCliente extends StatefulWidget {
  NovoCliente({Key? key}) : super(key: key);
  final PagevViewTextControllers controllers = PagevViewTextControllers();
  @override
  State<NovoCliente> createState() => _NovoClienteState();
}

class _NovoClienteState extends State<NovoCliente> {
  final PageviewController clienteController = PageviewController();
  late final NovoClienteController cubit;

  @override
  void initState() {
    super.initState();
    cubit =
        BlocProvider.of<NovoClienteController>(context); //seria o Get.find()
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close))
          ],
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Novo cliente'),
        ),
        body: Stack(
          children: [
            PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: clienteController.pageController,
              children: const [
                DadosPessoais(),
                ClienteEndereco(),
                MeiosDeContato(),
              ],
            ),
            AnimatedBuilder(
                animation: clienteController,
                builder: (context, _) {
                  return Positioned(
                    bottom: 15,
                    right: 10,
                    child: clienteController.currentIndex < 2
                        ? ElevatedButton(
                            onPressed: () {
                              // if (clienteController.currentIndex <= 2) {
                              //   return;
                              // }
                              if (clienteController.currentIndex == 0) {
                                if (cubit.dadosPessoaisFormKey.currentState!
                                    .validate()) {
                                  clienteController.incrementarValor();
                                  return;
                                }
                              }
                              if (clienteController.currentIndex == 1) {
                                if (cubit.enderecoFormKey.currentState!
                                    .validate()) {
                                  clienteController.incrementarValor();
                                  return;
                                }
                              }
                            },
                            child: const Text('Próximo'),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              final client = Client(
                                  nome: cubit.nome.text,
                                  cpf: cubit.cpf.text,
                                  dataNascimento: cubit.dataNascimento.text,
                                  endereco: cubit.endereco.text,
                                  numero: cubit.numero.text,
                                  bairro: cubit.bairro.text,
                                  cidade: cubit.cidade.text,
                                  estado: cubit.estado.text,
                                  email: cubit.email.text,
                                  numeroResindencia: cubit.numero.text,
                                  telefone1: cubit.telefone1.text,
                                  telefone2: cubit.telefone2.text,
                                  cep: cubit.cep.text);

                              cubit.addNewClient(
                                  client, cubit.clients, context);
                            },
                            child: const Text('Finalizar'),
                          ),
                  );
                })
          ],
        ),
        bottomNavigationBar: AnimatedBuilder(
          animation: clienteController,
          builder: (context, _) {
            return BottomNavigationBar(
              onTap: (index) {
                if (clienteController.currentIndex == 2) {
                  clienteController.navigatePageView(index);
                  return;
                }
                if (clienteController.currentIndex == 0) {
                  if (cubit.dadosPessoaisFormKey.currentState!.validate()) {
                    clienteController.incrementarValor();
                    clienteController.navigatePageView(index);
                    return;
                  }
                }
                if (clienteController.currentIndex == 1) {
                  if (cubit.enderecoFormKey.currentState!.validate()) {
                    clienteController.incrementarValor();
                    clienteController.navigatePageView(index);
                    return;
                  }
                }
              },
              backgroundColor: Theme.of(context).primaryColor,
              selectedItemColor: Colors.white.withAlpha(100),
              unselectedItemColor: Colors.black,
              type: BottomNavigationBarType.fixed,
              currentIndex: clienteController.currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.5),
                        shape: BoxShape.circle,
                        color: clienteController.currentIndex == 0
                            ? Colors.white54
                            : Colors.transparent),
                  ),
                  label: 'Documento',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.5),
                        shape: BoxShape.circle,
                        color: clienteController.currentIndex == 1
                            ? Colors.white54
                            : Colors.transparent),
                  ),
                  label: 'Endereço',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.5),
                        shape: BoxShape.circle,
                        color: clienteController.currentIndex == 2
                            ? Colors.white54
                            : Colors.transparent),
                  ),
                  label: 'Contato',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

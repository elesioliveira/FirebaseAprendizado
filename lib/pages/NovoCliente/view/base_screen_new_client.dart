import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_firebase/identity/controllers.dart';
import 'package:teste_firebase/pages/NovoCliente/controller/bloc/novo_cliente_cubit.dart';
import 'package:teste_firebase/pages/NovoCliente/controller/controller_cliente.dart';
import 'package:teste_firebase/pages/NovoCliente/view/dados_pessoais.dart';
import 'package:teste_firebase/pages/NovoCliente/view/endereco.dart';
import 'package:teste_firebase/pages/NovoCliente/view/informacoesContato.dart';

class NovoCliente extends StatefulWidget {
  NovoCliente({Key? key}) : super(key: key);
  final PagevViewTextControllers controllers = PagevViewTextControllers();
  @override
  State<NovoCliente> createState() => _NovoClienteState();
}

class _NovoClienteState extends State<NovoCliente> {
  final PageviewController clienteController = PageviewController();
  late final EstadoControllersText cubit;

  @override
  void initState() {
    super.initState();
    cubit =
        BlocProvider.of<EstadoControllersText>(context); //seria o Get.find()
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
                                  print('deu certo');
                                  clienteController.incrementarValor();
                                  return;
                                }
                              }
                              if (clienteController.currentIndex == 1) {
                                if (cubit.enderecoFormKey.currentState!
                                    .validate()) {
                                  print('deu certo');
                                  clienteController.incrementarValor();
                                  return;
                                }
                              }
                            },
                            child: const Text('Próximo'),
                          )
                        : ElevatedButton(
                            onPressed: () {},
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
                    print('deu certo');
                    clienteController.incrementarValor();
                    clienteController.navigatePageView(index);
                    return;
                  }
                }
                if (clienteController.currentIndex == 1) {
                  if (cubit.enderecoFormKey.currentState!.validate()) {
                    print('deu certo');
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

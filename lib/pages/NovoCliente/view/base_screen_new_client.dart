import 'package:flutter/material.dart';
import 'package:teste_firebase/identity/controllers.dart';
import 'package:teste_firebase/pages/NovoCliente/controller/controller_cliente.dart';
import 'package:teste_firebase/pages/NovoCliente/view/dadosPessoais.dart';
import 'package:teste_firebase/pages/NovoCliente/view/endereco.dart';
import 'package:teste_firebase/pages/NovoCliente/view/informacoesContato.dart';

class NovoCliente extends StatefulWidget {
  NovoCliente({Key? key}) : super(key: key);
  final ControllersText controllers = ControllersText();
  @override
  State<NovoCliente> createState() => _NovoClienteState();
}

class _NovoClienteState extends State<NovoCliente> {
  final ControllerNovoCliente clienteController = ControllerNovoCliente();
  final ControllersText controllers = ControllersText();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.close))
          ],
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Novo cliente'),
        ),
        body: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          child: Center(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: clienteController.pageController,
              children: [
                const DadosPessoais(),
                ClienteEndereco(),
                const MeiosDeContato(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: AnimatedBuilder(
            animation: clienteController,
            builder: (context, _) {
              return BottomNavigationBar(
                  onTap: (index) {
                    clienteController.navigatePageView(index);
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
                  ]);
            }),
      ),
    );
  }
}

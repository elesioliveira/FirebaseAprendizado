import 'package:flutter/material.dart';
import 'package:teste_firebase/componentes/textformfield_componente.dart';
import 'package:teste_firebase/identity/controllers.dart';
import 'package:teste_firebase/pages/NovoCliente/controller/controller_cliente.dart';

class DadosPessoais extends StatefulWidget {
  const DadosPessoais({super.key});

  @override
  State<DadosPessoais> createState() => _DadosPessoaisState();
}

class _DadosPessoaisState extends State<DadosPessoais> {
  final ControllersText controllers = ControllersText();
  late ControllerNovoCliente clienteControllers = ControllerNovoCliente();

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
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        EntradaDeTexto(
                            controller: controllers.nomeTextEditController,
                            keyboardType: TextInputType.name,
                            labelText: 'NOME'),
                        EntradaDeTexto(
                            controller: controllers.nomeTextEditController,
                            keyboardType: TextInputType.name,
                            labelText: 'SOBRENOME'),
                        EntradaDeTexto(
                            controller: controllers.nomeTextEditController,
                            keyboardType: TextInputType.name,
                            labelText: 'CPF'),
                        EntradaDeTexto(
                            controller: controllers.nomeTextEditController,
                            keyboardType: TextInputType.name,
                            labelText: 'RG'),
                        EntradaDeTexto(
                            controller: controllers.nomeTextEditController,
                            keyboardType: TextInputType.name,
                            labelText: 'DATA NASCIMENTO'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

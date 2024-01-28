import 'package:flutter/material.dart';
import 'package:teste_firebase/componentes/textformfield_componente.dart';
import 'package:teste_firebase/identity/controllers.dart';

class ClienteEndereco extends StatelessWidget {
  ClienteEndereco({super.key});
  final ControllersText controllers = ControllersText();

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
                      'INFORMAÇÕES DE ENDEREÇO',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      children: [
                        EntradaDeTexto(
                            controller: controllers.nomeTextEditController,
                            keyboardType: TextInputType.name,
                            labelText: 'Rua'),
                        EntradaDeTexto(
                            controller: controllers.nomeTextEditController,
                            keyboardType: TextInputType.name,
                            labelText: 'Numero'),
                        EntradaDeTexto(
                            controller: controllers.nomeTextEditController,
                            keyboardType: TextInputType.name,
                            labelText: 'Bairro'),
                        EntradaDeTexto(
                            controller: controllers.nomeTextEditController,
                            keyboardType: TextInputType.name,
                            labelText: 'Cidade'),
                        EntradaDeTexto(
                            controller: controllers.nomeTextEditController,
                            keyboardType: TextInputType.name,
                            labelText: 'Estado'),
                        EntradaDeTexto(
                            controller: controllers.nomeTextEditController,
                            keyboardType: TextInputType.name,
                            labelText: 'CEP'),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text('Voltar'),
            ),
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

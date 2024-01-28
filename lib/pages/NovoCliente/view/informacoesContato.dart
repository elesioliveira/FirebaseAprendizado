import 'package:flutter/material.dart';
import 'package:teste_firebase/componentes/textformfield_componente.dart';
import 'package:teste_firebase/identity/controllers.dart';

class MeiosDeContato extends StatelessWidget {
  const MeiosDeContato({super.key});

  @override
  Widget build(BuildContext context) {
    final ControllersText controllers = ControllersText();
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
                mainAxisSize: MainAxisSize.min,
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
                    )),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      children: [
                        EntradaDeTexto(
                            controller: controllers.nomeTextEditController,
                            keyboardType: TextInputType.name,
                            labelText: 'TELEFONE 1'),
                        EntradaDeTexto(
                            controller: controllers.nomeTextEditController,
                            keyboardType: TextInputType.name,
                            labelText: 'TELEFONE 2'),
                        EntradaDeTexto(
                            controller: controllers.nomeTextEditController,
                            keyboardType: TextInputType.name,
                            labelText: 'EMAIL'),
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
              child: const Text('Finalizar'),
            ),
          ],
        ),
      ),
    );
  }
}

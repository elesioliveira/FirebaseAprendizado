import 'dart:math';

import 'package:flutter/material.dart';
import 'package:teste_firebase/componentes/show_dialog_delete_usuario.dart';
import 'package:teste_firebase/pages/venda/page/atualizar_venda.dart';

import '../pages/venda/model/model_vendas.dart';

class OrdemDeVenda extends StatefulWidget {
  const OrdemDeVenda({
    super.key,
    required this.idExclusao,
    required this.cliente,
    required this.produto,
    required this.valor,
    required this.primeiraLetraNome,
    required this.vendas, // Adicionando a lista de vendas
    required this.index, // Adicionando o índice da venda
  });
  final String idExclusao;
  final String cliente;
  final String produto;
  final String valor;
  final String primeiraLetraNome;
  final List<Venda> vendas; // Lista de vendas
  final int index; // Índice da venda clicada

  @override
  State<OrdemDeVenda> createState() => _OrdemDeVendaState();
}

class _OrdemDeVendaState extends State<OrdemDeVenda> {
  Color randomColor() {
    // Gere uma cor aleatória com valores RGB
    return Color.fromARGB(
      50,
      Random().nextInt(256),
      Random().nextInt(256),
      Random().nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        decoration: BoxDecoration(
          color: randomColor(),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
        // width: MediaQuery.sizeOf(context).width * 1,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: randomColor()),
              child: Text(
                widget.primeiraLetraNome,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    overflow: TextOverflow.ellipsis,
                    widget.cliente,
                    maxLines: 1,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              overflow: TextOverflow.clip,
                              maxLines: 2,
                              'Produto: ${widget.produto}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 12),
                            ),
                            Text('Valor: ${widget.valor}')
                          ],
                        ),
                      ),
                      const SizedBox(width: 15),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    // width: MediaQuery.sizeOf(context).width / 10,
                    child: IconButton(
                      color: Colors.grey,
                      onPressed: () {
                        // await mostrarDialogoExclusao(context, widget.idExclusao);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return MostrarDialog(
                              idDoDocumento: widget.idExclusao,
                              titulo: 'Confirmar',
                              subTitulo:
                                  'Você realmente deseja excluir este documento?',
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ),

                  SizedBox(
                    // width: MediaQuery.sizeOf(context).width / 10,
                    child: IconButton(
                      color: Colors.grey,
                      onPressed: () {
                        // Navegar para a segunda página
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AtualizarVendaPage(
                                venda: widget.vendas[widget.index]),
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                  ),
                  // const SizedBox(width: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

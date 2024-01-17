import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_firebase/blocs/venda/venda_cubit.dart';
import 'package:teste_firebase/blocs/venda/venda_state.dart';

import 'package:teste_firebase/componentes/ordem_de_venda.dart';

import 'package:teste_firebase/pages/nova_venda.dart';

class PaginaBase extends StatefulWidget {
  const PaginaBase({super.key});

  @override
  State<PaginaBase> createState() => PaginaBaseState();
}

class PaginaBaseState extends State<PaginaBase> {
  late final VendaCubit cubit; //começo do get.find()

  @override
  initState() {
    super.initState();
    cubit = BlocProvider.of<VendaCubit>(context); //seria o Get.find()
    cubit.getData();
    cubit.stream.listen((event) {
      if (event is ErrorEstadoVenda) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(event.mensagem),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.only(left: 4, right: 4, top: 10, bottom: 10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: 'Pesquisar..',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.search))),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: BlocBuilder(
                  bloc: cubit,
                  builder: (context, state) {
                    if (state is EstadoInicialVenda) {
                      return const Center(
                        child: Text('Nenhuma venda informada'),
                      );
                    } else if (state is CarregandoVenda) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is VendaCarregada) {
                      return ListView.builder(
                        itemCount: state.vendas.length,
                        itemBuilder: (context, index) {
                          // Exibir os dados em um widget (substitua pelo seu widget personalizado)
                          return OrdemDeVenda(
                            primeiraLetraNome:
                                state.vendas[index].cliente[0].toUpperCase(),
                            idExclusao: state.vendas[index].numeroVenda,
                            cliente: state.vendas[index].cliente.toUpperCase(),
                            produto: state.vendas[index].produto,
                            valor: state.vendas[index].valor,
                            index: index,
                            vendas: state.vendas,
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Column(
                          children: [
                            Icon(Icons.error),
                            Text('Erro com a lista')
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          color: Colors.deepPurple,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          color: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NovaVenda()),
            );
          },
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }
}

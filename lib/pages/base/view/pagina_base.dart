import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_firebase/pages/venda/blocs/venda/venda_cubit.dart';
import 'package:teste_firebase/pages/venda/blocs/venda/venda_state.dart';
import 'package:teste_firebase/componentes/drawer_options.dart';

import 'package:teste_firebase/componentes/ordem_de_venda.dart';
import 'package:teste_firebase/pages/Client/view/base_screen_new_client.dart';

import 'package:teste_firebase/pages/venda/page/nova_venda.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => BaseScreenState();
}

class BaseScreenState extends State<BaseScreen> {
  late final VendaCubit cubit; //começo do get.find()

  NotificarTextFormField atualizarTextFormField = NotificarTextFormField();
  late String value;

  @override
  initState() {
    super.initState();
    cubit = BlocProvider.of<VendaCubit>(context); //seria o Get.find()
    value = atualizarTextFormField.filtrarVendas.text;
    cubit.buscarVendas();
    atualizarTextFormField.atualizarTextFormField(value);
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
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Lista de Vendas'),
        ),
        body: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.only(left: 4, right: 4, top: 10, bottom: 10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: ValueListenableBuilder(
                valueListenable: atualizarTextFormField.filtrarVendas,
                builder: (context, valor, child) {
                  return TextFormField(
                    onChanged: (value) {
                      value = value;
                    },
                    textAlign: TextAlign.start,
                    // onChanged: (value) {},
                    controller: atualizarTextFormField.filtrarVendas,
                    decoration: InputDecoration(
                      hintText: 'Pesquisar..',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      suffixIcon:
                          atualizarTextFormField.filtrarVendas.text.isEmpty
                              ? null
                              : Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          cubit.vendas.clear();
                                          await cubit.filtrarVendas(
                                              cliente: atualizarTextFormField
                                                  .filtrarVendas.text
                                                  .toUpperCase());
                                        },
                                        icon: const Icon(Icons.search),
                                      ),
                                      IconButton(
                                          onPressed: () async {
                                            atualizarTextFormField
                                                .filtrarVendas.text = '';
                                            cubit.vendas.clear();
                                            await cubit.buscarVendas();
                                          },
                                          icon: const Icon(Icons.close))
                                    ],
                                  ),
                                ),
                    ),
                  );
                },
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
                      return RefreshIndicator(
                        onRefresh: () async {
                          cubit.vendas.clear();
                          await cubit.buscarVendas();
                        },
                        child: ListView.builder(
                          itemCount: state.vendas.length,
                          itemBuilder: (context, index) {
                            // retornando valores do data firebase
                            return OrdemDeVenda(
                              primeiraLetraNome:
                                  state.vendas[index].cliente[0].toUpperCase(),
                              idExclusao: state.vendas[index].numeroVenda,
                              cliente:
                                  state.vendas[index].cliente.toUpperCase(),
                              produto: state.vendas[index].produto,
                              valor: state.vendas[index].valor,
                              index: index,
                              vendas: state.vendas,
                            );
                          },
                        ),
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
        floatingActionButton: Container(
          decoration: const BoxDecoration(
            color: Colors.deepPurple,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            color: Colors.white,
            onPressed: () {
              atualizarTextFormField.filtrarVendas.text = '';
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NovaVenda()),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              Material(
                color: Theme.of(context).primaryColor,
                child: InkWell(
                  onTap: () {
                    /// Close Navigation drawer before
                    Navigator.pop(context);
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfile()),);
                  },
                  child: Container(
                    width: MediaQuery.sizeOf(context).width,
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top, bottom: 24),
                    child: const Column(
                      children: [
                        CircleAvatar(
                          radius: 52,
                          backgroundImage: NetworkImage(
                              'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fHNtaWx5JTIwZmFjZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60'),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Sua empresa aqui',
                          style: TextStyle(fontSize: 28, color: Colors.white),
                        ),
                        Text(
                          'Commerce',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ExpansionTile(
                textColor: Theme.of(context).primaryColor,
                title: const Text('Cadastro'),
                // Adicione o conteúdo que será exibido quando o ExpansionTile estiver expandido.
                children: [
                  DrawerOptions(
                    title: 'Clientes',
                    trailing: const Icon(Icons.person),
                    proximaTela: NovoCliente(),
                  ),
                ],
              ),
              ExpansionTile(
                textColor: Theme.of(context).primaryColor,
                title: const Text('Vendas'),
                // Adicione o conteúdo que será exibido quando o ExpansionTile estiver expandido.
                children: const [
                  ListTile(
                    title: Text('Vendas por periodo'),
                  ),
                  ListTile(
                    title: Text('Venda total no dia'),
                  ),
                  ListTile(
                    title: Text('Venda por vendedor'),
                  ),
                ],
              ),
              // Adicione mais ExpansionTiles ou outros widgets conforme necessário.
            ],
          ),
        ),
      ),
    );
  }
}

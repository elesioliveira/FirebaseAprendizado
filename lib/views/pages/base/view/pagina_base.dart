import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:teste_firebase/componentes/drawer_options.dart';
import 'package:teste_firebase/componentes/ordem_de_venda.dart';
import 'package:teste_firebase/views/pages/Client/controller/controller/client_cubit.dart';
import 'package:teste_firebase/views/pages/Client/view/base_screen_new_client.dart';
import 'package:teste_firebase/views/pages/base/controller/controller_base_screen.dart';

import 'package:teste_firebase/views/pages/filtro_por_periodo/view/screen_page_filter.dart';
import 'package:teste_firebase/views/pages/venda/controller/venda_bloc/controller_cubit.dart';
import 'package:teste_firebase/views/pages/venda/controller/venda_bloc/cubit_state.dart';

import 'package:teste_firebase/views/pages/venda/page/nova_venda.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => BaseScreenState();
}

class BaseScreenState extends State<BaseScreen> {
  late VendaCubit cubit;
  late ClientController clientCubit;
  late List<String> nomeDosClientes;
  final BaseController baseController = BaseController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String searchTitle = '';

  @override
  initState() {
    super.initState();
    cubit = BlocProvider.of<VendaCubit>(context);
    clientCubit = BlocProvider.of<ClientController>(context);
    clientCubit.fetchClient();
    cubit.fetchDataSell();
    cubit.stream.listen((event) {
      if (event is ErrorEstadoVenda) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(event.mensagem)),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          centerTitle: true,
          title: const Text('Lista de Vendas'),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: AnimatedBuilder(
                animation: baseController.searchController,
                builder: (context, snapshot) {
                  return Material(
                    shape: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0.1),
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 3.5,
                    child: TextFormField(
                      controller: baseController.searchController,
                      onChanged: (value) {
                        baseController.searchController.text = value;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        isDense: true,
                        hintText: 'Pesquise aqui...',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 14,
                        ),
                        suffixIcon:
                            baseController.searchController.text.isNotEmpty
                                ? IconButton(
                                    onPressed: () {
                                      baseController.limparSearchTitle();
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      size: 21,
                                    ),
                                  )
                                : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
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
                          await cubit.fetchDataSell();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: ListView.separated(
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 5,
                              );
                            },
                            itemCount: state.vendas.length,
                            itemBuilder: (context, index) {
                              // retornando valores do data firebase
                              return OrdemDeVenda(
                                primeiraLetraNome: state
                                    .vendas[index].cliente[0]
                                    .toUpperCase(),
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
                        ),
                      );
                    } else {
                      return Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  cubit.fetchDataSell;
                                },
                                child: const Icon(Icons.error)),
                            const Text('Erro com a lista')
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
        floatingActionButton: Card(
          elevation: 0.2,
          child: Container(
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
                  DescriptionTileOnDrawer(
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
                  DescriptionTileOnDrawer(
                    title: 'Venda detalhada',
                    proximaTela: ScreenFilterPage(),
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

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_firebase/componentes/appbar_widget.dart';
import 'package:teste_firebase/componentes/buttom_accept_or_no.dart';
import 'package:teste_firebase/componentes/textformfield_componente.dart';
import 'package:teste_firebase/validadores/validadores.dart';
import 'package:teste_firebase/views/pages/filtro_por_periodo/controller/filtro_cubit.dart';
import 'package:teste_firebase/views/pages/filtro_por_periodo/controller/filtro_state.dart';
import 'package:teste_firebase/views/pages/filtro_por_periodo/view/screen_relatorio_carregado.dart';

class ScreenFilterPage extends StatefulWidget {
  const ScreenFilterPage({super.key});

  @override
  State<ScreenFilterPage> createState() => _ScreenFilterPageState();
}

class _ScreenFilterPageState extends State<ScreenFilterPage> {
  late FilterSaleToDate cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<FilterSaleToDate>(context);
    cubit.stream.listen((event) {
      if (event is StateErrorFilterDate) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(event.errorMensagem)),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> carregandoRelatorio = ValueNotifier<bool>(false);
    double heightSize = MediaQuery.sizeOf(context).height;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            AppBarWidget(
                title: 'Relatorio',
                onPressed: () {
                  cubit.limparTextEditingControllers();
                  Navigator.of(context).pop();
                }),
            SizedBox(
              height: heightSize * 0.15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.only(
                    left: 10, right: 10, bottom: 15, top: 15),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      EntradaDeTexto(
                        controller: cubit.cliente,
                        validator: Validadores.nome,
                        labelText: 'cliente',
                        temBorda: true,
                      ),
                      SizedBox(
                        height: heightSize * 0.02,
                      ),
                      EntradaDeTexto(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CpfInputFormatter(),
                        ],
                        controller: cubit.cpf,
                        validator: Validadores.cpf,
                        labelText: 'cpf',
                        temBorda: true,
                      ),
                      SizedBox(
                        height: heightSize * 0.02,
                      ),
                      EntradaDeTexto(
                        controller: cubit.vendedor,
                        validator: Validadores.vendedor,
                        labelText: 'vendedor',
                        temBorda: true,
                      ),
                      SizedBox(
                        height: heightSize * 0.02,
                      ),
                      EntradaDeTexto(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          DataInputFormatter(),
                        ],
                        controller: cubit.data,
                        validator: Validadores.data,
                        labelText: 'data',
                        temBorda: true,
                      ),
                      SizedBox(
                        height: heightSize * 0.02,
                      ),
                      ListenableBuilder(
                          listenable: carregandoRelatorio,
                          builder: (context, snapshot) {
                            return ButtonIntoRow(
                              estaCarregando: carregandoRelatorio.value,
                              accepet: carregandoRelatorio.value ? '' : 'Gerar',
                              negation: 'Voltar',
                              onTapAccept: carregandoRelatorio.value
                                  ? null
                                  : () async {
                                      carregandoRelatorio.value =
                                          !carregandoRelatorio.value;
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      cubit.vendas.clear();

                                      await cubit.fetchSaleFilter(
                                          cpf: cubit.cpf.text,
                                          dataVenda:
                                              cubit.data.text.toUpperCase(),
                                          cliente:
                                              cubit.cliente.text.toUpperCase(),
                                          vendedor: cubit.vendedor.text
                                              .toUpperCase());
                                      carregandoRelatorio.value =
                                          !carregandoRelatorio.value;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ScreenRelatorioCarregado(),
                                        ),
                                      );
                                    },
                              onTapNegation: () {},
                            );
                          })
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

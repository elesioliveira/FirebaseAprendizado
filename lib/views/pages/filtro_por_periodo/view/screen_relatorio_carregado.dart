import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_firebase/views/pages/filtro_por_periodo/controller/filtro_cubit.dart';
import 'package:screenshot/screenshot.dart';
import '../../../../componentes/appbar_widget.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class ScreenRelatorioCarregado extends StatefulWidget {
  const ScreenRelatorioCarregado({super.key});

  @override
  State<ScreenRelatorioCarregado> createState() =>
      _ScreenRelatorioCarregadoState();
}

class _ScreenRelatorioCarregadoState extends State<ScreenRelatorioCarregado> {
  late FilterSaleToDate cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<FilterSaleToDate>(context);
  }

  @override
  Widget build(BuildContext context) {
    double heightSize = MediaQuery.sizeOf(context).height;
    final ScreenshotController screenshotController = ScreenshotController();
    ValueNotifier<bool> carregandoRelatorio = ValueNotifier<bool>(false);
    Uint8List? capturedImage;
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppBarWidget(
                title: 'Relatorio carregado',
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            Expanded(
              child: Screenshot(
                controller: screenshotController,
                child: Container(
                  color: Colors.white,
                  child: ListView.separated(
                    itemCount: cubit.vendas.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: heightSize * 0.003,
                      );
                    },
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text(
                              'Cliente: ${cubit.vendas[index].cliente.toUpperCase()}',
                              style: const TextStyle(color: Colors.black),
                              softWrap: true,
                            ),
                            subtitle: Text(
                              'Produto: ${cubit.vendas[index].produto.toUpperCase()}',
                              style: const TextStyle(color: Colors.black),
                            ),
                            trailing: Text(
                              'Data da venda: ${cubit.vendas[index].dataVenda.toUpperCase()}',
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                          const Divider()
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: ListenableBuilder(
            listenable: carregandoRelatorio,
            builder: (context, snapshot) {
              return ElevatedButton.icon(
                  onPressed: carregandoRelatorio.value
                      ? null
                      : () async {
                          carregandoRelatorio.value =
                              !carregandoRelatorio.value;
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                surfaceTintColor: Colors.transparent,
                                backgroundColor: Colors
                                    .transparent, // Define a cor do fundo como transparente
                                child: Container(
                                  color: Colors.transparent,
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              );
                            },
                          );
                          // Capturar a tela quando o botão é pressionado
                          capturedImage = await screenshotController.capture(
                              delay: const Duration(seconds: 2));

                          // Salvar a imagem na galeria
                          await saveImageToGallery(
                              capturedImage: capturedImage);
                          carregandoRelatorio.value =
                              !carregandoRelatorio.value;
                          Navigator.of(context).pop();
                        },
                  icon: const Icon(Icons.cloud_download),
                  label: carregandoRelatorio.value
                      ? const Text('Carregando..')
                      : const Text('Baixar'));
            }),
      ),
    );
  }
  // Função para salvar a imagem na galeria
}

Future<void> saveImageToGallery({Uint8List? capturedImage}) async {
  if (capturedImage != null) {
    final result = await ImageGallerySaver.saveImage(capturedImage);
    print(result); // Imprime o caminho da imagem salva
  }
}

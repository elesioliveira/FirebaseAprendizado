// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_firebase/bindings/bindings.dart';
import 'package:teste_firebase/views/pages/base/view/pagina_base.dart';
import 'package:teste_firebase/views/pages/filtro_por_periodo/view/screen_page_filter.dart';
import 'package:teste_firebase/views/pages/filtro_por_periodo/view/screen_relatorio_carregado.dart';

import 'package:teste_firebase/views/pages/signin_or_signup/view/pagina_login.dart';
import 'firebase_options.dart';

Future<void> main() async {
  debugPaintSizeEnabled = true; // Ativar debug painting de tamanhos
  debugPaintBaselinesEnabled = false; // Ativar debug painting de baselines
  debugPaintLayerBordersEnabled =
      false; // Ativar debug painting de bordas de camada
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          vendaCubit,
          controllerClient,
          controllerNewSale,
          controllerFilterDateSale,
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const BaseScreen(),
        ));
  }
}

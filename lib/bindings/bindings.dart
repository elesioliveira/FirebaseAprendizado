import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_firebase/pages/Client/controller/bloc/client_cubit.dart';
import 'package:teste_firebase/pages/venda/blocs/venda/venda_cubit.dart';

final vendaCubit = BlocProvider<VendaCubit>(
  create: (context) => VendaCubit(),
);
final novoCliente = BlocProvider<NovoClienteController>(
  create: (context) => NovoClienteController(),
);

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_firebase/views/pages/Client/controller/bloc/client_cubit.dart';

import 'package:teste_firebase/views/pages/venda/controller/bloc/controller_cubit.dart';

final vendaCubit = BlocProvider<VendaCubit>(
  create: (context) => VendaCubit(),
);
final novoCliente = BlocProvider<ClientController>(
  create: (context) => ClientController(),
);

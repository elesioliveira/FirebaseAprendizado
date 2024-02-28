import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_firebase/views/pages/Client/controller/controller/client_cubit.dart';
import 'package:teste_firebase/views/pages/filtro_por_periodo/controller/filtro_cubit.dart';
import 'package:teste_firebase/views/pages/venda/controller/nova_venda_bloc/controller_add_new.dart';

import 'package:teste_firebase/views/pages/venda/controller/venda_bloc/controller_cubit.dart';

final vendaCubit = BlocProvider<VendaCubit>(
  create: (context) => VendaCubit(),
);
final controllerClient = BlocProvider<ClientController>(
  create: (context) => ClientController(),
);

final controllerNewSale = BlocProvider<AddNewSale>(
  create: (context) => AddNewSale(),
);

final controllerFilterDateSale = BlocProvider<FilterSaleToDate>(
  create: (context) => FilterSaleToDate(),
);

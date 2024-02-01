import 'package:custom_alert_snackbar/custom_alert_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_cep/search_cep.dart';
import 'package:teste_firebase/pages/NovoCliente/controller/bloc/novo_cliente_state.dart';

class EstadoControllersText extends Cubit<EstadoCliente> {
  EstadoControllersText() : super(EstadoInicialCliente());

  TextEditingController sobrenome = TextEditingController();
  TextEditingController nome = TextEditingController();
  TextEditingController cpf = TextEditingController();
  TextEditingController rg = TextEditingController();
  TextEditingController dataNascimento = TextEditingController();
  TextEditingController rua = TextEditingController();
  TextEditingController numero = TextEditingController();
  TextEditingController bairro = TextEditingController();
  TextEditingController cidade = TextEditingController();
  TextEditingController estado = TextEditingController();
  TextEditingController cep = TextEditingController();
  TextEditingController telefone1 = TextEditingController();
  TextEditingController telefone2 = TextEditingController();
  TextEditingController email = TextEditingController();
  final dadosPessoaisFormKey = GlobalKey<FormState>();
  final enderecoFormKey = GlobalKey<FormState>();
  final contatoFormKey = GlobalKey<FormState>();
  final FocusScopeNode focusScopeNode = FocusScopeNode();

  Future buscarCep(context, String cep) async {
    final postmonSearchCep = PostmonSearchCep();
    final infoCepJSON = await postmonSearchCep.searchInfoByCep(cep: '89036200');
    print(infoCepJSON);
    infoCepJSON.fold((searchInfoError) {
      CustomAlertSnack.init(context,
          size: MediaQuery.sizeOf(context),
          title: 'Erro ao buscar',
          text: 'Cep não encontrado',
          titleColor: Colors.white);
    }, (postmonSearchCep) {
      bairro.text = postmonSearchCep.bairro.toString();
      rua.text = postmonSearchCep.logradouro.toString();
      cidade.text = postmonSearchCep.cidade.toString();
      estado.text =
          postmonSearchCep.estadoInfo?.nome.toString() ?? 'sem informação';
      rua.text = postmonSearchCep.logradouro.toString();
    });
  }
}

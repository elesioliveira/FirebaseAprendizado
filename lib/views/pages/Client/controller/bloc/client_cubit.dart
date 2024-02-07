import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_alert_snackbar/custom_alert_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_cep/search_cep.dart';
import 'package:teste_firebase/views/pages/Client/controller/bloc/client_state.dart';
import 'package:teste_firebase/views/pages/Client/model/novo_cliente_model.dart';

class ClientController extends Cubit<EstadoCliente> {
  ClientController() : super(StateInitialClient());

  final List<Client> clients = [];
  TextEditingController nome = TextEditingController();
  TextEditingController cpf = TextEditingController();
  TextEditingController dataNascimento = TextEditingController();
  TextEditingController endereco = TextEditingController();
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

  void limparTodos() {
    nome.clear();
    cpf.clear();
    dataNascimento.clear();
    endereco.clear();
    numero.clear();
    bairro.clear();
    cidade.clear();
    estado.clear();
    telefone1.clear();
    telefone2.clear();
    email.clear();
  }

  Future fetchCep({context, required String cep}) async {
    final postmonSearchCep = PostmonSearchCep();
    final infoCepJSON = await postmonSearchCep.searchInfoByCep(cep: cep);

    infoCepJSON.fold((searchInfoError) {
      CustomAlertSnack.init(context,
          size: MediaQuery.sizeOf(context),
          title: 'Erro ao buscar',
          text: 'Cep não encontrado',
          titleColor: Colors.white);
    }, (postmonSearchCep) {
      bairro.text = postmonSearchCep.bairro.toString();
      endereco.text = postmonSearchCep.logradouro.toString();
      cidade.text = postmonSearchCep.cidade.toString();
      estado.text =
          postmonSearchCep.estadoInfo?.nome.toString() ?? 'sem informação';
      endereco.text = postmonSearchCep.logradouro.toString();
    });
  }

  Future<void> fetchClient() async {
    CollectionReference clientFireStore =
        FirebaseFirestore.instance.collection('cliente');
    try {
      QuerySnapshot data = await clientFireStore.get();
      for (QueryDocumentSnapshot documentSnapshot in data.docs) {
        Client client =
            Client.fromMap(documentSnapshot.data() as Map<String, dynamic>);
        clients.add(client);
        if (clients.isNotEmpty) {
          emit(StateSucessedClien(client: clients));
        } else {
          emit(StateInitialClient());
        }
      }
    } catch (e) {
      emit(StateErrorClient(mensagem: 'Erro ao carregar clientes'));
    }
  }

  Future<void> addNewClient(
      Client client, List<Client> clients, context) async {
    emit(StateLoadingClient());
    CollectionReference reference =
        FirebaseFirestore.instance.collection('cliente');

    if (clients.any((element) => element.cpf == client.cpf)) {
      CustomAlertSnack.init(context,
          size: MediaQuery.sizeOf(context),
          color: Colors.red,
          title: 'Erro',
          text: 'Cliente já existe',
          textAlign: TextAlign.center,
          alignCenter: true);
      return;
    }

    Map<String, dynamic> dados = {
      'nome': client.nome.toUpperCase(),
      'cpf': client.cpf.toUpperCase(),
      'dataNascimento': client.dataNascimento.toUpperCase(),
      'endereco': client.endereco.toUpperCase(),
      'numero': client.numero.toUpperCase(),
      'bairro': client.bairro.toUpperCase(),
      'cidade': client.cidade.toUpperCase(),
      'estado': client.estado.toUpperCase(),
      'cep': client.cep.toUpperCase(), // Remova o ponto e vírgula aqui
      'numeroResidencia': client.numeroResindencia?.toUpperCase(),
      'telefone1': client.telefone1?.toUpperCase(),
      'telefone2': client.telefone2?.toUpperCase(),
      'email': client.email?.toUpperCase(),
    };

    await reference.doc(client.cpf).set(dados).then((value) {
      CustomAlertSnack.init(context,
          size: MediaQuery.sizeOf(context),
          backgrounds: Colors.green[800],
          title: 'OK',
          text: 'Cliente adicionado com sucesso',
          textAlign: TextAlign.center,
          color: Colors.green[800],
          alignCenter: true);
      limparTodos();
      Navigator.pop(context);
    }).catchError((e) {
      CustomAlertSnack.init(context,
          size: MediaQuery.sizeOf(context),
          title: 'Erro',
          text: 'Erro ao adicionar o cliente',
          textAlign: TextAlign.center,
          alignCenter: true);
    });
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:teste_firebase/identity/controllers.dart';

class NovoUsuario extends StatefulWidget {
  const NovoUsuario({super.key});

  @override
  State<NovoUsuario> createState() => NovoUsuarioState();
}

class NovoUsuarioState extends State<NovoUsuario> {
  final SellControllers controllers = SellControllers();
  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> criandoUsuario = ValueNotifier<bool>(false);
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 10, top: 20),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 5, left: 10, right: 10, bottom: 4),
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                color: Color.fromARGB(52, 104, 58, 183)),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.arrow_back_ios,
                                  color: Color.fromARGB(75, 0, 0, 0),
                                ),
                                Text(
                                  'Back',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Expanded(
                          child: Text(
                            'Create Your Own Account',
                            style: TextStyle(
                                fontSize: 25, color: Colors.deepPurple),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: controllers.nome,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(labelText: 'Name'),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: controllers.telefone,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(labelText: 'Phone'),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: controllers.email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(labelText: 'Email'),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: controllers.senha,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: true,
                        decoration:
                            const InputDecoration(labelText: 'Password'),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 7,
                            child: Checkbox(
                              shape: const CircleBorder(),
                              value: true,
                              onChanged: (value) {},
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          const Text(
                            'I Agree to the ',
                            style: TextStyle(fontSize: 10),
                          ),
                          const Text(
                            'Terms of Service ',
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'and ',
                            style: TextStyle(fontSize: 10),
                          ),
                          const Text(
                            'Privacy Policy ',
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      ValueListenableBuilder(
                          valueListenable: criandoUsuario,
                          builder: (context, value, child) {
                            return ElevatedButton(
                              onPressed: criandoUsuario.value
                                  ? null
                                  : () async {
                                      criandoUsuario.value =
                                          !criandoUsuario.value;
                                      // função de registrar um novo usuário

                                      criandoUsuario.value =
                                          !criandoUsuario.value;
                                    },
                              child: Center(
                                child: criandoUsuario.value
                                    ? const CircularProgressIndicator()
                                    : const Text(
                                        'Sign Up',
                                        style: TextStyle(fontSize: 20),
                                      ),
                              ),
                            );
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      const Center(
                        child: Text('Or'),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'I Have on Account ',
                              style: TextStyle(fontWeight: FontWeight.w200),
                            ),
                            Text(
                              'Sign in Now',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

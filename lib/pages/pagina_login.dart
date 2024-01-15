import 'package:teste_firebase/pages/pagina_cadastrar_usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();
  ValueNotifier<bool> logandoSistema = ValueNotifier<bool>(false);
  ValueNotifier<bool> concordarTermos = ValueNotifier<bool>(false);

  Future<void> loginUsuario(String email, String senha) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: senha);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.only(right: 40, left: 40),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      'Well Come Back!',
                      style: TextStyle(
                          fontFamily: 'Italic',
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.deepPurple),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: senha,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(labelText: 'Password'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot password?',
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 7,
                        child: ListenableBuilder(
                          listenable: concordarTermos,
                          builder: (context, child) {
                            return Checkbox(
                              shape: const CircleBorder(),
                              value: concordarTermos.value,
                              onChanged: (value) {
                                concordarTermos.value = !concordarTermos.value;
                              },
                            );
                          },
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
                      )
                    ],
                  ),
                  ValueListenableBuilder(
                      valueListenable: logandoSistema,
                      builder: (context, value, child) {
                        return ElevatedButton(
                          onPressed: logandoSistema.value
                              ? null
                              : () async {
                                  logandoSistema.value = !logandoSistema.value;
                                  await loginUsuario(email.text, senha.text);
                                  logandoSistema.value = !logandoSistema.value;
                                },
                          child: Center(
                            child: logandoSistema.value
                                ? const CircularProgressIndicator()
                                : const Text(
                                    'Sign In',
                                    style: TextStyle(fontSize: 20),
                                  ),
                          ),
                        );
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  const Center(
                    child: Text(
                      'Or',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.05),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 45,
                                    child: Image.asset('assets/google.png'),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text('Google')
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 35,
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.05),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 45,
                                    child: Image.asset('assets/facebook.png'),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text('Facebook')
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Do not Have on Account! ',
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                      GestureDetector(
                        onTap: () {
                          print('clicou');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NovoUsuario()),
                          );
                        },
                        child: const Text(
                          'Create Account',
                          style: TextStyle(color: Colors.deepPurple),
                        ),
                      )
                    ],
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

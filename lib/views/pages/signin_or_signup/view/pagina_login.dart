import 'package:teste_firebase/views/pages/signin_or_signup/view/pagina_cadastrar_usuario.dart';
import 'package:flutter/material.dart';
import 'package:teste_firebase/views/pages/signin_or_signup/controller/controller_login.dart';

class LoginPagina extends StatefulWidget {
  const LoginPagina({super.key});

  @override
  State<LoginPagina> createState() => _LoginPaginaState();
}

class _LoginPaginaState extends State<LoginPagina> {
  late ControllerLogin controllerLogin;

  @override
  void initState() {
    super.initState();
    controllerLogin = ControllerLogin();
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
                    controller: controllerLogin.email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: controllerLogin.senha,
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
                          listenable: controllerLogin.concordarTermos,
                          builder: (context, child) {
                            return Checkbox(
                              shape: const CircleBorder(),
                              value: controllerLogin.concordarTermos.value,
                              onChanged: (value) {
                                controllerLogin.concordarTermos.value =
                                    !controllerLogin.concordarTermos.value;
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
                      valueListenable: controllerLogin.logandoSistema,
                      builder: (context, value, child) {
                        return ElevatedButton(
                          onPressed: controllerLogin.logandoSistema.value
                              ? null
                              : () async {
                                  controllerLogin.logandoSistema.value =
                                      !controllerLogin.logandoSistema.value;

                                  await controllerLogin
                                      .signInWithEmailAndPassword(
                                          controllerLogin.email.text,
                                          controllerLogin.senha.text,
                                          context);

                                  controllerLogin.logandoSistema.value =
                                      !controllerLogin.logandoSistema.value;
                                },
                          child: Center(
                            child: controllerLogin.logandoSistema.value
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NovoUsuario()),
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

import 'package:flutter/material.dart';

class ButtonIntoRow extends StatelessWidget {
  const ButtonIntoRow({
    Key? key,
    this.onTapAccept,
    this.onTapNegation,
    required this.accepet,
    required this.negation,
    required this.estaCarregando,
  }) : super(key: key);

  final void Function()? onTapAccept;
  final void Function()? onTapNegation;
  final String accepet;
  final String negation;
  final bool estaCarregando;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          style: ButtonStyle(
            overlayColor: const MaterialStatePropertyAll(Colors.white30),
            visualDensity: VisualDensity.comfortable,
            elevation: MaterialStateProperty.all(5),
            splashFactory: NoSplash.splashFactory,
            backgroundColor: MaterialStateProperty.all<Color>(
                Colors.white), // Cor de fundo padrão
            foregroundColor: MaterialStateProperty.all<Color>(
                Colors.deepPurple), // Cor do texto
            // Outras propriedades de estilo podem ser configuradas aqui
          ),
          onPressed: onTapNegation,
          child: Text(negation),
        ),
        const SizedBox(
          width: 15,
        ),
        ElevatedButton(
          style: ButtonStyle(
            visualDensity: VisualDensity.comfortable,
            elevation: MaterialStateProperty.all(5),
            backgroundColor: MaterialStateProperty.all<Color>(
                const Color.fromARGB(205, 104, 58, 183)), // Cor de fundo padrão
            foregroundColor:
                MaterialStateProperty.all<Color>(Colors.white), // Cor do texto
            // Outras propriedades de estilo podem ser configuradas aqui
          ),
          onPressed: onTapAccept,
          child: estaCarregando
              ? const Padding(
                  padding: EdgeInsets.all(5),
                  child:
                      CircularProgressIndicator(backgroundColor: Colors.white),
                )
              : Text(accepet),
        ),
        const SizedBox(
          width: 0,
        ),
      ],
    );
  }
}

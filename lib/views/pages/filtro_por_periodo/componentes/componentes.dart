import 'package:flutter/material.dart';

class CaixaCalendario {
  static Future<DateTime?> selecionarData(BuildContext context) async {
    DateTime dataSelecionada = DateTime.now();
    DateTime? data = await showDatePicker(
      context: context,
      // locale: const Locale('pt', 'BR'),
      initialDate: dataSelecionada,
      firstDate: DateTime(2024, 1, 1),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      confirmText: 'Confirmar',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.white,
              onPrimary: Colors.black,
              onPrimaryContainer: ThemeData().primaryColor,
              surface: ThemeData().primaryColor,
              onSurface: Colors.white,
              background: ThemeData().primaryColor,
              onBackground: ThemeData().primaryColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith(
                  (value) => Colors.white,
                ),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    dataSelecionada = data ?? DateTime.now();
    return data;
  }
}

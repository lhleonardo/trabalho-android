import 'package:flutter/material.dart';

/// Classe para controle centralizado do tema utilizado na aplicação,
/// incluindo cores, estilos, fontes e nomenclaturas.
class ThemeManager {
  // Tema principal
  static ThemeData defaultTheme() {
    return ThemeData(
      // TODO: Corrigir tamanho dos textos
      //em uma boa escala para aplicações mobile
      backgroundColor: const Color.fromRGBO(11, 19, 43, 1),
      accentColor: const Color.fromRGBO(91, 192, 190, 1),
      primaryColor: const Color.fromRGBO(58, 80, 107, 1),
      errorColor: Colors.redAccent[100],
      textTheme: const TextTheme(
        headline1: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.normal,
          color: Color.fromRGBO(240, 238, 238, 1),
        ),
        headline2: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.normal,
          color: Color.fromRGBO(240, 238, 238, 1),
        ),
        headline3: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.normal,
          color: Color.fromRGBO(240, 238, 238, 1),
        ),
        subtitle1: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: Color.fromRGBO(240, 238, 238, 1),
        ),
        caption: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Color.fromRGBO(240, 238, 238, 1),
        ),
      ),
      fontFamily: 'Raleway',
    );
  }
}

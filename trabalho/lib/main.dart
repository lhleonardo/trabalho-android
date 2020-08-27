import 'package:flutter/material.dart';
import 'package:trabalho/pages/home_scren.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // TODO: Corrigir tamanho dos textos em uma boa escala para aplicações mobile
        backgroundColor: Color.fromRGBO(11, 19, 43, 1),
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.normal,
            color: Color.fromRGBO(240, 238, 238, 1),
          ),
          headline3: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.normal,
            color: Color.fromRGBO(240, 238, 238, 1),
          ),
          subtitle1: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.normal,
            color: Color.fromRGBO(240, 238, 238, 1),
          ),
          caption: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.normal,
            color: Color.fromRGBO(240, 238, 238, 1),
          ),
        ),
        fontFamily: 'Raleway',
      ),
      home: HomeScreen(),
    );
  }
}

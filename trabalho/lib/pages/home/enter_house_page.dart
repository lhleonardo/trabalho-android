import 'package:flutter/material.dart';
import 'package:trabalho/components/button.dart';
import 'package:trabalho/components/input.dart';

class EnterHousePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 30, left: 10, right: 10),
              height: MediaQuery.of(context).size.height * 0.87,
              width: MediaQuery.of(context).size.height * 1,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(25)),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Align(
                    alignment: const Alignment(0.85, -0.85),
                    child: Column(
                      children: const [
                        Image(
                          image: AssetImage('assets/icons/logo.png'),
                          height: 30,
                          fit: BoxFit.fill,
                        ),
                        Text(
                          'RepApp',
                          style: TextStyle(
                            color: Color.fromRGBO(240, 238, 238, 1),
                            fontSize: 7,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  const Image(
                    image: AssetImage('assets/icons/group.png'),
                    height: 150,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  const Text(
                    'Entre para sua república',
                    style: TextStyle(
                      color: Color.fromRGBO(240, 238, 238, 1),
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      // ignore: lines_longer_than_80_chars
                      'Digite abaixo o código infomado por um representante para ingressar na sua república',
                      style: Theme.of(context).textTheme.caption,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: const Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Input(
                        placeholder: 'Código da república',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                  ),
                  Button(text: 'Finalizar', callback: () {}),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

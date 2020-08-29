import 'package:flutter/material.dart';
import 'package:trabalho/components/button.dart';
import 'package:trabalho/components/input.dart';

class EnterHousePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 25, bottom: 5),
            height: MediaQuery.of(context).size.height * 0.95,
            width: MediaQuery.of(context).size.height * 1,
            decoration: new BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Container(
                  child: Align(
                    alignment: Alignment(0.85, -0.85),
                    child: Column(
                      children: [
                        const Image(
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
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.13,
                ),
                Image(
                  image: AssetImage('assets/icons/group.png'),
                  height: 150,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Text(
                  'Entre para sua república',
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
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
                      placeholder: "Código da república",
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.10,
                ),
                Button(text: 'Avançar', callback: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

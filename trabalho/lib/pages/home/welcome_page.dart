import 'package:flutter/material.dart';
import 'package:trabalho/components/button.dart';
import 'package:trabalho/routes/routes.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
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
                    image: AssetImage('assets/icons/thumbs.png'),
                    height: 150,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Text(
                    'Parabéns',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Text(
                    'Seu cadastro foi realizado com sucesso !',
                    style: Theme.of(context).textTheme.caption,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.21,
                  ),
                  Text(
                    'Vamos para o próximo passo',
                    style: Theme.of(context).textTheme.caption,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Button(
                      text: 'Avançar',
                      callback: () {
                        Navigator.of(context).pushNamed(Routes.enterHousePage);
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

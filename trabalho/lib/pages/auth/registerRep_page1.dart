import 'package:flutter/material.dart';
import '../../routes/routes.dart';
import 'package:trabalho/components/input.dart';
import 'package:trabalho/components/button.dart';

class RegisterRepPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.13,
              ),
              Column(
                children: [
                  const Image(
                    image: AssetImage('assets/icons/logo.png'),
                    height: 150,
                    fit: BoxFit.fill,
                  ),
                  Text(
                    'RepApp',
                    style: Theme.of(context).textTheme.headline1,
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              Text(
                'Cadastra-se na plataforma',
                style: Theme.of(context).textTheme.headline3,
              ),
              Text(
                '1/2',
                style: Theme.of(context).textTheme.headline3,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Form(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0),
                        child: Input(
                          placeholder: 'Nome da república',
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0),
                        child: Input(
                          placeholder: 'Telefone',
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0),
                        child: Input(
                          placeholder: 'Data de criação',
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0),
                        child: Input(
                          placeholder: 'Cidade',
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0),
                        child: Input(
                          placeholder: 'Estado',
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      const Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Button(
                          placeholder: 'Próximo',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: FlatButton(
                  onPressed: () {},
                  child: Text(
                    'Já tem uma conta? Entrar',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:trabalho/components/input.dart';
import 'package:trabalho/components/dialogAlert.dart';
import '../../routes/routes.dart';

class LoginPage extends StatelessWidget {

  final Map<String, String> data= {};

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _inputValidator(String value) {

    if (value.trim().isEmpty) {
      return 'Insira o campo endereço de e-mail';
    }
    bool format = false;
    for (var i=0; i<value.length; i++) {
      if (value[i] == '@'){
        format = true;
      }
    }
    if (format == false) {
      return 'Insira um endereço de e-mail válido';
    }
    return null;
  }

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
                'Entre para continuar',
                style: Theme.of(context).textTheme.headline3,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Input(
                          obscureText: false,
                          placeholder: 'Endereço de e-mail',
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Insira um endereço de e-mail';
                            }
                            bool format = false;
                            for (var i=0; i<value.length; i++) {
                              if (value[i] == '@'){
                                format = true;
                              }
                            }
                            if (format == false) {
                              return 'Insira um endereço de e-mail válido';
                            }
                            return null;
                          },
                          onSaved: (value){
                            data['email'] = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Input(
                          obscureText: true,
                          placeholder: 'Senha',
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Insira uma senha';
                            }
                            return null;
                          },
                          onSaved: (value){
                            data['senha'] = value;
                          },
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Esqueceu sua senha?',
                            style: Theme.of(context).textTheme.caption,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.08,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 50,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: Theme.of(context).accentColor,
                            child: const Text(
                              'Entrar',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState.validate()){
                                
                              }
                              
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: FlatButton(
                  onPressed: () {
                    
                    showDialog(
                      context: context, 
                      builder: (context) => DialogAlert()
                    );
                  },
                  child: Text(
                    'Criar uma conta',
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

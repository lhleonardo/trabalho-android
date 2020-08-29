import 'package:flutter/material.dart';
import 'package:trabalho/components/input.dart';
import 'package:trabalho/components/button.dart';

class RegisterHouse extends StatefulWidget {
  @override
  _RegisterHouseState createState() => _RegisterHouseState();
}

class _RegisterHouseState extends State<RegisterHouse> {
  /// Controlador de scroll da página com intuito de fazer a tela
  /// ter o scroll para cima no momento de troca entre tela de cadastro do
  // usuário e da república
  ScrollController scrollController = ScrollController();
  int step = 1;
  final Map<String, String> data = {};
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _scrollToTop() {
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: const Duration(
        milliseconds: 300,
      ),
      curve: Curves.easeIn,
    );
  }

  Widget _houseForm() {
    return Center(
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
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Input(
                      placeholder: 'Nome da república',
                      validator: (value){
                        if (value.trim().isEmpty) {
                          return 'Insira o campo endereço de e-mail';
                        }
                        return null;
                      },
                      onSaved: (value){
                        data['nomeRep'] = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Input(
                      placeholder: 'Telefone',
                      keyboardType: TextInputType.number,
                      validator: (value){
                        if (value.trim().isEmpty) {
                          return 'Insira o campo endereço de e-mail';
                        }
                        if (value.trim().length <  11){
                          return 'Insira o número incluindo o DDD';
                        }
                        return null;
                      },
                      onSaved: (value){
                        data['telefone'] = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Input(
                      placeholder: 'Data de criação',
                      keyboardType: TextInputType.datetime,
                      validator: (value){
                        if (value.trim().isEmpty) {
                          return 'Insira o campo endereço de e-mail';
                        }
                        RegExp regExp = new RegExp(r'[0-9][0-9]/[0-9][0-9]/[0-9][0-9][0-9][0-9]');
                        if (!regExp.hasMatch(value)) {
                          print(regExp.hasMatch(value));
                          return 'A data precisa ser no formato: 01/01/2020';
                        }
                        int dia = int.parse(value[0]+value[1]);
                        int mes = int.parse(value[3]+value[4]);
                        if (dia > 31 || mes > 12){
                          return 'Insira uma data válida';
                        }
                        return null;
                      },
                      onSaved: (value){
                        data['telefone'] = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Input(
                      placeholder: 'Estado',
                      validator: (value){
                        if (value.trim().isEmpty) {
                          return 'Escolha um estado';
                        }
                        return null;
                      },
                      onSaved: (value){
                        data['estado'] = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Input(
                      placeholder: 'Cidade',
                      validator: (value){
                        if (value.trim().isEmpty) {
                          return 'Escolha uma cidade';
                        }
                        return null;
                      },
                      onSaved: (value){
                        data['cidade'] = value;
                      },
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Button(
                      text: 'Próximo',
                      callback: () => setState(() {
                        if (_formKey.currentState.validate()) {
                          _scrollToTop();
                          step = 2;
                        }
                      }),
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
    );
  }

  Widget _managerForm() {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30),
              height: 200,
              child: Stack(
                children: [
                  const Align(
                    alignment: Alignment.topCenter,
                    child: Image(
                      image: AssetImage('assets/icons/logo.png'),
                      height: 150,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'RepApp',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                        size: 40,
                      ),
                      onPressed: () => setState(() {
                        step = 1;
                        _scrollToTop();
                      }),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            Text(
              'Cadastra-se na plataforma',
              style: Theme.of(context).textTheme.headline3,
            ),
            Text(
              '2/2',
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
                        placeholder: 'Nome completo',
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Input(
                        placeholder: 'Apelido',
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Input(
                        placeholder: 'Data de Nascimento',
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Input(
                        placeholder: 'E-mail',
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Input(
                        placeholder: 'Senha',
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
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
                            'Cadastrar',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {},
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        controller: scrollController,
        child: step == 1 ? _houseForm() : _managerForm(),
      ),
    );
  }
}

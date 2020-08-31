import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  final TextEditingController _dateController1 = TextEditingController();
  final TextEditingController _dateController2 = TextEditingController();
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  //final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  final _formatter = DateFormat('dd/MM/yyyy');

  void _scrollToTop() {
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: const Duration(
        milliseconds: 300,
      ),
      curve: Curves.easeIn,
    );
  }

  void _submit() {
    if (_formKey1.currentState.validate()) {
      print('tudo certo');
    }
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
              key: _formKey1,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Input(
                      placeholder: 'Nome da república',
                      validator: (value) {
                        if (value.trim().isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        data['nomeRep'] = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Input(
                      placeholder: 'Telefone',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.trim().isEmpty) {
                          return 'Campo obrigatório';
                        }
                        if (value.trim().length < 11) {
                          return 'Insira o número incluindo o DDD';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        data['telefone'] = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Input(
                      placeholder: 'Data de criação',
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                      controller: _dateController1,
                      readOnly: true,
                      onSaved: (value) => data['dataCriacao'] = value,
                      onTap: () async {
                        final currentDate = _dateController1.text != null &&
                                _dateController1.text.isNotEmpty
                            ? _formatter.parse(_dateController1.text)
                            : DateTime.now();
                        final result = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1930),
                          lastDate: DateTime(2100),
                          initialDate: currentDate,
                        );

                        _dateController1.text = _formatter.format(result);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Input(
                      placeholder: 'Estado',
                      validator: (value) {
                        if (value.trim().isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        data['estado'] = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Input(
                      placeholder: 'Cidade',
                      validator: (value) {
                        if (value.trim().isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                      onSaved: (value) {
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
                        if (_formKey1.currentState.validate()) {
                          _formKey1.currentState.reset();
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
              onPressed: () {
                Navigator.pop(context);
              },
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
                key: _formKey1,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Input(
                        placeholder: 'Nome completo',
                        validator: (value) {
                          if (value.trim().isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          data['nomeCompleto'] = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Input(
                        placeholder: 'Apelido',
                        onSaved: (value) {
                          data['apelido'] = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Input(
                        placeholder: 'Data de Nascimento',
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                        controller: _dateController2,
                        readOnly: true,
                        onSaved: (value) => data['dataNascimento'] = value,
                        onTap: () async {
                          final currentDate = _dateController2.text != null &&
                                  _dateController2.text.isNotEmpty
                              ? _formatter.parse(_dateController2.text)
                              : DateTime.now();
                          final result = await showDatePicker(
                            context: context,
                            firstDate: DateTime(1930),
                            lastDate: DateTime(2100),
                            initialDate: currentDate,
                          );

                          _dateController2.text = _formatter.format(result);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Input(
                        placeholder: 'E-mail',
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          bool format = false;
                          for (var i = 0; i < value.length; i++) {
                            if (value[i] == '@') {
                              format = true;
                            }
                          }
                          if (format == false) {
                            return 'Insira um endereço de e-mail válido';
                          }
                          return null;
                        },
                        onSaved: (value) {
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
                          if (value.trim().isEmpty) {
                            return 'Campo obrigatório';
                          }
                          data['senha'] = value;
                          return null;
                        },
                        onSaved: (value) {
                          data['senha'] = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Input(
                        obscureText: true,
                        placeholder: 'Confirme a senha',
                        validator: (value) {
                          if (value.trim().isEmpty) {
                            return 'Campo obrigatório';
                          }
                          if (value.trim() != data['senha']) {
                            return 'Confirmação diferente da senha';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          data['senhaConfirmacao'] = value;
                        },
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
                          onPressed: () {
                            // ignore: lines_longer_than_80_chars
                            if (_formKey1.currentState.validate() == true) {
                              print('tudo certo');
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
                  Navigator.pop(context);
                },
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

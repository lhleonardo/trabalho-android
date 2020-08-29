import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trabalho/components/input.dart';
import 'package:trabalho/components/button.dart';
import 'package:trabalho/services/auth.dart';
import 'package:trabalho/utils/input_validators.dart';
import 'package:trabalho/utils/validator_alerts.dart';

class RegisterMember extends StatelessWidget {
  final Map<String, String> _formData = {};
  final TextEditingController _dateController = TextEditingController();
  final _formatter = DateFormat('dd/MM/yyyy');
  final GlobalKey<FormState> _formKey = GlobalKey();

  final AuthService _authService = AuthService();

  void _persist(String field, String value) {
    _formData[field] = value;
  }

  Future<void> _submit(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      ValidatorAlerts.showWarningMessage(
          context, 'Validação', 'Há campos que precisam de sua atenção!');
    }

    _formKey.currentState.save();

    try {
      await _authService.registerMember(
        name: _formData['name'],
        email: _formData['email'],
        nickname: _formData['nickname'],
        dateOfBirth: _formData['dateOfBirth'],
        password: _formData['password'],
        cpf: _formData['cpf'],
      );
    } catch (error) {
      print(error);
      print(error.toString());
    }
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
                'Cadastra-se na plataforma',
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
                          placeholder: 'Nome completo',
                          validator: InputValidators.NotEmpty,
                          onSaved: (value) => _persist('name', value),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Input(
                          placeholder: 'Apelido',
                          validator: InputValidators.NotEmpty,
                          onSaved: (value) => _persist('nickname', value),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Input(
                          placeholder: 'CPF',
                          validator: InputValidators.NotEmpty,
                          onSaved: (value) => _persist('cpf', value),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Input(
                          placeholder: 'Data de Nascimento',
                          validator: InputValidators.NotEmpty,
                          controller: _dateController,
                          readOnly: true,
                          onSaved: (value) => _persist('dateOfBirth', value),
                          onTap: () async {
                            final currentDate = _dateController.text != null &&
                                    _dateController.text.isNotEmpty
                                ? _formatter.parse(_dateController.text)
                                : DateTime.now();
                            final result = await showDatePicker(
                              context: context,
                              firstDate: DateTime(1930),
                              lastDate: DateTime(2100),
                              initialDate: currentDate,
                            );

                            _dateController.text = _formatter.format(result);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Input(
                          placeholder: 'Endereço de e-mail',
                          validator: InputValidators.NotEmpty,
                          onSaved: (value) => _persist('email', value),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Input(
                          placeholder: 'Senha',
                          validator: InputValidators.NotEmpty,
                          onSaved: (value) => _persist('password', value),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Button(
                          text: 'Cadastrar',
                          callback: () => _submit(context),
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

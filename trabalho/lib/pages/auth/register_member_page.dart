import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:trabalho/components/input.dart';
import 'package:trabalho/components/button.dart';
import 'package:trabalho/providers/member_provider.dart';
import 'package:trabalho/services/auth.dart';
import 'package:trabalho/utils/input_validators.dart';
import 'package:trabalho/utils/validator_alerts.dart';

class RegisterMember extends StatelessWidget {
  final Map<String, String> _formData = {};
  final TextEditingController _dateController = TextEditingController();
  final _formatter = DateFormat('dd/MM/yyyy');
  final GlobalKey<FormState> _formKey = GlobalKey();

  final AuthService _authService = AuthService();

  final _maskFormatterCpf = MaskTextInputFormatter(
      mask: '###.###.###-##', filter: {'#': RegExp('[0-9]')});

  void _persist(String field, String value) {
    _formData[field] = value;
  }

  Future<void> _submit(BuildContext context) async {
    final provider = Provider.of<MemberProvider>(context, listen: false);
    final progress = ValidatorAlerts.createProgress(context);
    if (!_formKey.currentState.validate()) {
      return;
    }

    FocusScope.of(context).unfocus();

    _formKey.currentState.save();

    await progress.show();
    try {
      final member = await _authService.registerMember(
        name: _formData['name'],
        email: _formData['email'],
        nickname: _formData['nickname'],
        dateOfBirth: _formData['dateOfBirth'],
        password: _formData['password'],
        cpf: _formData['cpf'],
      );

      provider.setLoggedMember(member);

      await progress.hide();

      // Fecha a tela após o cadastro
      Navigator.pop(context);
    } catch (error) {
      await progress.hide();
      ValidatorAlerts.showWarningMessage(context, 'Erro!',
          'Não foi possível cadastrar. Tente novamente mais tarde!');
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
                          labelText: 'Nome completo',
                          placeholder: 'Ex: João da Silva',
                          validator: InputValidators.NotEmpty,
                          onSaved: (value) => _persist('name', value),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Input(
                          labelText: 'Apelido',
                          placeholder: 'Ex: Joãozinho',
                          validator: InputValidators.NotEmpty,
                          onSaved: (value) => _persist('nickname', value),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Input(
                          labelText: 'CPF',
                          placeholder: 'Ex: 123.123.123-44',
                          keyboardType: TextInputType.number,
                          inputFormatter: _maskFormatterCpf,
                          validator: InputValidators.NotEmpty,
                          onSaved: (value) => _persist('cpf', value),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Input(
                          labelText: 'Data de Nascimento',
                          placeholder: 'Ex: 25/05/1999',
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
                          labelText: 'Endereço de e-mail',
                          placeholder: 'Ex: nome@mail.com',
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
                          onSaved: (value) => _persist('email', value),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Input(
                          labelText: 'Senha',
                          validator: (value) {
                            if (value.trim().isEmpty) {
                              return 'Campo obrigatório';
                            }

                            _persist('password', value);
                            return null;
                          },
                          obscureText: true,
                          onSaved: (value) => _persist('password', value),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Input(
                          obscureText: true,
                          labelText: 'Confirme a senha',
                          validator: (value) {
                            if (value.trim().isEmpty) {
                              return 'Campo obrigatório';
                            }
                            if (value.trim() != _formData['password']) {
                              return 'Confirmação diferente da senha';
                            }
                            return null;
                          },
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
      ),
    );
  }
}

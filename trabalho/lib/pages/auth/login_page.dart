import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:trabalho/components/input.dart';
import 'package:trabalho/components/dialogAlert.dart';
import 'package:trabalho/routes/routes.dart';
import 'package:trabalho/services/auth.dart';
import 'package:trabalho/utils/validator_alerts.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Map<String, String> data = {};
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _authService = AuthService();
  ProgressDialog _progress;

  String _inputValidator(String value) {
    if (value.isEmpty) {
      return 'Insira um endereço de e-mail';
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
  }

  Future<void> _submit(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      ValidatorAlerts.showWarningMessage(
          context, 'Validação', 'Preencha os campos para continuar');
    }

    _formKey.currentState.save();

    try {
      await _progress.show();
      final member = await _authService.signIn(
          email: data['email'], password: data['password']);
      await _progress.hide();

      if (member != null) {
        Navigator.of(context).pushReplacementNamed(Routes.homePage);
        print(member.house == null);
      }
    } on FirebaseAuthException catch (error) {
      await _progress.hide();
      String message;
      switch (error.code) {
        case 'user-not-found':
        case 'wrong-password':
          message = 'Usuário e/ou senha incorretos.';
          break;
        default:
          message = 'Algo de errado aconteceu. Tenta mais tarde.';
          break;
      }

      ValidatorAlerts.showWarningMessage(context, 'Autenticação', message);
    }
  }

  @override
  void initState() {
    super.initState();

    _progress = ValidatorAlerts.createProgress(context);
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
                          placeholder: 'Endereço de e-mail',
                          keyboardType: TextInputType.emailAddress,
                          validator: _inputValidator,
                          onSaved: (value) => data['email'] = value,
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
                          onSaved: (value) => data['password'] = value,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          // TODO: Implementar recuperação de senha!
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
                            onPressed: () => _submit(context),
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
                        context: context, builder: (context) => DialogAlert());
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

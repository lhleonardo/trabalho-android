import 'package:flutter/material.dart';
import 'package:trabalho/components/input.dart';
import 'package:trabalho/components/button.dart';
import 'package:trabalho/providers/member_provider.dart';
import 'package:trabalho/services/house.dart';
import 'package:trabalho/services/member.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trabalho/utils/validator_alerts.dart';
import 'package:trabalho/services/auth.dart';

import '../../../models/member.dart';

class AccountEditPage extends StatefulWidget {
  @override
  _AccountEditState createState() => _AccountEditState();
}

class _AccountEditState extends State<AccountEditPage> {
  /// Controlador de scroll da página com intuito de fazer a tela
  /// ter o scroll para cima no momento de troca entre tela de cadastro do
  // usuário e da república
  ScrollController scrollController = ScrollController();
  int step = 1;

  final Map<String, String> _formData = {};
  final _houseService = HouseService();
  final _memberService = MemberService();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _formatter = DateFormat('dd/MM/yyyy');
  final AuthService _authService = AuthService();

  void _scrollToTop() {
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: const Duration(
        milliseconds: 300,
      ),
      curve: Curves.easeIn,
    );
  }

  void _persist(String field, String value) {
    _formData[field] = value;
  }

  Future<void> _edit(BuildContext context) async {
    final provider = Provider.of<MemberProvider>(context, listen: false);
    final progress = ValidatorAlerts.createProgress(context);
    if (!_formKey.currentState.validate()) {
      return;
    }

    FocusScope.of(context).unfocus();

    _formKey.currentState.save();

    await progress.show();
    try {
      await _authService.editMember(
        name: _formData['name'],
        email: _formData['email'],
        nickname: _formData['nickname'],
        dateOfBirth: _formData['dateOfBirth'],
        userId: provider.loggedMember.id,
      );

      await provider.setLoggedMemberFor(provider.loggedMember.id);

      await progress.hide();

      //Volta para tela anterior
      step = 1;
      _scrollToTop();
    } catch (error) {
      await progress.hide();
      ValidatorAlerts.showWarningMessage(context, 'Erro!',
          'Não foi possível cadastrar. Tente novamente mais tarde!');
    }
  }

  Widget _informationMember(BuildContext context, MemberProvider provider) {
    return Center(
      child: StreamBuilder<List<Member>>(
        stream: _houseService.getManagers(provider.loggedMemberHouse.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          return Column(children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.edit,
                      color: Color.fromRGBO(240, 238, 238, 1)),
                  onPressed: () {
                    setState(() {
                      _scrollToTop();
                      step = 2;
                    });
                  },
                ),
              ),
            ),
            const Image(
              image: AssetImage('assets/icons/login.png'),
              height: 140,
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            FutureBuilder<Member>(
              future: _memberService.getById(provider.loggedMemberHouse.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: LinearProgressIndicator(),
                  );
                }

                return Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        alignment: Alignment.center,
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.person,
                                size: 24, color: Theme.of(context).accentColor),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              provider.loggedMember.name,
                              style: TextStyle(
                                  color: Color.fromRGBO(240, 238, 238, 1),
                                  fontSize: 16),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        height: 30,
                        color: Theme.of(context).primaryColor,
                        indent: 25,
                        endIndent: 25,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        alignment: Alignment.center,
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.mood,
                                size: 24, color: Theme.of(context).accentColor),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              provider.loggedMember.nickname,
                              style: TextStyle(
                                  color: Color.fromRGBO(240, 238, 238, 1),
                                  fontSize: 16),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        height: 30,
                        color: Theme.of(context).primaryColor,
                        indent: 25,
                        endIndent: 25,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        alignment: Alignment.center,
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.email,
                                size: 24, color: Theme.of(context).accentColor),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              provider.loggedMember.email,
                              style: TextStyle(
                                  color: Color.fromRGBO(240, 238, 238, 1),
                                  fontSize: 16),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        height: 30,
                        color: Theme.of(context).primaryColor,
                        indent: 25,
                        endIndent: 25,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        alignment: Alignment.center,
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.calendar_today,
                                size: 24, color: Theme.of(context).accentColor),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              provider.loggedMember.dateOfBirth,
                              style: TextStyle(
                                  color: Color.fromRGBO(240, 238, 238, 1),
                                  fontSize: 16),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        height: 30,
                        color: Theme.of(context).primaryColor,
                        indent: 25,
                        endIndent: 25,
                      ),
                    ],
                  ),
                );
              },
            ),
          ]);
        },
      ),
    );
  }

  Widget _memberForm(BuildContext context, MemberProvider provider) {
    final TextEditingController _dateController =
        TextEditingController(text: provider.loggedMember.dateOfBirth);
    return Center(
      child: StreamBuilder<List<Member>>(
        stream: _houseService.getManagers(provider.loggedMemberHouse.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          return Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.only(right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
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
                    ),
                    const Align(
                      alignment: Alignment.topRight,
                      child: Icon(Icons.edit, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const Image(
                image: AssetImage('assets/icons/login.png'),
                height: 140,
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              FutureBuilder<Member>(
                future: _memberService.getById(provider.loggedMemberHouse.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: LinearProgressIndicator(),
                    );
                  }

                  return Container(
                    alignment: Alignment.center,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            alignment: Alignment.center,
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.person,
                                    size: 24,
                                    color: Theme.of(context).accentColor),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.75,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 16.0),
                                    child: Input(
                                      labelText: 'Nome',
                                      initialValue: provider.loggedMember.name,
                                      validator: (value) {
                                        if (value.trim().isEmpty) {
                                          return 'Campo obrigatório';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) =>
                                          _persist('name', value),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            alignment: Alignment.center,
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.mood,
                                    size: 24,
                                    color: Theme.of(context).accentColor),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.75,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 16.0),
                                    child: Input(
                                      labelText: 'Apelido',
                                      initialValue:
                                          provider.loggedMember.nickname,
                                      validator: (value) {
                                        if (value.trim().isEmpty) {
                                          return 'Campo obrigatório';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) =>
                                          _persist('nickname', value),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            alignment: Alignment.center,
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.email,
                                    size: 24,
                                    color: Theme.of(context).accentColor),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.75,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 16.0),
                                    child: Input(
                                      labelText: 'Endereço de e-mail',
                                      initialValue: provider.loggedMember.email,
                                      validator: (value) {
                                        if (value.trim().isEmpty) {
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
                                      onSaved: (value) =>
                                          _persist('email', value),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            alignment: Alignment.center,
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.calendar_today,
                                    size: 24,
                                    color: Theme.of(context).accentColor),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.75,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 16.0),
                                    child: Input(
                                      labelText: 'Data de aniversário',
                                      readOnly: true,
                                      controller: _dateController,
                                      onSaved: (value) =>
                                          _persist('dateOfBirth', value),
                                      validator: (value) {
                                        if (value.trim().isEmpty) {
                                          return 'Campo obrigatório';
                                        }
                                        return null;
                                      },
                                      onTap: () async {
                                        final currentDate = DateFormat('d/M/yy')
                                            .parse(provider
                                                .loggedMember.dateOfBirth);

                                        final result = await showDatePicker(
                                          context: context,
                                          firstDate: DateTime(1930),
                                          lastDate: DateTime(2100),
                                          initialDate: currentDate,
                                        );

                                        _dateController.text =
                                            _formatter.format(result);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 25),
                          Button(
                              text: 'Salvar',
                              callback: () {
                                _edit(context);
                              }),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MemberProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        controller: scrollController,
        child: step == 1
            ? _informationMember(context, provider)
            : _memberForm(context, provider),
      ),
    );
  }
}

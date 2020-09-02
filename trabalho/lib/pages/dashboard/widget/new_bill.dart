import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trabalho/components/input.dart';
import 'package:trabalho/models/member.dart';
import 'package:trabalho/services/house.dart';
import '../../../providers/member_provider.dart';
import '../../../services/house.dart';
import '../../../services/member.dart';

class NewBillPage extends StatefulWidget {
  @override
  _NewBillPage createState() => _NewBillPage();
}

class _NewBillPage extends State<NewBillPage> {
  final Map<String, bool> _members = {};
  final MemberService _memberService = MemberService();
  final HouseService _houseService = HouseService();

  Widget _managerView(BuildContext context) {
    final provider = Provider.of<MemberProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Image(
                            image: AssetImage('assets/icons/RepIcon.png'),
                            height: 100,
                            width: 100,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: const <Widget>[
                              Text(
                                'Nome da República',
                                style: TextStyle(
                                    color: Color.fromRGBO(240, 238, 238, 1),
                                    fontSize: 14),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                'Criada 10/12/2017',
                                style: TextStyle(
                                    color: Color.fromRGBO(240, 238, 238, 1),
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: const Icon(Icons.edit),
                          color: const Color.fromRGBO(240, 238, 238, 1),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.only(top: 16.0, left: 20, right: 15),
                  child: Row(children: <Widget>[
                    Text('Nova despesa',
                        style: Theme.of(context).textTheme.headline3)
                  ]),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
                  child: Column(children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 16.0, left: 15, right: 15),
                      child: Input(
                        placeholder: 'Descrição da despesa',
                        validator: (value) {
                          if (value.trim().isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                        onSaved: (value) {},
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 16.0, left: 15, right: 15),
                      child: Input(
                        placeholder: 'Valor total',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.trim().isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                        onSaved: (value) {},
                      ),
                    ),
                  ]),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 10,
                          ),
                          Text('Pessoas que deverão pagar',
                              style: Theme.of(context).textTheme.subtitle1),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: StreamBuilder<List<Member>>(
                    stream: _houseService.getMembers(
                        houseId: provider.loggedMemberHouse.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: LinearProgressIndicator(),
                        );
                      }

                      final membersHouse = snapshot.data;

                      return Column(
                        children: membersHouse.map((memberItem) {
                          _members[memberItem.id] = false;

                          return Card(
                            color: Theme.of(context).primaryColor,
                            child: FutureBuilder<Member>(
                              future: _memberService.getById(memberItem.id),
                              builder: (context, member) {
                                if (member.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return CheckboxListTile(
                                  key: Key(memberItem.id),
                                  title: Text(
                                      '${member.data.name} (${member.data.nickname})'),
                                  value: _members[memberItem.id],
                                  onChanged: (value) =>
                                      (() => _members[memberItem.id] = value),
                                  activeColor: Colors.green,
                                  checkColor: Theme.of(context).backgroundColor,
                                );
                              },
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                  // child: Column(
                  //   children: List.generate(
                  //     5,
                  // (index) =>
                  // Card(
                  //   color: Theme.of(context).primaryColor,
                  //   child: CheckboxListTile(
                  //     //key: Key(),
                  //     title: Text('Nome do Membro (Apelido)'),
                  //     value: _validCheck,
                  //     onChanged: (value) {
                  //       setState(() {
                  //         _validCheck = value;
                  //       });
                  //     },
                  //     activeColor: Colors.green,
                  //     checkColor: Theme.of(context).backgroundColor,
                  //   ),
                  // ),
                  //   ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 10,
                          ),
                          Text('Total Selecionado: ',
                              style: Theme.of(context).textTheme.subtitle1),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 10,
                          ),
                          Text('Valor para cada (R\$): ',
                              style: Theme.of(context).textTheme.subtitle1),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, left: 5),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.92,
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _managerView(context);
  }
}

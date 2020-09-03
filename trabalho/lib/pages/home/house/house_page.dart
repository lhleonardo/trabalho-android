import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trabalho/components/bill_list_tile.dart';
import 'package:trabalho/models/bill.dart';
import 'package:trabalho/providers/member_provider.dart';
import 'package:trabalho/services/bill.dart';
import 'package:trabalho/services/house.dart';
import 'package:trabalho/services/member.dart';

import '../../../models/member.dart';
import '../bill/bill_form.dart';
import 'house_controll.dart';

class HouseViewPage extends StatelessWidget {
  final _houseService = HouseService();
  final _memberService = MemberService();
  final _billService = BillService();

  Widget _managerView(BuildContext context, MemberProvider provider) {
    return Column(
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        provider.loggedMemberHouse.name,
                        style: const TextStyle(
                          color: Color.fromRGBO(240, 238, 238, 1),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        'Criada desde ${provider.loggedMemberHouse.createdAt}',
                        style: const TextStyle(
                          color: Color.fromRGBO(240, 238, 238, 1),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
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
                  const Icon(
                    Icons.monetization_on,
                    color: Color.fromRGBO(240, 238, 238, 1),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text('Últimas Despesas',
                      style: Theme.of(context).textTheme.subtitle1),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.add_circle),
                color: Theme.of(context).accentColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => NewBillPage(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
          child: StreamBuilder<List<Bill>>(
            stream:
                _billService.getBillsForHouse(provider.loggedMemberHouse.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (!snapshot.hasData || snapshot.data.isEmpty) {
                return Center(
                  child: Text(
                    'Nenhuma despesa cadastrada.',
                    style: Theme.of(context).textTheme.caption,
                  ),
                );
              }

              return Column(
                children: snapshot.data
                    .map((bill) => BillListTile(
                          bill: bill,
                        ))
                    .toList(),
              );
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Icon(
                    Icons.work,
                    color: Color.fromRGBO(240, 238, 238, 1),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text('Representantes',
                      style: Theme.of(context).textTheme.subtitle1),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.add_circle),
                color: Theme.of(context).accentColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => HouseControllPage(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
        Container(
          height: 300,
          child: StreamBuilder<List<Member>>(
            stream: _houseService.getManagers(provider.loggedMemberHouse.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              return GridView.count(
                padding: const EdgeInsets.only(left: 16, right: 16),
                crossAxisCount: 4,
                crossAxisSpacing: 20,
                mainAxisSpacing: 16,
                children: snapshot.data.map((member) {
                  return Column(
                    children: <Widget>[
                      Icon(
                        Icons.supervised_user_circle,
                        color: Theme.of(context).primaryColor,
                        size: 35,
                      ),
                      FutureBuilder<Member>(
                        future: _memberService.getById(member.id),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: LinearProgressIndicator(),
                            );
                          }
                          return Text(
                            snapshot.data.nickname,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color.fromRGBO(240, 238, 238, 1),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }).toList(),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _memberWidget({BuildContext context, Member member, bool isManager}) {
    final split = member.name.split(' ');

    final sigla = split.length > 1
        ? ('${split[0][0].toUpperCase()}${split[1][0].toUpperCase()}')
        : split[0][0].toUpperCase();
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          height: 45,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(25),
              right: Radius.circular(15),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 70.0),
                child: Text(
                  member.name,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              Opacity(
                opacity: isManager ? 1 : 0,
                child: Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Icon(
                    Icons.verified_user,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(25),
            boxShadow: const [
              BoxShadow(
                blurRadius: 1,
                offset: Offset(3, 3),
              )
            ],
          ),
          child: Center(
            child: Text(
              sigla,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ),
      ],
    );
  }

  Widget _memberView(BuildContext context, MemberProvider provider) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Row(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    provider.loggedMemberHouse.name,
                    style: const TextStyle(
                      color: Color.fromRGBO(240, 238, 238, 1),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    'Criada desde ${provider.loggedMemberHouse.createdAt}',
                    style: const TextStyle(
                      color: Color.fromRGBO(240, 238, 238, 1),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.people_outline,
                color: Theme.of(context).accentColor,
                size: 35,
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text(
                  'Membros da Casa',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
          child: StreamBuilder<List<Member>>(
            stream: _houseService.getMembers(
                houseId: provider.loggedMemberHouse.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: LinearProgressIndicator(),
                );
              }

              return Column(
                children: snapshot.data
                    .map((memberItem) => Container(
                          margin: const EdgeInsets.only(bottom: 4),
                          child: FutureBuilder<Member>(
                              future: _memberService.getById(memberItem.id),
                              builder: (context, member) {
                                if (member.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return _memberWidget(
                                  context: context,
                                  member: member.data,
                                  isManager: memberItem.isManager,
                                );
                              }),
                        ))
                    .toList(),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MemberProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: provider.isManager
              ? _managerView(context, provider)
              : _memberView(context, provider),
        ),
      ),
    );
  }
}

class ItemTeste {
  String title;

  ItemTeste({this.title});
}

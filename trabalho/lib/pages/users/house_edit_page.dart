import 'package:flutter/material.dart';
import '../dashboard/widget/account_widget.dart';
import '../dashboard/widget/new_bill.dart';

class HouseEditPage extends StatelessWidget {
  final ItemTeste item1 = ItemTeste(title: 'teste1');
  final ItemTeste item2 = ItemTeste(title: 'teste1');
  final ItemTeste item3 = ItemTeste(title: 'teste1');
  final ItemTeste item4 = ItemTeste(title: 'teste1');
  final ItemTeste item5 = ItemTeste(title: 'teste1');
  final ItemTeste item6 = ItemTeste(title: 'teste1');

  Widget _managerView(BuildContext context) {
    final List<ItemTeste> myList = [item1, item2, item3, item4, item5, item6];
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
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
                              'Nome da república',
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
                            builder: (BuildContext context) => NewBillPage()
                          )
                        );
                      },
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
                child: Column(
                  children: List.generate(
                    5,
                    (index) => AccountWidget(),
                  ),
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
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              Container(
                height: 300,
                child: GridView.count(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  crossAxisCount: 4,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: myList.map((data) {
                    return Column(
                      children: <Widget>[
                        Icon(
                          Icons.supervised_user_circle,
                          color: Theme.of(context).primaryColor,
                          size: 35,
                        ),
                        Text(
                          data.title,
                          style: const TextStyle(
                              color: Color.fromRGBO(240, 238, 238, 1)),
                        )
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
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

class ItemTeste {
  String title;

  ItemTeste({this.title});
}

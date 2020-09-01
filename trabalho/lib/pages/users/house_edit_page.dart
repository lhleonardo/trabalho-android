import 'package:flutter/material.dart';
import '../dashboard/widget/account_widget.dart';

class HouseEditPage extends StatelessWidget {
  final ItemTeste item1 = ItemTeste(title: 'teste1');
  final ItemTeste item2 = ItemTeste(title: 'teste1');
  final ItemTeste item3 = ItemTeste(title: 'teste1');
  final ItemTeste item4 = ItemTeste(title: 'teste1');
  final ItemTeste item5 = ItemTeste(title: 'teste1');
  final ItemTeste item6 = ItemTeste(title: 'teste1');

  @override
  Widget build(BuildContext context) {
    final List<ItemTeste> myList = [item1, item2, item3, item4, item5, item6];
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 15),
          padding: const EdgeInsets.only(top: 25),
          height: MediaQuery.of(context).size.height * 1,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
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
              Row(
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
                          style: Theme.of(context).textTheme.caption),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle),
                    color: Theme.of(context).accentColor,
                    onPressed: () {},
                  )
                ],
              ),
              Column(
                children: List.generate(
                  5,
                  (index) => AccountWidget(),
                ),
              ),
              // child: ListView.builder(
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              //   itemCount: 4,
              //   itemBuilder: (_, index) => AccountWidget(),
              // ),

              Row(
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
                          style: Theme.of(context).textTheme.caption),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle),
                    color: Theme.of(context).accentColor,
                    onPressed: () {},
                  )
                ],
              ),
              Flexible(
                  flex: 3,
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
                      }).toList()))
            ],
          ),
        ),
      ),
    );
  }
}

class ItemTeste {
  String title;

  ItemTeste({this.title});
}

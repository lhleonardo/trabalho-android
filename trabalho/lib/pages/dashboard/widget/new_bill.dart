import 'package:flutter/material.dart';
import 'package:trabalho/components/input.dart';
import 'bill_widget.dart';

class NewBillPage extends StatelessWidget {
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
                  padding: const EdgeInsets.only(top: 16.0, left: 20, right: 15),
                  child: Row(
                    children: <Widget>[
                      Text('Nova despesa', style: Theme.of(context).textTheme.headline3)
                    ]
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, left: 15, right: 15),
                        child: Input(
                          placeholder: 'Descrição da despesa',
                          validator: (value) {
                            if (value.trim().isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          onSaved: (value) {
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, left: 15, right: 15),
                        child: Input(
                          placeholder: 'Valor total',
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.trim().isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          onSaved: (value) {
                          },
                        ),
                      ),
                    ]
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
                          Text('Pessoas que deverão pagar',
                              style: Theme.of(context).textTheme.subtitle1),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: Column(
                    children: List.generate(
                      5,
                      (index) => BillWidget(),
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
                            onPressed: (){},
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

class ItemTeste {
  String title;

  ItemTeste({this.title});
}
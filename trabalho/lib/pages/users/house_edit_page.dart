import 'package:flutter/material.dart';
import '../dashboard/card_list.dart';
import '../dashboard/widget/account_widget.dart';

class HouseEditPage extends StatelessWidget {
  ItemTeste item1 = new ItemTeste(title: 'teste1');
  ItemTeste item2 = new ItemTeste(title: 'teste1');
  ItemTeste item3 = new ItemTeste(title: 'teste1');
  ItemTeste item4 = new ItemTeste(title: 'teste1');
  ItemTeste item5 = new ItemTeste(title: 'teste1');
  ItemTeste item6 = new ItemTeste(title: 'teste1');

  
  @override
  Widget build(BuildContext context) {
  List<ItemTeste> myList = [item1,item2,item3,item4,item5,item6];
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 15),
          padding: EdgeInsets.only(top: 25),
          height: MediaQuery.of(context).size.height * 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Image(
                    image: AssetImage('assets/icons/RepIcon.png'),
                    height: 100,
                    width: 100,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: <Widget>[
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
                  SizedBox(
                    width: 100,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(Icons.edit),
                      color: Color.fromRGBO(240, 238, 238, 1),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.monetization_on,
                        color: Color.fromRGBO(240, 238, 238, 1),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Últimas Despesas',
                          style: Theme.of(context).textTheme.caption),
                    ],
                  )),
                  IconButton(
                    icon: Icon(Icons.add_circle),
                    color: Theme.of(context).accentColor,
                    onPressed: () {},
                  )
                ],
              ),
              new Flexible(
                flex: 3,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (_, index) => AccountWidget(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.work,
                        color: Color.fromRGBO(240, 238, 238, 1),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Representantes',
                          style: Theme.of(context).textTheme.caption),
                    ],
                  )),
                  IconButton(
                    icon: Icon(Icons.add_circle),
                    color: Theme.of(context).accentColor,
                    onPressed: () {},
                  )
                ],
              ),
              Flexible(
                flex: 3,
                  child: GridView.count(
                      childAspectRatio: 1,
                      padding: EdgeInsets.only(left: 16, right: 16),
                      crossAxisCount: 4,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      children: myList.map((data) {
                        return Container(
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.supervised_user_circle, color: Theme.of(context).primaryColor, size: 35,),
                              Text(data.title, style: TextStyle(color:  Color.fromRGBO(240, 238, 238, 1) ),)
                              ],
                          ),
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

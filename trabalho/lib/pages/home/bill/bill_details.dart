import 'package:flutter/material.dart';
import 'package:trabalho/components/member_bill.dart';
import 'package:trabalho/models/bill.dart';

class BillDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Bill bill = ModalRoute.of(context).settings.arguments as Bill;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                      size: 40,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(left: 25, right: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Image(
                              image: AssetImage(
                                  'assets/icons/${bill.category}.png'),
                              height: 80,
                              width: 80,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Supermercado',
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                        Container(
                          height: 35,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              color: Theme.of(context).accentColor),
                          child: FlatButton(
                            child: Text('Pagar',
                                style: TextStyle(
                                    color: Theme.of(context).backgroundColor,
                                    fontSize: 14),
                                textAlign: TextAlign.center),
                            onPressed: () {},
                          ),
                        )
                      ],
                    ),
                    Divider(
                      height: 30,
                      color: Theme.of(context).primaryColor,
                      indent: 5,
                      endIndent: 5,
                    ),
                    Row(
                      children: <Widget>[
                        const Icon(
                          Icons.adjust,
                          color: Color.fromRGBO(240, 238, 238, 1),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Descrição',
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      bill.description,
                      style: Theme.of(context).textTheme.caption,
                      textAlign: TextAlign.start,
                      softWrap: true,
                    ),
                    Divider(
                      height: 30,
                      color: Theme.of(context).primaryColor,
                      indent: 5,
                      endIndent: 5,
                    ),
                    // TODO: Falta terminar de listar:
                    // 1 - Membros de forma assíncrona
                    // preço a pagar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Valor:',
                            style: Theme.of(context).textTheme.subtitle1),
                        Row(
                          children: <Widget>[
                            Text('Pago:',
                                style: Theme.of(context).textTheme.subtitle1),
                            const SizedBox(
                              width: 2,
                            ),
                            const Icon(
                              Icons.cancel,
                              color: Colors.red,
                              size: 20,
                            )
                          ],
                        )
                      ],
                    ),
                    Divider(
                      height: 30,
                      color: Theme.of(context).primaryColor,
                      indent: 5,
                      endIndent: 5,
                    ),
                    Row(
                      children: <Widget>[
                        const Icon(
                          Icons.supervised_user_circle,
                          color: Color.fromRGBO(240, 238, 238, 1),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('Membros',
                            style: Theme.of(context).textTheme.subtitle1),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
                      child: Column(
                        children: List.generate(
                          5,
                          (index) => MemberBillWidget(),
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:trabalho/models/bill.dart';
import 'package:trabalho/routes/routes.dart';

class BillCard extends StatelessWidget {
  final Bill value;

  const BillCard({Key key, this.value}) : super(key: key);

  String _choiceLabel(String key) {
    String text = '';

    switch (key) {
      case 'water':
        text = 'Água/Esgoto';
        break;
      case 'aluguel':
        text = 'Aluguel e Casa';
        break;
      case 'compras':
        text = 'Compras e Supermercado';
        break;
      case 'limpeza':
        text = 'Limpeza';
        break;
      case 'luz':
        text = 'Luz/Energia elétrica';
        break;
      default:
        text = 'Outros';
        break;
    }

    return text;
  }

  @override
  Widget build(BuildContext context) {
    final accountThumbnail = Container(
      alignment: const FractionalOffset(0.0, 0.5),
      margin: const EdgeInsets.only(left: 8.0),
      child: Hero(
        tag: 'idBanco',
        child: Image(
          image: AssetImage('assets/icons/${value.category}.png'),
          height: 85,
          width: 85,
        ),
      ),
    );

    final accountCard = Container(
      margin: const EdgeInsets.only(left: 52.0, right: 24.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          )
        ],
      ),
      child: Container(
        margin: const EdgeInsets.only(top: 16.0, left: 62.0),
        constraints: const BoxConstraints.expand(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              value.description,
              style: const TextStyle(
                  color: Color.fromRGBO(240, 238, 238, 1), fontSize: 20.0),
            ),
            const SizedBox(height: 4),
            Text(
              _choiceLabel(value.category),
              style: const TextStyle(
                  color: Color.fromRGBO(240, 238, 238, 1), fontSize: 13.0),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              color: const Color(0xFF00C6FF),
              width: 34.0,
              height: 1.0,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    const Icon(Icons.attach_money,
                        size: 14.0, color: Colors.green),
                    const Text(
                      '15.00',
                      style: TextStyle(
                          color: Color.fromRGBO(240, 238, 238, 1),
                          fontSize: 12.0),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: Row(
                    children: [
                      const Icon(Icons.person,
                          size: 14.0, color: Colors.orange),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        '4/8',
                        style: TextStyle(
                            color: Color.fromRGBO(240, 238, 238, 1),
                            fontSize: 12.0),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );

    return Container(
      margin: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: FlatButton(
        //onPressed: () => _navigateTo(context),
        onPressed: () => Navigator.pushNamed(context, Routes.accountDetails),

        child: Stack(
          children: <Widget>[
            accountCard,
            accountThumbnail,
          ],
        ),
      ),
    );
  }

  /*
  _navigateTo(context) {
    Navigator.pushNamed(, Routes.welcomePage);
  }
  */
}

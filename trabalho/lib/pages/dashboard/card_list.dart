import 'package:flutter/material.dart';
import '../../routes/routes.dart';

class CardList extends StatelessWidget {
  //final Planet planet;

  //PlanetRow(this.planet);

  @override
  Widget build(BuildContext context) {
    final accountThumbnail = Container(
      alignment: const FractionalOffset(0.0, 0.5),
      margin: const EdgeInsets.only(left: 4.0),
      child: const Hero(
        tag: 'idBanco',
        child: Image(
          image: AssetImage('assets/icons/icon_mercado.png'),
          height: 100,
          width: 100,
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
            const Text(
              'Titulo da despesa',
              style: TextStyle(
                  color: Color.fromRGBO(240, 238, 238, 1), fontSize: 20.0),
            ),
            const Text(
              'Categoria da despesa',
              style: TextStyle(
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
              children: <Widget>[
                const Icon(Icons.attach_money, size: 14.0, color: Colors.green),
                const Text(
                  '15.00',
                  style: TextStyle(
                      color: Color.fromRGBO(240, 238, 238, 1), fontSize: 12.0),
                ),
                Container(width: 110.0),
                const Icon(Icons.person, size: 14.0, color: Colors.orange),
                const Text(
                  '4/8',
                  style: TextStyle(
                      color: Color.fromRGBO(240, 238, 238, 1), fontSize: 12.0),
                ),
              ],
            )
          ],
        ),
      ),
    );

    return Container(
      height: 120.0,
      margin: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: FlatButton(
        //onPressed: () => _navigateTo(context),
        onPressed: () => Navigator.pushNamed(context,Routes.accountDetails),

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

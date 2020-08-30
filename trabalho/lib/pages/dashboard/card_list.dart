import 'package:flutter/material.dart';

class CardList extends StatelessWidget {
  //final Planet planet;

  //PlanetRow(this.planet);

  @override
  Widget build(BuildContext context) {
    final planetThumbnail = new Container(
      alignment: new FractionalOffset(0.0, 0.5),
      margin: const EdgeInsets.only(left: 24.0),
      child: new Hero(
        tag: "dash",
        child: new Image(
          image: new AssetImage('assets/icons/icon_mercado.png'),
          height: 100,
          width: 100,
        ),
      ),
    );

    final planetCard = new Container(
      margin: const EdgeInsets.only(left: 72.0, right: 24.0),
      decoration: new BoxDecoration(
        color: Theme.of(context).primaryColor,
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
              color: Colors.black,
              blurRadius: 10.0,
              offset: new Offset(0.0, 10.0))
        ],
      ),
      child: new Container(
        margin: const EdgeInsets.only(top: 16.0, left: 72.0),
        constraints: new BoxConstraints.expand(),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(
              "Teste",
              style: TextStyle(
                  color: Colors.indigo,
                  fontSize: 24.0),
            ),
            new Text(
              "Localização",
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 14.0),
            ),
            new Container(
                color: const Color(0xFF00C6FF),
                width: 24.0,
                height: 1.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0)),
            new Row(
              children: <Widget>[
                new Icon(Icons.location_on, size: 14.0, color: Colors.red),
                new Text(
                  "Distancia",
                  style: TextStyle(
                      color: Color.fromRGBO(240, 238, 238, 1),

                      fontSize: 12.0),
                ),
                new Container(width: 24.0),
                new Icon(Icons.flight_land,
                    size: 14.0, color: Theme.of(context).accentColor),
                new Text(
                  "Gravidade",
                  style: TextStyle(
                      color: Color.fromRGBO(240, 238, 238, 1),
                      fontSize: 12.0),
                ),
              ],
            )
          ],
        ),
      ),
    );

    return new Container(
      height: 120.0,
      margin: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: new FlatButton(
        //onPressed: () => _navigateTo(context, planet.id),

        child: new Stack(
          children: <Widget>[
            planetCard,
            planetThumbnail,
          ],
        ),
      ),
    );
  }

  /*
  _navigateTo(context, String id) {
    Routes.navigateTo(
      context,
      '/detail/${planet.id}',
      transition: TransitionType.fadeIn
    );
  }
  */
}

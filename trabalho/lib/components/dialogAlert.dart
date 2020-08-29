import 'package:flutter/material.dart';
import '../routes/routes.dart';

class DialogAlert extends StatefulWidget {
  @override
  _DialogState createState() => _DialogState();
}

class _DialogState extends State<DialogAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      backgroundColor: Theme.of(context).primaryColor,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
            height: MediaQuery.of(context).size.height * 0.166,
            width: MediaQuery.of(context).size.height * 0.160,
            decoration: BoxDecoration(
              border:
                  Border.all(color: Theme.of(context).accentColor, width: 3),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            child: FlatButton(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Image(
                    image: AssetImage('assets/icons/member.png'),
                    height: 85,
                    //fit: BoxFit.fill,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Membro',
                    style: TextStyle(
                      color: Color.fromRGBO(240, 238, 238, 1),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              onPressed: () =>
                  Navigator.of(context).pushNamed(Routes.registerMember),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Container(
            padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
            height: MediaQuery.of(context).size.height * 0.166,
            width: MediaQuery.of(context).size.height * 0.166,
            decoration: BoxDecoration(
              border:
                  Border.all(color: Theme.of(context).accentColor, width: 3),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            child: FlatButton(
              child: Column(
                children: const [
                  Image(
                    image: AssetImage('assets/icons/house.png'),
                    height: 85,
                    //fit: BoxFit.fill,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Representante',
                    style: TextStyle(
                      color: Color.fromRGBO(240, 238, 238, 1),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              onPressed: () =>
                  Navigator.of(context).pushNamed(Routes.registerHouse),
            ),
          ),
        ],
      ),
    );
  }
}

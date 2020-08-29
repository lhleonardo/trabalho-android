import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Column(
          children: <Widget>[
            Text(
              "Nome do membro",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Nome da republica",
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
            ),
            color: Color.fromRGBO(240, 238, 238, 1),
          )
        ],
      ),
      body: Container(
        child: Text(_page.toString()),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        height: 56,
        items: <Widget>[
          Icon(Icons.person,
              size: 25, color: Theme.of(context).backgroundColor),
          Icon(Icons.dashboard,
              size: 25, color: Theme.of(context).backgroundColor),
          Icon(Icons.home, size: 25, color: Theme.of(context).backgroundColor),
        ],
        color: Theme.of(context).accentColor,
        buttonBackgroundColor: Theme.of(context).accentColor,
        backgroundColor: Theme.of(context).backgroundColor,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
    );
  }
}

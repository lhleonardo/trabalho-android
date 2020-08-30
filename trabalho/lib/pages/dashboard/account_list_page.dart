import 'package:flutter/material.dart';
import 'card_list.dart';

class Accountlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        color: Theme.of(context).backgroundColor,
        child: new ListView.builder(
          itemExtent: 160.0,
          itemCount: 1,
          itemBuilder: (_, index) => new CardList(),
        ),
      ),
    );
    /*
    return new Flexible(
      child: new Container(
        color: Theme.of(context).primaryColor,
        child: new ListView.builder(
          itemExtent: 160.0,
          itemCount: 1,
          itemBuilder: (_, index) => new CardList(),
        ),
      ),
    );
    */
  }
}

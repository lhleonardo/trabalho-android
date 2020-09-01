import 'package:flutter/material.dart';
import 'card_list.dart';

class Accountlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: ListView.builder(
          itemExtent: 160.0,
          itemCount: 1,
          itemBuilder: (_, index) => CardList(),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Algo de errado aconteceu',
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }
}

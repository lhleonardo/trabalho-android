import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Text(
              'Olá',
              style: Theme.of(context).textTheme.headline1,
            ),
            Text(
              'Olá',
              style: Theme.of(context).textTheme.headline3,
            ),
            Text(
              'Olá',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Text(
              'Olá',
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
    );
  }
}

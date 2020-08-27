import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage(
                'assets/icons/logo.png',
              ),
              fit: BoxFit.cover,
              height: 200,
            ),
            Text(
              'RepApp',
              style: Theme.of(context).textTheme.headline1,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}

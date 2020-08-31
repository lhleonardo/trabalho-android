import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trabalho/routes/routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StreamSubscription<User> _subscription;
  @override
  void initState() {
    super.initState();
    loading();
  }

  Future<void> loading() async {
    try {
      await Firebase.initializeApp();

      _subscription = FirebaseAuth.instance.authStateChanges().listen(
        (event) {
          _subscription.cancel();
          Timer(
            const Duration(seconds: 2),
            () {
              Navigator.of(context).pushReplacementNamed(Routes.wrapper);
            },
          );
        },
      );
    } catch (error) {
      Navigator.pushReplacementNamed(context, Routes.errorPage);
    }
  }

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
              padding: EdgeInsets.only(top: 40.0),
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}

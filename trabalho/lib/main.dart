import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:trabalho/pages/error_page.dart';
import 'package:trabalho/pages/splash_screen.dart';
import 'package:trabalho/theme/theme_manager.dart';
import 'package:trabalho/wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeManager.defaultTheme(),
      home: Startup(),
      // routes: ,
    );
  }
}

class Startup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> app = Firebase.initializeApp();

    return FutureBuilder<FirebaseApp>(
      future: app,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return ErrorPage();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return Wrapper();
        }

        return SplashScreen();
      },
    );
  }
}

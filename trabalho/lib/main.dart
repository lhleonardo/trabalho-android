import 'package:flutter/material.dart';
import 'package:trabalho/pages/home/enter_house_page.dart';
import 'package:trabalho/pages/home/home_page.dart';
import 'package:trabalho/pages/home/welcome_page.dart';
import 'package:trabalho/pages/auth/register_member_page.dart';
import 'package:trabalho/pages/error_page.dart';
import 'package:trabalho/pages/splash_screen.dart';
import 'package:trabalho/theme/theme_manager.dart';
import 'package:trabalho/wrapper.dart';
import 'pages/auth/login_page.dart';
import 'pages/auth/register_house.dart';
import 'routes/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeManager.defaultTheme(),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        Routes.homePage: (_) => HomePage(),
        Routes.loginPage: (_) => LoginPage(),
        Routes.registerHouse: (_) => RegisterHouse(),
        Routes.registerMember: (_) => RegisterMember(),
        Routes.welcomePage: (_) => WelcomePage(),
        Routes.enterHousePage: (_) => EnterHousePage(),
        Routes.errorPage: (_) => ErrorPage(),
        Routes.wrapper: (_) => Wrapper(),
      },
    );
  }
}

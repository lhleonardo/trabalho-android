import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trabalho/pages/auth/login_page.dart';
import 'package:trabalho/pages/home/home_page.dart';
import 'package:trabalho/providers/house_provider.dart';
import 'package:trabalho/providers/member_provider.dart';
import 'package:trabalho/services/auth.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final _authService = AuthService();

  Widget _currentWidget;

  Widget _homePage() {
    return HomePage();
  }

  Widget _loginPage() {
    return LoginPage();
  }

  @override
  void initState() {
    super.initState();

    _authService.user.listen((user) {
      setState(() {
        if (user == null) {
          _currentWidget = _loginPage();
        } else {
          _currentWidget = _homePage();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HouseProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MemberProvider(),
        )
      ],
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _currentWidget,
      ),
    );
  }
}

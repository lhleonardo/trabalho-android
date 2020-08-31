import 'package:flutter/material.dart';
import 'package:trabalho/pages/auth/login_page.dart';
import 'package:trabalho/pages/home/home_page.dart';
import 'package:trabalho/services/auth.dart';
import 'package:trabalho/services/member.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final _authService = AuthService();
  final _memberService = MemberService();

  Widget _currentWidget;

  Widget _homePage(String userId) {
    return HomePage();
  }

  Widget _loginPage() {
    return LoginPage();
  }

  @override
  void initState() {
    super.initState();

    _authService.user.listen(
      (user) {
        setState(() {
          if (user == null) {
            _currentWidget = _loginPage();
          } else {
            _currentWidget = _homePage(user.uid);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _currentWidget,
    );
  }
}

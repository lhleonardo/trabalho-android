import 'package:flutter/material.dart';
import 'package:trabalho/pages/auth/login_page.dart';

import 'pages/home_page.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const logged = false;
    return logged ? HomePage() : LoginPage();
  }
}

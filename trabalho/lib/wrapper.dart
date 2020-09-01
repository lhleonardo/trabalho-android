import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trabalho/pages/auth/login_page.dart';
import 'package:trabalho/pages/home/home_page.dart';

import 'providers/member_provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MemberProvider provider = Provider.of(context);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: provider.loggedMember == null ? LoginPage() : HomePage(),
    );
  }
}

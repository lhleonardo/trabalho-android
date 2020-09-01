import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trabalho/pages/dashboard/account_details_page.dart';
import 'package:trabalho/pages/home/welcome_page.dart';
import 'package:trabalho/providers/member_provider.dart';
import 'package:trabalho/services/auth.dart';
import 'package:trabalho/utils/validator_alerts.dart';

import '../dashboard/account_list_page.dart';
import '../users/house_edit_page.dart';
import '../users/member_edit_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final int _page = 1;
  final _authService = AuthService();

  final Accountlist _accountlist = Accountlist();
  final HouseEditPage _houseEditPage = HouseEditPage();
  final MemberEditPage _memberEditPage = MemberEditPage();

  Widget _showPage = Accountlist();

  Widget _pageChosser(int page) {
    switch (page) {
      case 0:
        return _memberEditPage;
        break;
      case 1:
        return _accountlist;
        break;
      default:
        return _houseEditPage;
        break;
    }
  }

  Widget _home() {
    final progress = ValidatorAlerts.createProgress(context);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(86),
        child: AppBar(
          flexibleSpace: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 12.0,
                  ),
                  child: Consumer<MemberProvider>(
                    builder: (context, provider, child) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          provider.loggedMember.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.normal,
                            color: Color.fromRGBO(240, 238, 238, 1),
                          ),
                        ),
                        Text(
                          provider.loggedMemberHouse.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Color.fromRGBO(240, 238, 238, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.exit_to_app,
                    size: 30.0,
                  ),
                  color: const Color.fromRGBO(240, 238, 238, 1),
                  onPressed: () async {
                    await progress.show();
                    await _authService.logout();
                    Provider.of<MemberProvider>(context, listen: false)
                        .logout();
                    await progress.hide();
                  },
                )
              ],
            ),
          ),
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: _showPage,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _page,
        height: 56,
        items: <Widget>[
          Icon(
            Icons.person,
            size: 25,
            color: Theme.of(context).backgroundColor,
          ),
          Icon(
            Icons.dashboard,
            size: 25,
            color: Theme.of(context).backgroundColor,
          ),
          Icon(
            Icons.home,
            size: 25,
            color: Theme.of(context).backgroundColor,
          ),
        ],
        color: Theme.of(context).accentColor,
        buttonBackgroundColor: Theme.of(context).accentColor,
        backgroundColor: Theme.of(context).backgroundColor,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (int tappedIndex) {
          setState(
            () {
              _showPage = _pageChosser(tappedIndex);
            },
          );
        },
      ),
    );
  }

  Widget _welcome() {
    return WelcomePage();
  }

  @override
  Widget build(BuildContext context) {
    final MemberProvider provider = Provider.of<MemberProvider>(context);

    if (provider.loggedMemberHouse == null) {
      return _welcome();
    } else {
      return _home();
    }
  }
}

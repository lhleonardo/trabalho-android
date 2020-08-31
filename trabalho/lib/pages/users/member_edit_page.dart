import 'package:flutter/material.dart';
import 'package:trabalho/components/input.dart';
import 'package:trabalho/components/button.dart';

class MemberEditPage extends StatefulWidget {
  @override
  _MemberEditState createState() => _MemberEditState();
}

class _MemberEditState extends State<MemberEditPage> {
  /// Controlador de scroll da página com intuito de fazer a tela
  /// ter o scroll para cima no momento de troca entre tela de cadastro do
  // usuário e da república
  ScrollController scrollController = ScrollController();
  int step = 1;

  void _scrollToTop() {
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: const Duration(
        milliseconds: 300,
      ),
      curve: Curves.easeIn,
    );
  }

  Widget _informationMember() {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.edit,
                    color: Color.fromRGBO(240, 238, 238, 1)),
                onPressed: () {
                  setState(() {
                    _scrollToTop();
                    step = 2;
                  });
                },
              ),
            ),
          ),
          const Image(
            image: AssetImage('assets/icons/Vector.png'),
            height: 120,
            fit: BoxFit.fill,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Container(
            margin: const EdgeInsets.only(left: 15),
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                Icon(Icons.person,
                    size: 24, color: Theme.of(context).accentColor),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Gabrielle Almeida Cuba',
                  style: TextStyle(
                      color: Color.fromRGBO(240, 238, 238, 1), fontSize: 16),
                )
              ],
            ),
          ),
          Divider(
            height: 30,
            color: Theme.of(context).primaryColor,
            indent: 25,
            endIndent: 25,
          ),
          Container(
            margin: const EdgeInsets.only(left: 15),
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                Icon(Icons.mood,
                    size: 24, color: Theme.of(context).accentColor),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Apelido',
                  style: TextStyle(
                      color: Color.fromRGBO(240, 238, 238, 1), fontSize: 16),
                )
              ],
            ),
          ),
          Divider(
            height: 30,
            color: Theme.of(context).primaryColor,
            indent: 25,
            endIndent: 25,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20),
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                Icon(Icons.email,
                    size: 24, color: Theme.of(context).accentColor),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Endereço de e-mail',
                  style: TextStyle(
                      color: Color.fromRGBO(240, 238, 238, 1), fontSize: 16),
                )
              ],
            ),
          ),
          Divider(
            height: 30,
            color: Theme.of(context).primaryColor,
            indent: 25,
            endIndent: 25,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20),
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                Icon(Icons.calendar_today,
                    size: 24, color: Theme.of(context).accentColor),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  '11/11/1111',
                  style: TextStyle(
                      color: Color.fromRGBO(240, 238, 238, 1), fontSize: 16),
                )
              ],
            ),
          ),
          Divider(
            height: 30,
            color: Theme.of(context).primaryColor,
            indent: 25,
            endIndent: 25,
          ),
        ],
      ),
    );
  }

  Widget _memberForm() {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.only(right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                      size: 40,
                    ),
                    onPressed: () => setState(() {
                      step = 1;
                      _scrollToTop();
                    }),
                  ),
                ),
                const Align(
                  alignment: Alignment.topRight,
                  child: Icon(Icons.edit, color: Colors.grey),
                ),
              ],
            ),
          ),
          const Image(
            image: AssetImage('assets/icons/Vector.png'),
            height: 120,
            fit: BoxFit.fill,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20),
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                Icon(Icons.person,
                    size: 24, color: Theme.of(context).accentColor),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Input(
                      placeholder: 'Gabrielle Almeida Cuba',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.only(left: 20),
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                Icon(Icons.mood,
                    size: 24, color: Theme.of(context).accentColor),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Input(
                      placeholder: 'Apelido',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.only(left: 20),
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                Icon(Icons.email,
                    size: 24, color: Theme.of(context).accentColor),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Input(
                      placeholder: 'Endereço de e-mail',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.only(left: 20),
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                Icon(Icons.calendar_today,
                    size: 24, color: Theme.of(context).accentColor),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Input(
                      placeholder: '11/11/111',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          Button(text: 'Finalizar', callback: () {}),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        controller: scrollController,
        child: step == 1 ? _informationMember() : _memberForm(),
      ),
    );
  }
}

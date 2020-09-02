import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trabalho/components/input.dart';
import 'package:trabalho/models/member.dart';
import 'package:trabalho/services/house.dart';
import '../../../providers/member_provider.dart';
import '../../../services/house.dart';

class NewBillPage extends StatefulWidget {
  @override
  _NewBillPage createState() => _NewBillPage();
}

class _NewBillPage extends State<NewBillPage> {
  final Map<String, bool> _members = {};
  final HouseService _houseService = HouseService();
  final Map<String, String> _data = {};
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Member> _membersList = [];
  bool _isLoading = true;

  String _selectedCategory;

  Future<void> _loadMembers() async {
    final provider = Provider.of<MemberProvider>(context, listen: false);
    _membersList =
        await _houseService.getCommomMembers(provider.loggedMemberHouse.id);

    _membersList.forEach((member) {
      _members[member.id] = false;
    });

    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();

    _loadMembers();
  }

  Widget _categoryWidget(String category, String description) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: (category == _selectedCategory)
            ? Border.all(
                width: 3.0,
                color: Theme.of(context).accentColor,
              )
            : null,
        boxShadow: const [
          BoxShadow(
            offset: Offset(2, 2),
            blurRadius: 2,
          ),
        ],
      ),
      child: FlatButton(
        onPressed: () => setState(() => _selectedCategory = category),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icons/$category.png', width: 44),
            const SizedBox(height: 10),
            Text(description, style: Theme.of(context).textTheme.subtitle1)
          ],
        ),
      ),
    );
  }

  Widget _managerView(BuildContext context, MemberProvider provider) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
          child: Row(
            children: [
              const Image(
                image: AssetImage('assets/icons/RepIcon.png'),
                height: 100,
                width: 100,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'Nome da República',
                    style: TextStyle(
                        color: Color.fromRGBO(240, 238, 238, 1), fontSize: 14),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    'Criada 10/12/2017',
                    style: TextStyle(
                        color: Color.fromRGBO(240, 238, 238, 1), fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 16.0, left: 20, right: 15),
          child: Row(children: <Widget>[
            Text('Nova despesa', style: Theme.of(context).textTheme.headline2)
          ]),
        ),
        Container(
            margin: const EdgeInsets.only(top: 6, left: 5, right: 5),
            child: Form(
              key: _formKey,
              child: Column(children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(top: 16.0, left: 15, right: 15),
                  child: Input(
                    placeholder: 'Descrição da despesa',
                    validator: (value) {
                      if (value.trim().isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _data['descricao'] = value;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 16.0, left: 15, right: 15),
                  child: Input(
                    placeholder: 'Valor total',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.trim().isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _data['valor'] = value;
                    },
                  ),
                ),
              ]),
            )),
        const SizedBox(height: 22),
        Container(
          height: 250,
          child: GridView.count(
            padding: const EdgeInsets.only(left: 16, right: 16),
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 14,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _categoryWidget('water', 'Água'),
              _categoryWidget('aluguel', 'Aluguel'),
              _categoryWidget('compras', 'Compras'),
              _categoryWidget('limpeza', 'Limpeza'),
              _categoryWidget('luz', 'Luz'),
              _categoryWidget('outros', 'Outros'),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 16, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const SizedBox(
                    width: 10,
                  ),
                  Text('Pessoas que deverão pagar',
                      style: Theme.of(context).textTheme.headline3),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
          child: Column(
            children: _membersList
                .map(
                  (member) => Card(
                    color: Theme.of(context).primaryColor,
                    child: CheckboxListTile(
                      key: Key(member.id),
                      title: Text(member.nickname),
                      value: _members[member.id],
                      onChanged: (value) {
                        setState(() {
                          _members[member.id] = value;
                        });
                      },
                      activeColor: Colors.green,
                      checkColor: Theme.of(context).backgroundColor,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const SizedBox(
                    width: 10,
                  ),
                  Text('Total Selecionado: ',
                      style: Theme.of(context).textTheme.subtitle1),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const SizedBox(
                    width: 10,
                  ),
                  Text('Valor para cada (R\$): ',
                      style: Theme.of(context).textTheme.subtitle1),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 5),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.92,
                  height: 50,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Theme.of(context).accentColor,
                    child: const Text(
                      'Cadastrar',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : _managerView(context, Provider.of<MemberProvider>(context)),
          ),
        ),
      ),
    );
  }
}
